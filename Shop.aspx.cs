using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SHRJ
{
    public partial class Shop : System.Web.UI.Page
    {
        protected string CurrentSort { get; private set; }
        protected void Page_Load(object sender, EventArgs e)
        {
            bool isLoggedIn = (Session["UserID"] != null) || (HttpContext.Current.User.Identity.IsAuthenticated); // Adjust based on your login logic (session key or Forms Auth)

            string category = Request.QueryString["category"];

            if (!string.IsNullOrEmpty(category))
            {
                string decodedCategory = Server.UrlDecode(category);
                litPageTitle.Text = decodedCategory + "s"; // or just "Rings"
                litCurrentCategory.Text = decodedCategory + "s";
                Page.Title = decodedCategory + "s | Shree Hari Jewellers";

                // Special case for nice display
                if (decodedCategory.Equals("Ring", StringComparison.OrdinalIgnoreCase))
                {
                    litPageTitle.Text = "Rings";
                    litCurrentCategory.Text = "Rings";
                    Page.Title = "Rings | Shree Hari Jewellers";
                }
            }
            else
            {
                litPageTitle.Text = "Shop All";
                litCurrentCategory.Text = "All Products";
                Page.Title = "Shop | Shree Hari Jewellers";
            }

            CurrentSort = Request.QueryString["sort"] ?? "default";
            SetCurrentSortText();
            BindProducts();
            //UpdateCartCounter();
        }

        private void SetCurrentSortText()
        {
            switch (CurrentSort)
            {
                case "popularity": litCurrentSort.Text = "Sort by popularity"; break;
                case "latest": litCurrentSort.Text = "Sort by latest"; break;
                case "price_low": litCurrentSort.Text = "Sort by price: low to high"; break;
                case "price_high": litCurrentSort.Text = "Sort by price: high to low"; break;
                default: litCurrentSort.Text = "Default sorting"; break;
            }
        }
        private void BindProducts()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["eJewelDBs"].ConnectionString;

            // Read ALL filters from QueryString
            string category = Request.QueryString["category"];        // NEW: e.g., "Ring"
            string subcategory = Request.QueryString["SubcategoryName"];
            string occasion = Request.QueryString["OccasionName"];
            string gender = Request.QueryString["gender"];            // "Male" or "Female"

            // Price range
            decimal? minPrice = null;
            decimal? maxPrice = null;
            if (decimal.TryParse(Request.QueryString["minPrice"], out decimal min))
                minPrice = min;
            if (decimal.TryParse(Request.QueryString["maxPrice"], out decimal max))
                maxPrice = max;

            // For "Above ₹1 Lac" – only minPrice=100000 and no maxPrice
            // Already handled correctly above

            // Sorting
            string sort = Request.QueryString["sort"] ?? "default";

            // Base Query
            string query = @"
        SELECT
            DesignID,
            DesignNo,
            DesignName,
            Category,
            SubCategory,
            Gender,
            Collection,
            Occasion,
            Style,
            MetalFull,
            MetalWeight_Gms,
            DiamondWeight_Cts,
            ColorStoneWeight_Cts,
            DiamondPieces,
            ColorStonePieces,
            GrossWeight_Gms,
            DesignImage,
            GoldValue_Rs,
            DiamondValue_Rs,
            ColorstoneValue_Rs,
            MakingCharge_Rs,
            ProductValue_Rs,
            GST_Rate,
            GST_Amount_Rs,
            Courier_Rs,
            FinalPrice_WithGST_Rs AS Price,
            IsFeatured,
            IsTrending,
            IsOnSale = CASE WHEN ProductValue_Rs > FinalPrice_WithGST_Rs THEN 1 ELSE 0 END
        FROM vw_DesignLibrary_FinalPricing
        WHERE IsActive = 1";

            List<string> conditions = new List<string>();
            SqlCommand cmd = new SqlCommand { CommandText = query };

            // === CATEGORY FILTER (MOST IMPORTANT FIX) ===
            if (!string.IsNullOrEmpty(category))
            {
                conditions.Add("MainCategory = @Category");
                cmd.Parameters.AddWithValue("@Category", category); // e.g., "Ring"
            }

            // Other filters
            if (!string.IsNullOrEmpty(subcategory))
            {
                conditions.Add("SubCategory = @SubCategory");
                cmd.Parameters.AddWithValue("@SubCategory", subcategory);
            }

            if (!string.IsNullOrEmpty(occasion))
            {
                conditions.Add("Occasion = @Occasion");
                cmd.Parameters.AddWithValue("@Occasion", occasion);
            }

            if (!string.IsNullOrEmpty(gender))
            {
                conditions.Add("Gender = @Gender");
                cmd.Parameters.AddWithValue("@Gender", gender);
            }

            if (minPrice.HasValue)
            {
                conditions.Add("ProductValue_Rs >= @MinPrice");
                cmd.Parameters.AddWithValue("@MinPrice", minPrice.Value);
            }

            if (maxPrice.HasValue)
            {
                conditions.Add("ProductValue_Rs <= @MaxPrice");
                cmd.Parameters.AddWithValue("@MaxPrice", maxPrice.Value);
            }

            // Apply conditions
            if (conditions.Count > 0)
            {
                cmd.CommandText += " AND " + string.Join(" AND ", conditions);
            }

            // Sorting
            switch (sort.ToLower())
            {
                case "popularity":
                    cmd.CommandText += " ORDER BY IsTrending DESC, IsFeatured DESC, DesignID DESC";
                    break;
                case "latest":
                    cmd.CommandText += " ORDER BY DesignID DESC";
                    break;
                case "price_low":
                    cmd.CommandText += " ORDER BY ProductValue_Rs ASC";
                    break;
                case "price_high":
                    cmd.CommandText += " ORDER BY ProductValue_Rs DESC";
                    break;
                default:
                    cmd.CommandText += " ORDER BY DesignNo";
                    break;
            }

            // Execute
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                cmd.Connection = con;
                using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();
                    sda.Fill(dt);

                    rptProductsGrid.DataSource = dt;
                    rptProductsGrid.DataBind();

                    int count = dt.Rows.Count;
                    litResultsCount.Text = count == 0
                        ? "No products found"
                        : $"Showing {count} result{(count == 1 ? "" : "s")}";
                }
            }
        }
        protected string GetSortUrl(string sortValue)
        {
            string subcategory = Request.QueryString["SubcategoryName"];
            string url = "Shop.aspx?sort=" + sortValue;
            if (!string.IsNullOrEmpty(subcategory))
                url += "&SubcategoryName=" + Server.UrlEncode(subcategory);
            return url;
        }
    }
}