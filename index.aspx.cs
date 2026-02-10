using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SHRJ
{
    public partial class index : System.Web.UI.Page
    {
        string connString =
                            ConfigurationManager.ConnectionStrings["eJewelDBs"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindNewArrivals();
                BindTrendingProducts();
            }
        }


        private void BindNewArrivals()
        {
            using (SqlConnection conn = new SqlConnection(connString))
            {
                string sql = @"
            SELECT TOP 12 *
            FROM vw_DesignLibrary_FinalPricing_2
            WHERE IsActive = 1
            ORDER BY DesignID DESC";

                using (SqlDataAdapter da = new SqlDataAdapter(sql, conn))
                {
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    rptNewArrivals.DataSource = dt;
                    rptNewArrivals.DataBind();
                }
            }
        }

        private void BindTrendingProducts()
        {
            using (SqlConnection conn = new SqlConnection(connString))
            {
                string sql = @"
            SELECT TOP 12 *
            FROM vw_DesignLibrary_FinalPricing_2
            WHERE IsTrending = 1
              AND IsActive = 1
            ORDER BY DesignID DESC";

                using (SqlDataAdapter da = new SqlDataAdapter(sql, conn))
                {
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    rptTrendingProducts.DataSource = dt;
                    rptTrendingProducts.DataBind();
                }
            }
        }

        [WebMethod(EnableSession = true)]
        public static string AddItem(
            string DesignID,
            string DesignName,
            decimal Price,
            int Quantity)
        {
            if (HttpContext.Current.Session["UserID"] == null)
                return "LOGIN";

            int userId = Convert.ToInt32(HttpContext.Current.Session["UserID"]);

            using (SqlConnection con = new SqlConnection(
                ConfigurationManager.ConnectionStrings["eJewelDBs"].ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand("usp_AddToCart", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@UserID", userId);
                    cmd.Parameters.AddWithValue("@DesignID", DesignID);
                    cmd.Parameters.AddWithValue("@DesignName", DesignName);
                    cmd.Parameters.AddWithValue("@Price", Price);
                    cmd.Parameters.AddWithValue("@Quantity", Quantity);

                    con.Open();
                    cmd.ExecuteNonQuery();
                }
            }

            return "OK";
        }

    }
}