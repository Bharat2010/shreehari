
using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Web;
using System.Web.Caching;

public class DesignImageHandler : IHttpHandler
{
    public void ProcessRequest(HttpContext context)
    {
        int designId;
        int index = 0;

        int.TryParse(context.Request.QueryString["id"], out designId);
        int.TryParse(context.Request.QueryString["index"], out index);

        if (designId <= 0)
        {
            RedirectNoImage(context);
            return;
        }

        string dbPath = GetImagePath(designId, index);

        if (string.IsNullOrEmpty(dbPath))
        {
            RedirectNoImage(context);
            return;
        }

        // normalize DB path
        dbPath = dbPath
                    .Replace("\\", "/")
                    .Replace("~/", "")
                    .TrimStart('/');

        // build absolute URL
        string baseUrl = ConfigurationManager.AppSettings["BaseUrl"];
        string imageUrl = baseUrl.TrimEnd('/') + "/" + dbPath;

        context.Response.Redirect(imageUrl, false);
    }

    private void RedirectNoImage(HttpContext context)
    {
        context.Response.Redirect(
            ConfigurationManager.AppSettings["BaseUrl"].TrimEnd('/') +
            "/media/no-image.png",
            false);
    }

    private string GetImagePath(int designId, int index)
    {
        string cacheKey = $"DESIGN_IMG_{designId}_{index}";
        string path = HttpRuntime.Cache[cacheKey] as string;

        if (!string.IsNullOrEmpty(path))
            return path;

        using (SqlConnection con = new SqlConnection(
            ConfigurationManager.ConnectionStrings["eJewelDBs"].ConnectionString))
        {
            string sql = @"
                    SELECT ImagePath
                    FROM (
                        SELECT ImagePath,
                               ROW_NUMBER() OVER (
                                   ORDER BY ISNULL(SortOrder,999), ID
                               ) AS rn
                        FROM DesignImages
                        WHERE DesignID = @DesignID
                          AND ISNULL(ImagePath,'') <> ''
                    ) t
                    WHERE rn = @RowNum";

            using (SqlCommand cmd = new SqlCommand(sql, con))
            {
                cmd.Parameters.Add("@DesignID", SqlDbType.Int).Value = designId;
                cmd.Parameters.Add("@RowNum", SqlDbType.Int).Value = index + 1;

                con.Open();
                path = Convert.ToString(cmd.ExecuteScalar());
            }
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

    public bool IsReusable => false;
}

