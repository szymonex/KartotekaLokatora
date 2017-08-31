using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace KartotekaLokatora
{
    public partial class LoginPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            MultiView1.ActiveViewIndex = 0;
            
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            int? returnedValue = null;
            string cs = ConfigurationManager.ConnectionStrings["Lokator"].ConnectionString;
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand("spValidateUserCredentials", con);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                SqlParameter param1 = new SqlParameter("@Login", TextBox1.Text);
                SqlParameter param2 = new SqlParameter("@Password", TextBox2.Text);
                cmd.Parameters.Add(param1);
                cmd.Parameters.Add(param2);
                con.Open();
                returnedValue = Convert.ToInt32(cmd.ExecuteScalar());

            }

            if (returnedValue == 1)
            {
                Session["User_Id"] = TextBox1.Text;
                Session.Timeout = 10;
                Response.Redirect("WebForm1.aspx");
            }
            else
            {
                MultiView1.ActiveViewIndex = 1;
            }
            
        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            MultiView1.ActiveViewIndex = 0;
        }
    }
}