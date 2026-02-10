using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SHRJ
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        private string HashPassword(string password)
        {
            using (SHA256 sha = SHA256.Create())
            {
                byte[] bytes = sha.ComputeHash(Encoding.UTF8.GetBytes(password));
                return Convert.ToBase64String(bytes);
            }
        }
        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string email = txtLoginEmail.Text.Trim();
            string password = txtLoginPassword.Text.Trim();

            if (string.IsNullOrEmpty(email) || string.IsNullOrEmpty(password))
            {
                ScriptManager.RegisterStartupScript(
                    this, GetType(), "loginWarn",
                    "showLoginAlert('warning','Please enter email and password.');", true);
                return;
            }

            string passwordHash = HashPassword(password);

            using (SqlConnection con = new SqlConnection(
                ConfigurationManager.ConnectionStrings["eJewelDBs"].ConnectionString))
            {
                string query = @"SELECT ID FROM WebUser
                         WHERE Email=@Email AND PasswordHash=@PasswordHash";

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@Email", email);
                cmd.Parameters.AddWithValue("@PasswordHash", passwordHash);

                con.Open();
                object result = cmd.ExecuteScalar();

                if (result != null)
                {
                    int userId = Convert.ToInt32(result);

                    // ✅ SET SESSION
                    Session["UserID"] = userId;
                    Session["UserEmail"] = email;
                    Session["IsLoggedIn"] = true;

                    // ✅ Show success alert + redirect
                    ScriptManager.RegisterStartupScript(
                        this, GetType(), "loginSuccess",
                        "showLoginAlert('success','Login successful! Redirecting...');" +
                        "setTimeout(function(){ window.location='index.aspx'; }, 2000);",
                        true);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(
                        this, GetType(), "loginFail",
                        "showLoginAlert('error','Invalid email or password.');", true);
                }
            }
        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            string email = txtEmail.Text.Trim();
            string password = txtPassword.Text.Trim();

            // ── 1. Basic validation ───────────────────────────────────────
            if (string.IsNullOrWhiteSpace(email) || string.IsNullOrWhiteSpace(password))
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "regVal",
                    "showRegisterAlert('warning', 'Please enter both email and password.');", true);
                return;
            }

            if (password.Length < 6)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "regShort",
                    "showRegisterAlert('warning', 'Password must be at least 6 characters long.');", true);
                return;
            }

            // Very basic email format check (you can use Regex for stricter validation)
            if (!email.Contains("@") || !email.Contains("."))
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "regEmail",
                    "showRegisterAlert('warning', 'Please enter a valid email address.');", true);
                return;
            }

            string passwordHash = HashPassword(password);

            using (SqlConnection con = new SqlConnection(
                ConfigurationManager.ConnectionStrings["eJewelDBs"].ConnectionString))
            {
                con.Open();

                // ── 2. Check if email already exists ─────────────────────────────
                string checkQuery = "SELECT COUNT(*) FROM WebUser WHERE Email = @Email";
                using (SqlCommand checkCmd = new SqlCommand(checkQuery, con))
                {
                    checkCmd.Parameters.AddWithValue("@Email", email);
                    int count = (int)checkCmd.ExecuteScalar();

                    if (count > 0)
                    {
                        ScriptManager.RegisterStartupScript(this, GetType(), "regDup",
                            "showRegisterAlert('error', 'This email is already registered. Please use another email or login.');", true);
                        return;
                    }
                }

                // ── 3. Insert new user ───────────────────────────────────────────
                string insertQuery = @"
            INSERT INTO WebUser 
            (Email, PasswordHash, CreatedDate
            -- , FirstName, LastName, Phone        ← add later if needed
            )
            VALUES 
            (@Email, @PasswordHash, GETDATE())";

                using (SqlCommand cmd = new SqlCommand(insertQuery, con))
                {
                    cmd.Parameters.AddWithValue("@Email", email);
                    cmd.Parameters.AddWithValue("@PasswordHash", passwordHash);
                    // cmd.Parameters.AddWithValue("@FirstName", "");   ← uncomment when added
                    // cmd.Parameters.AddWithValue("@LastName", "");
                    // cmd.Parameters.AddWithValue("@Phone", "");

                    int rowsAffected = cmd.ExecuteNonQuery();

                    if (rowsAffected > 0)
                    {
                        // Show your green success block
                        ScriptManager.RegisterStartupScript(this, GetType(), "regSuccessDiv",
                            "document.getElementById('UserSuccess').style.display = 'block';", true);

                        // Also show floating alert (optional)
                        ScriptManager.RegisterStartupScript(this, GetType(), "regSuccessAlert",
                            "showRegisterAlert('success', 'Registration successful! You can now login.'); " +
                            "setTimeout(function(){ window.location='Login.aspx'; }, 2800);", true);
                    }
                    else
                    {
                        ScriptManager.RegisterStartupScript(this, GetType(), "regFail",
                            "showRegisterAlert('error', 'Registration failed. Please try again later.');", true);
                    }
                }
            }
        }
    }
}