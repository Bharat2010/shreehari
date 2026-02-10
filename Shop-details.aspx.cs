using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Text;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace SHRJ
{
    public partial class Shop_details : System.Web.UI.Page
    {
        protected string metalDisplay = "";
        protected string connString = ConfigurationManager.ConnectionStrings["eJewelDBs"].ConnectionString;
        protected string designNo = "";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                designNo = Request.QueryString["DesignNo"] ?? "";
                if (!string.IsNullOrEmpty(designNo))
                {
                    LoadProductDetails(designNo);
                }
                else
                {
                    Response.Redirect("shop.aspx");
                }
            }
        }

        private void LoadProductDetails(string designNo)
        {
            using (SqlConnection conn = new SqlConnection(connString))
            {
                string query = @"
                    SELECT TOP 1 * 
                    FROM vw_DesignLibrary_FinalPricing_SingleRow_1
                    WHERE DesignNo = @DesignNo AND IsActive = 1";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@DesignNo", designNo);

                    conn.Open();
                    DataSet ds = new DataSet();
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    da.Fill(ds);

                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        DataRow dr = ds.Tables[0].Rows[0];

                        // Basic Info
                        productTitle.InnerText = infoTitle.InnerText = dr["DesignName"].ToString();

                        var span = this.FindControl("designNo") as HtmlGenericControl;
                        if (span != null)
                        {
                            span.InnerText = designNo;
                        }

                        // Breadcrumb
                        string rawCategory = dr["Category"]?.ToString() ?? "";
                        string[] categoryParts = rawCategory.Split(new string[] { " > " }, StringSplitOptions.RemoveEmptyEntries);

                        if (categoryParts.Length > 0)
                        {
                            var breadcrumbLinks = new StringBuilder();
                            string currentPath = "";

                            for (int i = 0; i < categoryParts.Length; i++)
                            {
                                string part = categoryParts[i].Trim();
                                currentPath += (currentPath == "" ? "" : "/") + part;

                                if (i == categoryParts.Length - 1)
                                {
                                    breadcrumbLinks.Append($"<span class='current'>{HttpUtility.HtmlEncode(part)}</span>");
                                }
                                else
                                {
                                    breadcrumbLinks.Append($"<a href='shop.aspx?cat={HttpUtility.UrlEncode(part)}'>{HttpUtility.HtmlEncode(part)}</a> / ");
                                }
                            }
                            litBreadcrumbCategory.Text = breadcrumbLinks.ToString();
                        }
                        else
                        {
                            litBreadcrumbCategory.Text = "<span class='current'>Product</span>";
                        }

                        // Metal display
                        string metalFull = dr["MetalFull"]?.ToString() ?? "";
                        metalDisplay = GetMetalDisplay(metalFull);

                        // Determine price field based on karat
                        string selectedPriceField = "MetalPlusMaking_14KT"; // default/fallback

                        if (metalFull.Contains("14K") || metalFull.Contains("14kt") || metalFull.Contains("14 Karat"))
                        {
                            selectedPriceField = "MetalPlusMaking_14KT";
                        }
                        else if (metalFull.Contains("18K") || metalFull.Contains("18kt") || metalFull.Contains("18 Karat"))
                        {
                            selectedPriceField = "MetalPlusMaking_18KT";
                        }
                        // else → keep 14KT fallback (you may want to handle "Other" differently)

                        // Get final price
                        decimal finalPrice = 0m;
                        if (dr.Table.Columns.Contains(selectedPriceField))
                        {
                            string priceStr = dr[selectedPriceField]?.ToString() ?? "0";
                            decimal.TryParse(priceStr, out finalPrice);
                        }

                        string formattedPrice = finalPrice.ToString("N0");
                        litPrice.Text = "₹" + formattedPrice;

                        LoadImages(designNo);
                        LoadRelatedProducts(dr["Category"].ToString(), designNo);
                    }
                }
            }

            //UpdatePrice();
        }

        protected string GetMetalDisplay(string metal)
        {
            if (string.IsNullOrWhiteSpace(metal))
                return "";

            metal = metal.ToUpperInvariant();

            if (metal.Contains("YG")) return "Yellow Gold";
            if (metal.Contains("RG")) return "Rose Gold";
            if (metal.Contains("WG")) return "White Gold";

            return metal;
        }

        // Optional: if you want to show metal options/badges
        private string GetMetalBadges(DataRow dr)
        {
            return $@"
                <span class='metal-badge yg'>YG 18KT: ₹{Convert.ToDecimal(dr["MetalPlusMaking_18KT"]):N0}</span>
                <span class='metal-badge wg'>WG 18KT: ₹{Convert.ToDecimal(dr["MetalPlusMaking_18KT"]):N0} (+₹5000)</span>
                <span class='metal-badge rw'>RW 18KT: ₹{Convert.ToDecimal(dr["MetalPlusMaking_18KT"]):N0} (+₹3000)</span><br/>
                <span class='price-metal'>Full Price 18KT: ₹{Convert.ToDecimal(dr["FinalPrice_18KT"]):N0}</span>";
        }

        private void LoadImages(string designNo)
        {
            if (string.IsNullOrWhiteSpace(designNo))
                return;

            int? designId = null;

            string queryGetId = @"
                SELECT DesignID
                FROM DesignMaster
                WHERE DesignNo = @DesignNo";

            using (SqlConnection conn = new SqlConnection(connString))
            {
                using (SqlCommand cmd = new SqlCommand(queryGetId, conn))
                {
                    cmd.Parameters.AddWithValue("@DesignNo", designNo);
                    conn.Open();
                    object result = cmd.ExecuteScalar();
                    if (result != null && result != DBNull.Value)
                    {
                        designId = Convert.ToInt32(result);
                    }
                }
            }

            if (!designId.HasValue)
                return;

            string queryImages = @"
                SELECT *
                FROM DesignImages
                WHERE DesignID = @DesignID
                ORDER BY ID";

            using (SqlConnection conn = new SqlConnection(connString))
            {
                using (SqlCommand cmd = new SqlCommand(queryImages, conn))
                {
                    cmd.Parameters.AddWithValue("@DesignID", designId.Value);
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    conn.Open();
                    da.Fill(dt);

                    // Uncomment when you add the repeaters back
                    // rptThumbnails.DataSource = dt;
                    // rptThumbnails.DataBind();
                    // rptMainImages.DataSource = dt;
                    // rptMainImages.DataBind();
                }
            }
        }

        private void LoadRelatedProducts(string category, string excludeDesignNo)
        {
            string query = @"
                SELECT TOP 8 DesignNo, DesignName, DesignImage, FinalPrice_18KT
                FROM vw_DesignLibrary_FinalPricing_SingleRow_1
                WHERE Category LIKE @Category 
                  AND DesignNo != @DesignNo 
                  AND IsActive = 1
                ORDER BY IsFeatured DESC, NEWID()";

            using (SqlConnection conn = new SqlConnection(connString))
            {
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@Category", $"%{category}%");
                    cmd.Parameters.AddWithValue("@DesignNo", excludeDesignNo);
                    conn.Open();
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    // Uncomment when repeater is added
                    // rptRelated.DataSource = dt;
                    // rptRelated.DataBind();
                }
            }
        }

       
   

     

       

        [WebMethod]
        public static decimal GetMetalPlusMakingPrice(string designNo, string purity)
        {
            // Note: Using same connection string as page (was inconsistent before)
            string connString = ConfigurationManager.ConnectionStrings["eJewelDBs"].ConnectionString;

            string col = $"MetalPlusMaking_{purity}";
            string query = $"SELECT [{col}] FROM vw_DesignLibrary_FinalPricing_SingleRow_1 WHERE DesignNo = @DesignNo";

            using (SqlConnection conn = new SqlConnection(connString))
            using (SqlCommand cmd = new SqlCommand(query, conn))
            {
                cmd.Parameters.AddWithValue("@DesignNo", designNo);
                conn.Open();
                object result = cmd.ExecuteScalar();
                return result != null && result != DBNull.Value
                    ? Convert.ToDecimal(result)
                    : 0m;
            }
        }
    }
}