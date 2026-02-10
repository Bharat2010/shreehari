using System;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using System.Web;
using System.Web.Caching;

namespace SHRJ
{
    public class imgHandler : IHttpHandler
    {
        // Root physical folder where images exist
        private const string BASE_PHYSICAL_PATH = @"D:\DesignImages\";

        // Placeholder image inside BASE_PHYSICAL_PATH
        private const string PLACEHOLDER_FILENAME = "No_Image_Available.jpg";

        public void ProcessRequest(HttpContext context)
        {
            context.Response.Clear();

            // ─────────────────────────────────────────────
            // Validate DesignID
            // ─────────────────────────────────────────────
            if (!int.TryParse(context.Request.QueryString["id"], out int designId) || designId <= 0)
            {
                SendPlaceholder(context);
                return;
            }

            // ─────────────────────────────────────────────
            // Read image index (0,1,2...)
            // ─────────────────────────────────────────────
            int index = 0;
            int.TryParse(context.Request.QueryString["index"], out index);

            // ─────────────────────────────────────────────
            // Fetch image path
            // ─────────────────────────────────────────────
            string dbImagePath = GetCachedImagePath(designId, index);

            if (string.IsNullOrWhiteSpace(dbImagePath))
            {
                SendPlaceholder(context);
                return;
            }

            // ─────────────────────────────────────────────
            // Normalize DB path → physical path
            // ─────────────────────────────────────────────
            string relative = dbImagePath.Trim().TrimStart('/');

            if (relative.StartsWith("DesignImages/", StringComparison.OrdinalIgnoreCase))
                relative = relative.Substring("DesignImages/".Length);
            else if (relative.StartsWith("DesignImages\\", StringComparison.OrdinalIgnoreCase))
                relative = relative.Substring("DesignImages\\".Length);

            relative = relative
                .Replace('/', Path.DirectorySeparatorChar)
                .Replace('\\', Path.DirectorySeparatorChar);

            string fullPhysicalPath = Path.Combine(BASE_PHYSICAL_PATH, relative);

            if (!File.Exists(fullPhysicalPath))
            {
                SendPlaceholder(context);
                return;
            }

            // ─────────────────────────────────────────────
            // MIME type
            // ─────────────────────────────────────────────
            string ext = Path.GetExtension(fullPhysicalPath)?.ToLowerInvariant() ?? ".jpg";
            string contentType;

            switch (ext)
            {
                case ".jpg":
                case ".jpeg": contentType = "image/jpeg"; break;
                case ".png": contentType = "image/png"; break;
                case ".gif": contentType = "image/gif"; break;
                case ".webp": contentType = "image/webp"; break;
                case ".bmp": contentType = "image/bmp"; break;
                case ".svg": contentType = "image/svg+xml"; break;
                case ".ico": contentType = "image/x-icon"; break;
                default: contentType = "image/jpeg"; break;
            }

            // ─────────────────────────────────────────────
            // Send image
            // ─────────────────────────────────────────────
            try
            {
                context.Response.ContentType = contentType;
                context.Response.Cache.SetCacheability(HttpCacheability.Public);
                context.Response.Cache.SetExpires(DateTime.UtcNow.AddDays(7));
                context.Response.TransmitFile(fullPhysicalPath);
            }
            catch
            {
                SendPlaceholder(context);
            }
        }

        // ─────────────────────────────────────────────
        // Placeholder
        // ─────────────────────────────────────────────
        private void SendPlaceholder(HttpContext context)
        {
            string placeholderPath = Path.Combine(BASE_PHYSICAL_PATH, PLACEHOLDER_FILENAME);

            if (File.Exists(placeholderPath))
            {
                try
                {
                    context.Response.ContentType = "image/jpeg";
                    context.Response.Cache.SetCacheability(HttpCacheability.Public);
                    context.Response.Cache.SetExpires(DateTime.UtcNow.AddDays(30));
                    context.Response.TransmitFile(placeholderPath);
                    return;
                }
                catch { }
            }

            // Final fallback: 1×1 transparent PNG
            byte[] pixel = Convert.FromBase64String(
                "iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR42mNkYAAAAAYAAjCB0C8AAAAASUVORK5CYII=");

            context.Response.ContentType = "image/png";
            context.Response.Cache.SetCacheability(HttpCacheability.NoCache);
            context.Response.OutputStream.Write(pixel, 0, pixel.Length);
        }

        // ─────────────────────────────────────────────
        // DB + Cache (INDEX BASED)
        // ─────────────────────────────────────────────
        private string GetCachedImagePath(int designId, int index)
        {
            string cacheKey = $"IMG_{designId}_{index}";

            if (HttpRuntime.Cache[cacheKey] is string cached && !string.IsNullOrEmpty(cached))
                return cached;

            string cs = ConfigurationManager.ConnectionStrings["eJewelDBs"]?.ConnectionString;
            if (string.IsNullOrEmpty(cs))
                return null;

            string path = null;

            try
            {
                using (SqlConnection con = new SqlConnection(cs))
                using (SqlCommand cmd = new SqlCommand(
                    @"SELECT ImagePath
              FROM DesignImages
              WHERE DesignID = @id
             ", con))
                {
                    cmd.Parameters.AddWithValue("@id", designId);
                    cmd.Parameters.AddWithValue("@idx", index);

                    con.Open();
                    path = cmd.ExecuteScalar() as string;
                }
            }
            catch
            {
                return null;
            }

            if (!string.IsNullOrWhiteSpace(path))
            {
                HttpRuntime.Cache.Insert(
                    cacheKey,
                    path,
                    null,
                    DateTime.Now.AddMinutes(30),
                    Cache.NoSlidingExpiration);
            }

            return path;
        }

        public bool IsReusable
        {
            get { return false; }
        }
    }
}