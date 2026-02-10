using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Caching;

namespace SHRJ
{
    /// <summary>
    /// Summary description for imgHandle
    /// </summary>
    public class imgHandle : IHttpHandler
    {

        private const string BASE_PHYSICAL_PATH = @"D:\DesignImages\";
        private const string PLACEHOLDER_FILENAME = "No_Image_Available.jpg";

        public void ProcessRequest(HttpContext context)
        {
            context.Response.Clear();

            // Invalid or missing ID → placeholder
            if (!int.TryParse(context.Request.QueryString["id"], out int designId) || designId <= 0)
            {
                SendPlaceholder(context);
                return;
            }

            string imageType = (context.Request.QueryString["type"] ?? "base").ToLowerInvariant();

            string dbImagePath = GetCachedImagePath(designId, imageType);

            if (string.IsNullOrWhiteSpace(dbImagePath))
            {
                SendPlaceholder(context);
                return;
            }

            // ────────────────────────────────────────────────
            // Normalize path coming from database
            // Handles: /DesignImages/XXXX/XXXX_001.jpg
            // ────────────────────────────────────────────────
            string relative = dbImagePath.Trim().TrimStart('/');

            // Remove leading "DesignImages/" if present
            if (relative.StartsWith("DesignImages/", StringComparison.OrdinalIgnoreCase))
            {
                relative = relative.Substring("DesignImages/".Length);
            }
            else if (relative.StartsWith("DesignImages\\", StringComparison.OrdinalIgnoreCase))
            {
                relative = relative.Substring("DesignImages\\".Length);
            }

            // Replace slashes with correct directory separator
            relative = relative.Replace('/', Path.DirectorySeparatorChar)
                               .Replace('\\', Path.DirectorySeparatorChar);

            // Build final physical path
            string fullPhysicalPath = Path.Combine(BASE_PHYSICAL_PATH, relative);

            // ────────────────────────────────────────────────
            // For debugging (comment out in production)
            // ────────────────────────────────────────────────
            //if (!File.Exists(fullPhysicalPath))
            //{
            //    context.Response.ContentType = "text/plain";
            //    context.Response.Write("File not found.\nDB path: " + dbImagePath + "\nFinal path: " + fullPhysicalPath);
            //    return;
            //}

            if (!File.Exists(fullPhysicalPath))
            {
                SendPlaceholder(context);
                return;
            }

            // Determine content type
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
                catch { }
            }

            // Embedded 1×1 transparent PNG – prevents recursion even if file is missing
            byte[] pixel = Convert.FromBase64String(
                "iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR42mNkYAAAAAYAAjCB0C8AAAAASUVORK5CYII=");

            context.Response.ContentType = "image/png";
            context.Response.Cache.SetCacheability(HttpCacheability.NoCache);
            context.Response.OutputStream.Write(pixel, 0, pixel.Length);
        }

        private string GetCachedImagePath(int designId, string imageType)
        {
            string cacheKey = "IMG_" + designId + "_" + imageType;

            string cached = HttpRuntime.Cache[cacheKey] as string;
            if (!string.IsNullOrEmpty(cached))
                return cached;

            string path = null;
            string cs = ConfigurationManager.ConnectionStrings["eJewelDBs"]?.ConnectionString;

            if (string.IsNullOrEmpty(cs))
                return null;

            try
            {
                using (SqlConnection con = new SqlConnection(cs))
                using (SqlCommand cmd = new SqlCommand(
                    @"SELECT TOP 1 ImagePath
      FROM DesignImages
      WHERE DesignID = @id
        AND (
            (@t = 'base'  AND IsBase    = 1)
         OR (@t = 'hover' AND IsMBHover = 1)
        )
      ORDER BY SortOrder ASC, ID ASC", con))
                {
                    cmd.Parameters.AddWithValue("@id", designId);
                    cmd.Parameters.AddWithValue("@t", imageType);

                    con.Open();
                    path = cmd.ExecuteScalar() as string;
                }
            }
            catch { }

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

        public bool IsReusable
        {
            get { return false; }
        }
    }
}