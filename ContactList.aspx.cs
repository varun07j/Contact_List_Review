using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HRWebsite
{
    public partial class ContactList : System.Web.UI.Page
    {
        int Comp_ID;
        SqlConnection myCon = new SqlConnection(ConfigurationManager.ConnectionStrings["HRDBConnection"].ConnectionString);

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if(Request.Cookies["SharedUserID"] != null)
                {
                    DoGridView();
                }
                else
                {
                    Response.Redirect("login.asp");
                }                
            }
        }

        private void DoGridView()
        {
            try
            {
                myCon.Open();
                using (SqlCommand myCom = new SqlCommand("dbo.usp_GetContacts", myCon))
                {
                    myCom.Connection = myCon;
                    myCom.CommandType = CommandType.StoredProcedure;
                    myCom.Parameters.Add("@ID", SqlDbType.Int).Value = Convert.ToInt32(Request.Cookies["SharedUserID"].Value);
                    SqlDataReader myDr = myCom.ExecuteReader();

                    gvCompanies.DataSource = myDr;
                    gvCompanies.DataBind();

                    myDr.Close();
                }
            }
            catch (Exception ex) { lblMessage.Text = "Error in Companies doGridView: " + ex.Message; }
            finally { myCon.Close(); }
        } 
        protected void lbNewComp_Click(object sender, EventArgs e)
        {
            try
            {
                txtContactFirstName.Text = "";
                txtCompAddress.Text = "";
                txtCompContactNo.Text = "";

                lblCompanyNew.Visible = true;
                lblCompanyUpd.Visible = false;
                btnAddCompany.Visible = true;
                btnUpdCompany.Visible = false;

                ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openCoDetail();", true);
            }
            catch (Exception) { throw; }
        }
        protected void btnAddCompany_Click(object sender, EventArgs e)
        {
            try
            {
                myCon.Open();
                using (SqlCommand myCom = new SqlCommand("dbo.usp_InsContact", myCon))
                {
                    myCom.CommandType = CommandType.StoredProcedure;
                    myCom.Parameters.Add("@UserID", SqlDbType.VarChar).Value = 1;
                    myCom.Parameters.Add("@ContactFirstName", SqlDbType.VarChar).Value = txtContactFirstName.Text;
                    myCom.Parameters.Add("@ContactLasttName", SqlDbType.VarChar).Value = txtContactLastName.Text;
                    myCom.Parameters.Add("@Email", SqlDbType.VarChar).Value = txtEmail.Text;
                    myCom.Parameters.Add("@CompAddress", SqlDbType.VarChar).Value = txtCompAddress.Text;
                    myCom.Parameters.Add("@Phone", SqlDbType.VarChar).Value = txtCompContactNo.Text;
                    myCom.ExecuteNonQuery();
                }
            }
            catch (Exception ex) { lblMessage.Text = "Error in btnAddContact_Click: " + ex.Message; }
            finally { myCon.Close(); }
            DoGridView();
        }
        protected void btnUpdCompany_Click(object sender, EventArgs e)
        {
            UpdCompany();
            DoGridView();
        }
        protected void gvCompanies_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "UpdCompany")
            {
                Comp_ID = Convert.ToInt32(e.CommandArgument);


                txtContactFirstName.Text = "";
                txtContactLastName.Text = "";
                txtEmail.Text = "";
                txtCompAddress.Text = "";
                txtCompContactNo.Text = "";

                lblCompanyNew.Visible = false;
                lblCompanyUpd.Visible = true;
                btnAddCompany.Visible = false;
                btnUpdCompany.Visible = true;

                GetCompany(Comp_ID);

                ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openCoDetail();", true);
            }
        }
        protected void gvCompanies_RowDeleting(Object sender, GridViewDeleteEventArgs e)
        {
            Comp_ID = Convert.ToInt32(gvCompanies.DataKeys[e.RowIndex].Value.ToString());

            try
            {
                myCon.Open();

                using (SqlCommand cmd = new SqlCommand("dbo.usp_DelContact", myCon))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add("@ID", SqlDbType.Int).Value = Comp_ID;
                    cmd.ExecuteScalar();
                }
            }
            catch (Exception ex) { lblMessage.Text = "Error in gvCompanies_RowDeleting: " + ex.Message; }
            finally { myCon.Close(); }
            DoGridView();
        }
        private void GetCompany(int Comp_ID)
        {
            try
            {
                myCon.Open();
                using (SqlCommand myCmd = new SqlCommand("dbo.usp_GetContact", myCon))
                {
                    myCmd.Connection = myCon;
                    myCmd.CommandType = CommandType.StoredProcedure;
                    myCmd.Parameters.Add("@ID", SqlDbType.Int).Value = Comp_ID;
                    SqlDataReader myDr = myCmd.ExecuteReader();

                    if (myDr.HasRows)
                    {
                        while (myDr.Read())
                        {
                            txtContactFirstName.Text = myDr.GetValue(2).ToString();
                            txtContactLastName.Text = myDr.GetValue(3).ToString();
                            txtEmail.Text = myDr.GetValue(4).ToString();
                            txtCompAddress.Text = myDr.GetValue(6).ToString();
                            txtCompContactNo.Text = myDr.GetValue(5).ToString();
                            lblCompID.Text = Comp_ID.ToString();
                        }
                    }
                }
            }
            catch (Exception ex) { lblMessage.Text = "Error in Contacts GetContacts: " + ex.Message; }
            finally { myCon.Close(); }
        }
        private void UpdCompany()
        {
            try
            {
                myCon.Open();
                using (SqlCommand cmd = new SqlCommand("dbo.usp_UpdContact", myCon))
                {
                    cmd.Connection = myCon;
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.Add("@ID", SqlDbType.Int).Value = int.Parse(lblCompID.Text);
                    cmd.Parameters.Add("@FirstName", SqlDbType.VarChar).Value = txtContactFirstName.Text;
                    cmd.Parameters.Add("@LastName", SqlDbType.VarChar).Value = txtContactLastName.Text;
                    cmd.Parameters.Add("@Email", SqlDbType.VarChar).Value = txtEmail.Text;
                    cmd.Parameters.Add("@Phone", SqlDbType.VarChar).Value = txtCompContactNo.Text;
                    cmd.Parameters.Add("@Address", SqlDbType.VarChar).Value = txtCompAddress.Text;


                    int rows = cmd.ExecuteNonQuery();
                }
            }
            catch (Exception ex) { lblMessage.Text = "Error in Contact UpdContact: " + ex.Message; }
            finally { myCon.Close(); }
        }
    }
}