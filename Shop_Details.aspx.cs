using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace SHRJ
{
    public partial class Shop_Details : System.Web.UI.Page
    {
        protected string connString = ConfigurationManager.ConnectionStrings["eJewelDBs"].ConnectionString;
        protected string
         designNo = "",
         metalDisplay = "",
         karatDisplay = "",
         sku = "",
         Collection = "",
         Occasion = "",
         Metalfull = "",
         MetalWtGms = "",
         GrossWtGms = "",
         DmdWtCts = "",
         DmdPcs = "",
         CTNWtCts = "",
         CTNPcs = "",
         MakingChargePrGM = "",
         MakingChargeRs = "",
         GSTRate = "",
         GSTAmount = "",
         Courier = "",
         Gender = "",
         Style = "",
         FinalAmount = "",
         Category = "",
         Subcatgory = "",
         rawCategory2 = "";




        protected bool isFeature = false;
        protected bool isTrending = false;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                designNo = Request.QueryString["DesignNo"] ?? "";
                hdnDesignNo.Value = designNo;
                sku = designNo;
                if (!string.IsNullOrEmpty(designNo))
                {
                    LoadProductDetails(designNo);
                    BindDiamondGrid();
                    BindColorstoneGrid();
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
                    SELECT TOP 1 * FROM [vw_DesignLibrary_FinalPricing_2] 
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
                        string rawCategory = dr["Category"]?.ToString() ?? "";
                        string[] categoryParts = rawCategory.Split(new string[] { " > " }, StringSplitOptions.RemoveEmptyEntries);

                        if (categoryParts.Length > 0)
                        {
                            // Build clickable breadcrumb links
                            var breadcrumbLinks = new System.Text.StringBuilder();
                            string currentPath = "";

                            for (int i = 0; i < categoryParts.Length; i++)
                            {
                                string part = categoryParts[i].Trim();
                                currentPath += (currentPath == "" ? "" : "/") + part;

                                if (i == categoryParts.Length - 1)
                                {
                                    rawCategory2 = part;
                                    // Last part: plain text (current page)
                                    breadcrumbLinks.Append($"<span class='current'>{part}</span>");
                                }
                                else
                                {
                                    // Previous parts: clickable links
                                    breadcrumbLinks.Append($"<a href='shop.aspx?cat={System.Web.HttpUtility.UrlEncode(part)}'>{part}</a> / </span>");
                                }
                            }

                            litBreadcrumbCategory.Text = breadcrumbLinks.ToString();
                        }
                        else
                        {
                            litBreadcrumbCategory.Text = "<span class='current'>Product</span>";
                        }

                        
                        string metalFull = dr["MetalFull"]?.ToString() ?? "";
                        metalDisplay = GetMetalDisplay(metalFull);
                       

                        decimal finalPrice = Convert.ToDecimal(dr["ProductValue_Rs"]);
                        karatDisplay = "";

                        if (metalFull.IndexOf("14K", StringComparison.OrdinalIgnoreCase) >= 0)
                        {
                            karatDisplay = "14K";
                            hdnPurity.Value = karatDisplay.Replace("K", "");
                            decimal goldValueDefault = Convert.ToDecimal(dr["GoldValue_Rs"]);
                            decimal goldValue14KT = Convert.ToDecimal(dr["GoldValue_14KT_Rs"]);

                            finalPrice = finalPrice - goldValueDefault + goldValue14KT;
                        }
                        else if (metalFull.IndexOf("18K", StringComparison.OrdinalIgnoreCase) >= 0)
                        {
                            karatDisplay = "18K";
                            hdnPurity.Value = karatDisplay.Replace("K", "");
                            decimal goldValueDefault = Convert.ToDecimal(dr["GoldValue_Rs"]);
                            decimal goldValue18KT = Convert.ToDecimal(dr["GoldValue_18KT_Rs"]);

                            finalPrice = finalPrice - goldValueDefault + goldValue18KT;
                        }
                        else if (metalFull.IndexOf("9K", StringComparison.OrdinalIgnoreCase) >= 0)
                        {
                            karatDisplay = "9K";
                            hdnPurity.Value = karatDisplay.Replace("K", "");
                            decimal goldValueDefault = Convert.ToDecimal(dr["GoldValue_Rs"]);
                            decimal goldValue9KT = Convert.ToDecimal(dr["GoldValue_9KT_Rs"]);

                            finalPrice = finalPrice - goldValueDefault + goldValue9KT;
                        }
                        else if (metalFull.IndexOf("22K", StringComparison.OrdinalIgnoreCase) >= 0)
                        {
                            karatDisplay = "22K";
                            hdnPurity.Value = karatDisplay.Replace("K", "");
                            decimal goldValueDefault = Convert.ToDecimal(dr["GoldValue_Rs"]);
                            decimal goldValue22KT = Convert.ToDecimal(dr["GoldValue_22KT_Rs"]);

                            finalPrice = finalPrice - goldValueDefault + goldValue22KT;
                        }

                        // Determine which price field to use
                        //string selectedPriceField = "";
                        //karatDisplay = "";

                        //if (metalFull.Contains("14K") || metalFull.Contains("14kt") || metalFull.Contains("14 Karat"))
                        //{
                        //    selectedPriceField = "MetalPlusMaking_14KT";
                        //    karatDisplay = "14K";
                        //}
                        //else if (metalFull.Contains("18K") || metalFull.Contains("18kt") || metalFull.Contains("18 Karat"))
                        //{
                        //    selectedPriceField = "MetalPlusMaking_18KT";
                        //    karatDisplay = "18K";
                        //}
                        //else if (metalFull.Contains("9K") || metalFull.Contains("9kt") || metalFull.Contains("9 Karat"))
                        //{
                        //    selectedPriceField = "MetalPlusMaking_9KT";
                        //    karatDisplay = "9K";
                        //}
                        //else
                        //{
                        //    // Fallback - could also log or show "Price on request"
                        //    selectedPriceField = "MetalPlusMaking_14KT"; // or handle differently
                        //    karatDisplay = "Other";
                        //}

                        ////// Get the price value (assuming it's stored as decimal or can be converted)
                        //decimal finalPrice = 0m;
                        //if (dr.Table.Columns.Contains(selectedPriceField))
                        //{
                        //    string priceStr = dr[selectedPriceField]?.ToString() ?? "0";
                        //    decimal.TryParse(priceStr, out finalPrice);
                        //}
                        //else
                        //{
                        //    // Optional: fallback logic or error handling
                        //    // e.g., calculate on-the-fly if you have gold rate + making + weight
                        //}
                        isFeature = dr["IsFeatured"] != DBNull.Value && Convert.ToBoolean(dr["IsFeatured"]);
                        isTrending = dr["IsTrending"] != DBNull.Value && Convert.ToBoolean(dr["IsTrending"]);

                        string formattedPrice = finalPrice.ToString("N0");
                        string priceWithSymbol = "₹" + formattedPrice;

                        Collection = dr["Collection"].ToString();
                        Occasion = dr["Occasion"].ToString();
                        Metalfull = dr["MetalFull"].ToString();
                        MetalWtGms = dr["MetalWeight_Gms"].ToString();
                        GrossWtGms = dr["GrossWeight_Gms"].ToString();
                        DmdWtCts = dr["DiamondWeight_Cts"].ToString();
                        DmdPcs = dr["DiamondPieces"].ToString();
                        CTNWtCts = dr["ColorStoneWeight_Cts"].ToString();
                        CTNPcs = dr["ColorStonePieces"].ToString();
                        MakingChargePrGM = dr["MakingCharge_PerGram"].ToString();
                        MakingChargeRs = dr["MakingCharge_Rs"].ToString();
                        GSTRate = dr["GST_Rate"].ToString();
                        GSTAmount = dr["GST_Amount_Rs"].ToString();
                        Gender = dr["Gender"].ToString();
                        Style = dr["Style"].ToString();

                        Category = dr["MainCategory"].ToString();
                        Subcatgory = dr["Subcategory"].ToString();

                        Courier = dr["Courier_Rs"].ToString();
                        FinalAmount = dr["FinalPrice_WithGST_Rs"].ToString();

                        litPrice.Text = priceWithSymbol;
                        ClientScript.RegisterStartupScript(
                            this.GetType(),
                            "syncPurity",
                            $"document.querySelector('.purity-btn[data-purity=\"{hdnPurity.Value}\"]')?.classList.add('active');",
                            true
                        );
                        LoadImages(designNo);

                        // Related Products
                        LoadRelatedProducts(dr["Category"].ToString(), designNo);

                        //pnlProduct.Visible = true;
                    }
                }
            }
            //UpdatePrice();
        }

        private void BindDiamondGrid()
        {
            string designNo = Request.QueryString["DesignNo"]; // or Session["DesignNo"], etc.

            string connStr = ConfigurationManager.ConnectionStrings["eJewelDBs"].ConnectionString;

            using (SqlConnection con = new SqlConnection(connStr))
            {
                string query = "SELECT * FROM DesignDiamondDetails WHERE DesignNo = @DesignNo"; // add WHERE to filter by product

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@DesignNo", designNo ?? ""); // prevent full table load

                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        da.Fill(dt);

                        gvDiamondDetails.DataSource = dt;
                        gvDiamondDetails.DataBind();
                    }
                }
            }
        }

        private void BindColorstoneGrid()
        {
            string designNo = Request.QueryString["DesignNo"]; // or Session["DesignNo"], etc.

            string connStr = ConfigurationManager.ConnectionStrings["eJewelDBs"].ConnectionString;

            using (SqlConnection con = new SqlConnection(connStr))
            {
                string query = "SELECT * FROM DesignColorstoneDetails WHERE DesignNo = @DesignNo"; // add WHERE to filter by product

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@DesignNo", designNo ?? ""); // prevent full table load

                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        da.Fill(dt);

                        gridColorstone.DataSource = dt;
                        gridColorstone.DataBind();
                    }
                }
            }
        }
        private string GetMetalDisplay(string metal)
        {
            if (string.IsNullOrWhiteSpace(metal))
                return "";

            metal = metal.ToUpper();
            string selectedPurity = hdnPurity.Value;
            if (metal.Contains("YG"))
                return "Yellow Gold";

            if (metal.Contains("RG"))
                return "Rose Gold";

            if (metal.Contains("WG"))
                return "White Gold";

            return metal; // fallback
        }
        private string GetMetalBadges(DataRow dr)
        {
            return $@"
                <span class='metal-badge yg'>YG 18KT: ₹{Convert.ToDecimal(dr["MetalPlusMaking_18KT"]):N0}</span>
                <span class='metal-badge wg'>WG 18KT: ₹{Convert.ToDecimal(dr["MetalPlusMaking_18KT"]):N0} (+₹5000)</span>
                <span class='metal-badge rw'>RW 18KT: ₹{Convert.ToDecimal(dr["MetalPlusMaking_18KT"]):N0} (+₹3000)</span><br/>
                <span class='price-metal'>Full Price 18KT: ₹{Convert.ToDecimal(dr["FinalPrice_18KT"]):N0}</span>";
        }

        protected string GetPurityDisplay(string purity)
        {
            if (string.IsNullOrWhiteSpace(purity))
                return "";

            purity = purity.ToUpper();

            if (purity.Contains("18"))
                return "18K";
            if (purity.Contains("22"))
                return "22K";
            if (purity.Contains("14"))
                return "14K";

            return purity;
        }


        private void LoadImages(string designNo)
        {
            if (string.IsNullOrWhiteSpace(designNo))
            {

                return;
            }

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


            using (SqlConnection con = new SqlConnection(connString))
            {
                string query = "SELECT *,ImagePath FROM DesignImages WHERE DesignID = @DesignID"; // adjust column name

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@DesignID", designId);
                    using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        sda.Fill(dt);

                        
                        foreach (DataRow row in dt.Rows)
                        {
                            string physPath = row["ImagePath"].ToString();
                            
                            if (physPath.StartsWith(@"D:\DesignImages\"))
                            {
                                row["ImagePath"] = physPath.Replace(@"D:\DesignImages\", "/DesignImages/").Replace(@"\", "/");
                            }
                        }

                        rptThumbnails.DataSource = dt;
                        rptThumbnails.DataBind();

                        rptMainImages.DataSource = dt;
                        rptMainImages.DataBind();
                    }
                }
            }
        }

        private void LoadRelatedProducts(string category, string excludeDesignNo)
        {
            string query = @"
                SELECT TOP 8 DesignNo, DesignName, DesignImage, FinalPrice_18KT,* 
                FROM vw_DesignLibrary_FinalPricing_SingleRow_2 
                WHERE Category LIKE @Category AND DesignNo != @DesignNo AND IsActive = 1 
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

                    //rptProducts.DataSource = dt;
                    //rptProducts.DataBind();
                    if (dt != null && dt.Rows.Count > 0)
                    {
                        rptProducts.DataSource = dt;
                        rptProducts.DataBind();

                        lblNoProducts.Visible = false;
                    }
                    else
                    {
                        rptProducts.DataSource = null;
                        rptProducts.DataBind();

                        lblNoProducts.Text = "No product found";
                        lblNoProducts.Visible = true;
                    }


                    lblNoProducts.Visible = rptProducts.Items.Count == 0;
                }
            }
        }

    
      
       

      
      

        [WebMethod]
        public static decimal GetMetalPlusMakingPrice(string designNo, string purity)
        {
            string connString = ConfigurationManager.ConnectionStrings["db27118"].ConnectionString;
            string col = $"MetalPlusMaking_{purity}";
            string query = $"SELECT {col} FROM vw_DesignLibrary_FinalPricing_SingleRow_1 WHERE DesignNo = @DesignNo";

            using (SqlConnection conn = new SqlConnection(connString))
            {
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@DesignNo", designNo);
                    conn.Open();
                    return Convert.ToDecimal(cmd.ExecuteScalar() ?? 0);
                }
            }
        }

        [WebMethod(EnableSession = false)]
     
        public static object GetFinalPriceByPurity(string designNo, string purity)
        {
            string connString = ConfigurationManager.ConnectionStrings["eJewelDBs"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connString))
            {
                string query = @"
            SELECT
                ProductValue_Rs,
                GoldValue_Rs,
                GoldValue_9KT_Rs,
                GoldValue_14KT_Rs,
                GoldValue_18KT_Rs,
                GoldValue_22KT_Rs,
                MakingCharge_Rs,           -- assuming fixed or per design
                GST_Rate,                  -- e.g. 3 or 0.5
                Courier_Rs                 -- usually fixed
            FROM vw_DesignLibrary_FinalPricing_2
            WHERE DesignNo = @DesignNo";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@DesignNo", designNo ?? "");
                    conn.Open();
                    using (SqlDataReader dr = cmd.ExecuteReader())
                    {
                        if (dr.Read())
                        {
                            decimal basePrice = Convert.ToDecimal(dr["ProductValue_Rs"]);
                            decimal originalGold = Convert.ToDecimal(dr["GoldValue_Rs"]);
                            decimal makingCharge = Convert.ToDecimal(dr["MakingCharge_Rs"] ?? 0);
                            decimal gstRatePercent = Convert.ToDecimal(dr["GST_Rate"] ?? 3);    // default 3%
                            decimal courier = Convert.ToDecimal(dr["Courier_Rs"] ?? 0);

                            decimal selectedGold = originalGold;
                            switch (purity?.Trim())
                            {
                                case "9": selectedGold = Convert.ToDecimal(dr["GoldValue_9KT_Rs"]); break;
                                case "14": selectedGold = Convert.ToDecimal(dr["GoldValue_14KT_Rs"]); break;
                                case "18": selectedGold = Convert.ToDecimal(dr["GoldValue_18KT_Rs"]); break;
                                case "22": selectedGold = Convert.ToDecimal(dr["GoldValue_22KT_Rs"]); break;
                                default: return new { success = false, message = "Invalid purity" };
                            }

                            decimal adjustedBase = basePrice - originalGold + selectedGold;

                            // Most common Indian jewellery GST logic:
                            // GST usually applied on (Metal value + Making charge)
                            decimal taxableValue = adjustedBase + makingCharge;
                            decimal gstAmount = taxableValue * (gstRatePercent / 100m);
                            decimal finalAmount = taxableValue + gstAmount + courier;

                            return new
                            {
                                success = true,
                                basePrice = adjustedBase,           // for litPrice
                                finalPrice = finalAmount,            // for #finalPriceDisplay
                                gstAmount = gstAmount,              // optional
                                purity = purity
                            };
                        }
                    }
                }
            }
            return new { success = false, message = "Design not found" };
        }

    }
}