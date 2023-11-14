using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HRWebsite
{
    public partial class Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //Check for shared session with Classic ASP - Browser Cookies and Database before letting user in
            if (!IsPostBack)
            {
                if (Session["SharedSessionID_Net"] == null)
                {
                    // Check if the cookie exists
                    if ((Request.Cookies["SharedSessionID"] != null) && (Request.Cookies["SharedUserID"] != null))
                    {
                        // Cookie exists, you can access its value
                        string SharedSessionID = Request.Cookies["SharedSessionID"].Value;
                        string SharedUserID = Request.Cookies["SharedUserID"].Value;
                        if (GetSession(SharedSessionID, SharedUserID))
                        {
                            //Session exists under database, let user get into Account//
                            // Storing values in Session
                            Session["SharedSessionID_Net"] = SharedSessionID;
                            Session["SharedUserID_Net"] = SharedUserID;
                        }
                        else
                        {
                            //Session & Cookies not found so back to login page
                            Session["SharedSessionID_Net"] = null;
                            Session["SharedUserID_Net"] = null;
                            Response.Redirect("login.asp");
                        }
                    }
                    else
                    {
                        Session["SharedSessionID_Net"] = null;
                        Session["SharedUserID_Net"] = null;
                        //Session & Cookies not found so back to login page
                        Response.Redirect("login.asp");
                    }
                }               
            }

        }

        public static bool GetSession(string SharedSessionID, string SharedUserID)
        {
            try
            {
                SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["HRDBConnection"].ConnectionString);
                using (SqlCommand cmd = new SqlCommand("SELECT UserID,SessionToken FROM Sessions WHERE UserID=@UserID and SessionToken = @SessionToken", con))
                {
                    cmd.Parameters.AddWithValue("@UserID", SharedUserID);
                    cmd.Parameters.AddWithValue("@SessionToken", SharedSessionID);
                    con.Open();
                    // Execute the query and check if any rows are returned
                    int count = Convert.ToInt32(cmd.ExecuteScalar());
                    if (count > 0)
                    {
                        con.Close();
                        return true;
                    }
                    else
                    {
                        con.Close();
                        return false;
                    }
     
                }
            }
            catch(Exception ex)
            {
                return false;
            }

        }
    }
}