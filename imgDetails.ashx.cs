using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Web;
using System.Web.Caching;

namespace SHRJ
{
    public class imgDetails : IHttpHandler
    {
        private const string BASE_PHYSICAL_PATH = @"D:\DesignImages\";
        private const string PLACEHOLDER_FILENAME = "No_Image_Available.jpg";

        private string connString = ConfigurationManager.ConnectionStrings["eJewelDBs"]?.ConnectionString;

        public void ProcessRequest(HttpContext context)
        {
            context.Response.Clear();

            // Parse image ID
            if (!int.TryParse(context.Request.QueryString["img"], out int imageId) || imageId <= 0)
            {
                SendPlaceholder(context);
                return;
            }

            // Get path from database (with caching)
            string dbImagePath = GetCachedImagePath(imageId);
            if (string.IsNullOrWhiteSpace(dbImagePath))
            {
                SendPlaceholder(context);
                return;
            }

            // Normalize path from database
            string relative = dbImagePath.Trim().TrimStart('/', '~');

            // Remove leading "DesignImages/" or "DesignImages\" if present
            if (relative.StartsWith("DesignImages/", StringComparison.OrdinalIgnoreCase))
            {
                relative = relative.Substring("DesignImages/".Length);
            }
            else if (relative.StartsWith("DesignImages\\", StringComparison.OrdinalIgnoreCase))
            {
                relative = relative.Substring("DesignImages\\".Length);
            }

            // Normalize slashes to current OS directory separator
            relative = relative.Replace('/', Path.DirectorySeparatorChar)
                               .Replace('\\', Path.DirectorySeparatorChar);

            // Build full physical path
            string fullPhysicalPath = Path.Combine(BASE_PHYSICAL_PATH, relative);

            // File not found → placeholder
            if (!File.Exists(fullPhysicalPath))
            {
                SendPlaceholder(context);
                return;
            }

            // Determine MIME type using switch (C# 7.3 compatible)
            string extension = Path.GetExtension(fullPhysicalPath);
            if (extension != null) extension = extension.ToLowerInvariant();
            else extension = ".jpg";

            string contentType;

            switch (extension)
            {
                case ".jpg":
                case ".jpeg":
                    contentType = "image/jpeg";
                    break;

                case ".png":
                    contentType = "image/png";
                    break;

                case ".gif":
                    contentType = "image/gif";
                    break;

                case ".webp":
                    contentType = "image/webp";
                    break;

                case ".bmp":
                    contentType = "image/bmp";
                    break;

                case ".svg":
                    contentType = "image/svg+xml";
                    break;

                case ".ico":
                    contentType = "image/x-icon";
                    break;

                default:
                    contentType = "image/jpeg"; // fallback
                    break;
            }

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

        private string GetCachedImagePath(int imageId)
        {
            string cacheKey = "IMG_PATH_" + imageId;

            string cached = HttpRuntime.Cache[cacheKey] as string;
            if (!string.IsNullOrEmpty(cached))
                return cached;

            string path = null;

            if (string.IsNullOrEmpty(connString))
                return null;

            try
            {
                using (SqlConnection con = new SqlConnection(connString))
                using (SqlCommand cmd = new SqlCommand(
                    "SELECT ImagePath,* FROM DesignImages WHERE ID = @id",
                    con))
                {
                    cmd.Parameters.AddWithValue("@id", imageId);
                    con.Open();
                    path = cmd.ExecuteScalar() as string;
                }
            }
            catch
            {
                // silent fail → will return null → placeholder
            }

            if (!string.IsNullOrEmpty(path))
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

        private void SendPlaceholder(HttpContext context)
        {
            string placeholderPath = Path.Combine(BASE_PHYSICAL_PATH, PLACEHOLDER_FILENAME);

            if (File.Exists(placeholderPath))
            {
                try
                {
                    context.Response.ContentType = "image/jpeg";
                    context.Response.TransmitFile(placeholderPath);
                    return;
                }
                catch { /* fallback to embedded */ }
            }

            // 1×1 transparent GIF as ultimate fallback (prevents broken image icon)
            byte[] transparentPixel = Convert.FromBase64String(
                "R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7");

            context.Response.ContentType = "image/gif";
            context.Response.Cache.SetCacheability(HttpCacheability.NoCache);
            context.Response.OutputStream.Write(transparentPixel, 0, transparentPixel.Length);
        }

        public bool IsReusable
        {
            get { return false; }
        }
    }
}