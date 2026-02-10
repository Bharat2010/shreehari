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
    public partial class majori_6 : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindStylesForRings();
                BindStylesForEarings();
                BindStylesForPendantsAndNecklace();
                BindStylesForBracelate();
                BindStylesForMangalSutra();

                BindOccasions();

            }
            //var cart = Session["Cart"] as List<CartItem>;
            //cartCounter.Text = (cart != null ? cart.Count : 0).ToString();

            string pageName = System.IO.Path.GetFileName(Request.Path).ToLower();

            switch (pageName)
            {
                case "index.aspx":
                case "default.aspx":
                    BodyTag.Attributes["class"] = "home home-6 title-6";
                    break;

                case "category.aspx":
                    BodyTag.Attributes["class"] = "category category-page";
                    break;

                case "products.aspx":
                    BodyTag.Attributes["class"] = "shop";
                    break;

                case "cart.aspx":
                    BodyTag.Attributes["class"] = "cart shopping-cart";
                    break;

                default:
                    BodyTag.Attributes["class"] = "inner-page";
                    break;
            }
        }




        private void BindStylesForRings()
        {
            DataTable dt = new DataTable();

            using (SqlConnection con = new SqlConnection(
                   ConfigurationManager.ConnectionStrings["eJewelDBs"].ConnectionString))
            {
                SqlCommand cmd = new SqlCommand(
                    "SELECT SubcategoryID, SubcategoryName FROM SubCategories WHERE IsActive = 1 and Categoryid=4", con);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dt);
            }

            rptStylesForRings.DataSource = dt;
            rptStylesForRings.DataBind();
        }

        private void BindStylesForEarings()
        {
            DataTable dt = new DataTable();

            using (SqlConnection con = new SqlConnection(
                   ConfigurationManager.ConnectionStrings["eJewelDBs"].ConnectionString))
            {
                SqlCommand cmd = new SqlCommand(
                    "SELECT SubcategoryID, SubcategoryName FROM SubCategories WHERE IsActive = 1 and Categoryid=15", con);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dt);
            }

            rptStyleForEaring.DataSource = dt;
            rptStyleForEaring.DataBind();
        }

        private void BindStylesForPendantsAndNecklace()
        {
            DataTable dt = new DataTable();

            using (SqlConnection con = new SqlConnection(
                   ConfigurationManager.ConnectionStrings["eJewelDBs"].ConnectionString))
            {
                SqlCommand cmd = new SqlCommand(
                    "SELECT SubcategoryID, SubcategoryName FROM SubCategories WHERE IsActive = 1 and Categoryid=9", con);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dt);
            }

            rptStyleForPenAndNecK.DataSource = dt;
            rptStyleForPenAndNecK.DataBind();
        }

        private void BindStylesForMangalSutra()
        {
            DataTable dt = new DataTable();

            using (SqlConnection con = new SqlConnection(
                   ConfigurationManager.ConnectionStrings["eJewelDBs"].ConnectionString))
            {
                SqlCommand cmd = new SqlCommand(
                    "SELECT SubcategoryID, SubcategoryName FROM SubCategories WHERE IsActive = 1 and Categoryid=11", con);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dt);
            }

            rptStyleForMangalsutra.DataSource = dt;
            rptStyleForMangalsutra.DataBind();
        }
        private void BindStylesForBracelate()
        {
            DataTable dt = new DataTable();

            using (SqlConnection con = new SqlConnection(
                   ConfigurationManager.ConnectionStrings["eJewelDBs"].ConnectionString))
            {
                SqlCommand cmd = new SqlCommand(
                    "SELECT SubcategoryID, SubcategoryName FROM SubCategories WHERE IsActive = 1 and Categoryid=13", con);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dt);
            }

            rptStyleForBracelate.DataSource = dt;
            rptStyleForBracelate.DataBind();
        }
        private void BindOccasions()
        {
            DataTable dt = new DataTable();

            using (SqlConnection con = new SqlConnection(
                   ConfigurationManager.ConnectionStrings["eJewelDBs"].ConnectionString))
            {
                SqlCommand cmd = new SqlCommand(
                    "SELECT OccasionID, OccasionName FROM OccasionMaster WHERE IsActive = 1", con);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dt);
            }

            rptOccasionRing.DataSource = dt;
            rptOccasionRing.DataBind();

            rptOccasionEaring.DataSource = dt;
            rptOccasionEaring.DataBind();

            rptOccassionForPenAndNeck.DataSource = dt;
            rptOccassionForPenAndNeck.DataBind();

            rptOccassionForBracelates.DataSource = dt;
            rptOccassionForBracelates.DataBind();

            rptOccasionForMangalsutra.DataSource = dt;
            rptOccasionForMangalsutra.DataBind();
        }

    }
}