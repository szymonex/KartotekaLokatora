using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Text;
using System.Net.Mail;

namespace KartotekaLokatora
{
    public partial class WebForm1 : System.Web.UI.Page
    {
       
        protected void Page_Load(object sender, EventArgs e)
        {
           if (Session["User_Id"] != null)
           {
                if (!IsPostBack)
                {
                    Label44.Text = GetUsersNameFromDatabaseUponLogin();
                    MultiView1.ActiveViewIndex = 0;
                    MultiView2.ActiveViewIndex = 0;
                }

                Label6.Text = (GetDataFromDatabaseUsingStoredProcedure("spGetQuaterlySumZWFromZaliczki")).ToString("0.00");
                Label8.Text = (GetDataFromDatabaseUsingStoredProcedure("spGetQuaterlySumCWFromZaliczki")).ToString("0.00");
                Label10.Text = (GetDataFromDatabaseUsingStoredProcedure("spGetYearlySumCOFromZaliczki")).ToString("0.00");
                Label16.Text = (Convert.ToDecimal(Label6.Text) - GetDataFromDatabaseUsingStoredProcedure("spGetQuaterlyKosztZWFromOdczytWody")).ToString("0.00");
                Label19.Text = (Convert.ToDecimal(Label8.Text) - GetDataFromDatabaseUsingStoredProcedure("spGetQuaterlyKosztCWFromOdczytWody")).ToString("0.00");

                DisplayAccountBalanceStatus(Label15, Label16);
                DisplayAccountBalanceStatus(Label18, Label19);

                Label22.Text = (Convert.ToDecimal(Label16.Text) + Convert.ToDecimal(Label19.Text)).ToString("0.00");
                DisplayAccountBalanceStatus(Label21, Label22);
           }
           else
           {
               Response.Redirect("LoginPage.aspx");
           }
           
        }

        protected void Button1_Click1(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
               

                if (GetMonthFromOdczytEnergii() == DateTime.Now.Month)
                {
                    MultiView1.ActiveViewIndex = 3;
                }
                else
                {
                    StringBuilder sb1 = new StringBuilder();
                    sb1.Append(TextBox1.Text);
                    sb1.Append("\t");
                    sb1.Append("kWh");

                    StringBuilder sb2 = new StringBuilder();
                    sb2.Append(TextBox2.Text);
                    sb2.Append("\t");
                    sb2.Append("kWh");

                    Label29.Text = sb1.ToString();
                    Label31.Text = sb2.ToString();

                    MultiView1.ActiveViewIndex = 1;
                }
            }
           
            
            
        }
        

        // metoda steruje treścią środkowej kolumny w polu Bilans Konta 

        protected void DisplayAccountBalanceStatus(Label label1, Label label2)
        {
            if (Convert.ToDecimal(label2.Text) > 0)
            {
                label1.ForeColor = System.Drawing.Color.DarkOliveGreen;
                label1.Text = "Nadpłata";
            }
            else if (Convert.ToDecimal(label2.Text) < 0)
            {
                label1.ForeColor = System.Drawing.Color.Red;
                label1.Text = "Niedopłata";
            }
            else
            {
                label1.Text = String.Empty;
            }
        }

        // metoda sprawdza czy podana wartość taryfy T1 jest większa od ostatniej wartości wpisanej w bazie
        // oraz czy wpisana wartość w pole TextBox1 może byc zamieniona na int

        protected void CustomValidator1_ServerValidate(object source, ServerValidateEventArgs args)
        {
                     
            int result = 0;
                                    
            if (Int32.TryParse(args.Value, out result) && GetLicznikT1FromDatabase() < result)
            {
                args.IsValid = true;
            }
            else
            {
                args.IsValid = false;
            }
        }

        // metoda sprawdza czy podana wartość taryfy T2 jest większa od ostatniej wartości wpisanej w bazie
        // oraz czy wpisana wartość w pole TextBox2 może być zamieniona na typ int

        protected void CustomValidator2_ServerValidate(object source, ServerValidateEventArgs args)
        {
            int result = 0;

            if (Int32.TryParse(args.Value, out result) && GetLicznikT2FromDatabase() < result)
            {
                args.IsValid = true;
            }
            else
            {
                args.IsValid = false;
            }
        }

        // zwraca z bazy sumę zaliczek na ZW, CW lub CO, przyjmuje jako parametr nazwę procedury składowanej

        protected decimal GetDataFromDatabaseUsingStoredProcedure(string storedProcedureName)
        {
            string cs1 = ConfigurationManager.ConnectionStrings["Lokator"].ConnectionString;
            SqlConnection con1 = new SqlConnection(cs1);
            SqlCommand cmd = new SqlCommand(storedProcedureName, con1);
            cmd.CommandType = System.Data.CommandType.StoredProcedure;
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            da.Fill(ds, "Odczyt");
            decimal valueReturnedFromZaliczki = Convert.ToDecimal(ds.Tables[0].Rows[0][0]);

            return valueReturnedFromZaliczki;
        }
               

        //metoda zwraca miesiąc z tabeli OdczytEnergii w bazie danych 

        protected int GetMonthFromOdczytEnergii()
        {
            string cs1 = ConfigurationManager.ConnectionStrings["Lokator"].ConnectionString;
            SqlConnection con1 = new SqlConnection(cs1);
            SqlDataAdapter da = new SqlDataAdapter("Select Month(DataOdczytu) from OdczytEnergii where Id = (Select Max(Id) from OdczytEnergii)", con1);
            DataSet ds = new DataSet();
            da.Fill(ds, "Odczyt");
            int month = Convert.ToInt32(ds.Tables[0].Rows[0][0]);

            return month;
        
        }

        // sprawdza miesiąc ostatniego odczytu wody zapisanego w bazie

        protected int GetMonthFromOdczytWody()
        {
            string cs1 = ConfigurationManager.ConnectionStrings["Lokator"].ConnectionString;
            SqlConnection con1 = new SqlConnection(cs1);
            SqlDataAdapter da = new SqlDataAdapter("Select Month(DataOdczytu) from OdczytWody where Id = (Select Max(Id) from OdczytWody)", con1);
            DataSet ds = new DataSet();
            da.Fill(ds, "Odczyt");
            int month = Convert.ToInt32(ds.Tables[0].Rows[0][0]);

            return month;
        }

        //metoda zwraca z bazy ostatni podany stan licznika T1

        protected int GetLicznikT1FromDatabase ()
        {
            string cs1 = ConfigurationManager.ConnectionStrings["Lokator"].ConnectionString;
            SqlConnection con1 = new SqlConnection(cs1);
            SqlDataAdapter da = new SqlDataAdapter("Select LicznikT1 from OdczytEnergii where Id = (Select Max(Id) from OdczytEnergii)", con1);
            DataSet ds = new DataSet();
            da.Fill(ds, "Odczyt");
            int licznikT1 = Convert.ToInt32(ds.Tables[0].Rows[0][0]);

            return licznikT1;
            
        }

        //metoda zwraca z bazy ostatni podany stan licznika T2

        protected int GetLicznikT2FromDatabase ()
        {
            string cs1 = ConfigurationManager.ConnectionStrings["Lokator"].ConnectionString;
            SqlConnection con1 = new SqlConnection(cs1);
            SqlDataAdapter da = new SqlDataAdapter("Select LicznikT2 from OdczytEnergii where Id = (Select Max(Id) from OdczytEnergii)", con1);
            DataSet ds = new DataSet();
            da.Fill(ds, "Odczyt");
            int licznikT2 = Convert.ToInt32(ds.Tables[0].Rows[0][0]);

            return licznikT2;
        }
        
        //metoda zwraca z bazy ostatni podany stan licznika ZW

        protected int GetZWFromDatabase()
        {
            string cs1 = ConfigurationManager.ConnectionStrings["Lokator"].ConnectionString;
            SqlConnection con1 = new SqlConnection(cs1);
            SqlDataAdapter da = new SqlDataAdapter("Select ZW from OdczytWody where Id = (Select Max(Id) from OdczytWody)", con1);
            DataSet ds = new DataSet();
            da.Fill(ds, "Odczyt");
            int ZW = Convert.ToInt32(ds.Tables[0].Rows[0][0]);

            return ZW;
        }

        // metoda zwraca z bazy ostatni podany stan licznika CW

        protected int GetCWFromDatabase()
        {
            string cs1 = ConfigurationManager.ConnectionStrings["Lokator"].ConnectionString;
            SqlConnection con1 = new SqlConnection(cs1);
            SqlDataAdapter da = new SqlDataAdapter("Select CW from OdczytWody where Id = (Select Max(Id) from OdczytWody)", con1);
            DataSet ds = new DataSet();
            da.Fill(ds, "Odczyt");
            int CW = Convert.ToInt32(ds.Tables[0].Rows[0][0]);

            return CW;
        }

        // przesłanie danych pobranych od użytkownika do bazy

        protected void Button3_Click(object sender, EventArgs e)
        {


            string cs2 = ConfigurationManager.ConnectionStrings["Lokator"].ConnectionString;
            using (SqlConnection con2 = new SqlConnection(cs2))
            {
                SqlCommand cmd = new SqlCommand("spInsertDataIntoOdczytEnergii", con2);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                SqlParameter param1 = new SqlParameter("@StanObecnyT1", TextBox1.Text);
                SqlParameter param2 = new SqlParameter("@StanObecnyT2", TextBox2.Text);
                con2.Open();
                cmd.Parameters.Add(param1);
                cmd.Parameters.Add(param2);
                cmd.ExecuteNonQuery();

            }

            MultiView1.ActiveViewIndex = 2;



        }

        // Powrót do Widoku o indeksie 0

        protected void Button4_Click(object sender, EventArgs e)
        {

            MultiView1.ActiveViewIndex = 0;
            TextBox1.Text = String.Empty;
            TextBox2.Text = String.Empty;
        }

        protected void Button5_Click(object sender, EventArgs e)
        {
            MultiView1.ActiveViewIndex = 0;
            TextBox1.Text = String.Empty;
            TextBox2.Text = String.Empty;
        }

        protected void Button7_Click(object sender, EventArgs e)
        {
            MultiView1.ActiveViewIndex = 0;
            TextBox1.Text = String.Empty;
            TextBox2.Text = String.Empty;
        }

        //metoda obsługująca zdarzenie walidacji pola TextBox3

        protected void CustomValidator3_ServerValidate(object source, ServerValidateEventArgs args)
        {
            int result = 0;

            if (Int32.TryParse(args.Value, out result) && GetZWFromDatabase() < result)
            {
                args.IsValid = true;
            }
            else
            {
                args.IsValid = false;
            }
        }

        // metoda obsługująca zdarzenie walidacji pola TextBox4
         
        protected void CustomValidator4_ServerValidate(object source, ServerValidateEventArgs args)
        {
            int result = 0;

            if (Int32.TryParse(args.Value, out result) && GetCWFromDatabase() < result)
            {
                args.IsValid = true;
            }
            else
            {
                args.IsValid = false;
            }
        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
               //if (GetMonthFromOdczytWody() == DateTime.Now.Month)
               //{
                 //   MultiView2.ActiveViewIndex = 3;
              // }
              // else
               //{
                    StringBuilder sb1 = new StringBuilder();
                    sb1.Append(TextBox3.Text);
                    sb1.Append("\t");
                    sb1.Append("m\xB3");

                    StringBuilder sb2 = new StringBuilder();
                    sb2.Append(TextBox4.Text);
                    sb2.Append("\t");
                    sb2.Append("m\xB3");

                    Label41.Text = sb1.ToString();
                    Label43.Text = sb2.ToString();

                    MultiView2.ActiveViewIndex = 1;
               //}
            }
        }

        //przesyła odczyt licznika ZW i CW do bazy

        protected void Button8_Click(object sender, EventArgs e)
        {
            string cs2 = ConfigurationManager.ConnectionStrings["Lokator"].ConnectionString;
            using (SqlConnection con2 = new SqlConnection(cs2))
            {
                SqlCommand cmd = new SqlCommand("spInsertDataIntoOdczytWody", con2);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                SqlParameter param1 = new SqlParameter("@StanObecnyZW", TextBox3.Text);
                SqlParameter param2 = new SqlParameter("@StanObecnyCW", TextBox4.Text);
                con2.Open();
                cmd.Parameters.Add(param1);
                cmd.Parameters.Add(param2);
                cmd.ExecuteNonQuery();

            }

            MultiView2.ActiveViewIndex = 2;

            SendEmail(buildMessageBody());
           

            
        }

        

        protected void Button9_Click(object sender, EventArgs e)
        {
            TextBox3.Text = String.Empty;
            TextBox4.Text = String.Empty;
            MultiView2.ActiveViewIndex = 0;
        }

        protected void Button10_Click(object sender, EventArgs e)
        {
            MultiView2.ActiveViewIndex = 0;
            TextBox3.Text = String.Empty;
            TextBox4.Text = String.Empty;
        }

        protected void Button11_Click(object sender, EventArgs e)
        {
            MultiView2.ActiveViewIndex = 0;
            TextBox3.Text = String.Empty;
            TextBox4.Text = String.Empty;
        }

        // metoda wywyła emial pd wskazany adres

        protected void SendEmail(string messageBody)
        {
            MailAddress mailAddress = new MailAddress("*********************", "Lotników 19A/27");
            MailMessage email = new MailMessage();
            email.To.Add("**************");
            email.To.Add("******************");
            email.From = mailAddress;
            email.Subject = "Odczyt liczników wody";
            email.Body = messageBody;

            
            SmtpClient smtpClient = new SmtpClient("smtp.wp.pl", 587);
            smtpClient.Credentials = new System.Net.NetworkCredential()
            {
                UserName = "****************",
                Password = "****************"
            };
            smtpClient.DeliveryMethod = SmtpDeliveryMethod.Network;
            smtpClient.EnableSsl = true;
            smtpClient.Send(email);
        }

        // zwraca treść wiadomości email

        protected string buildMessageBody()
        {
            StringBuilder messageBody = new StringBuilder();
            messageBody.Append("Dzień dobry");
            messageBody.Append(Environment.NewLine);
            messageBody.Append(Environment.NewLine);
            messageBody.Append("Lokator Artur Czaja przesyła odczyt liczników wody z dnia ");
            DateTime dateOnly = DateTime.Now;
            messageBody.Append(dateOnly.ToShortDateString());
            messageBody.Append(Environment.NewLine);
            messageBody.Append(Environment.NewLine);
            messageBody.Append("ZW: ");
            messageBody.Append(TextBox3.Text);
            messageBody.Append(Environment.NewLine);
            messageBody.Append("CW: ");
            messageBody.Append(TextBox4.Text);
            messageBody.Append(Environment.NewLine);
            messageBody.Append(Environment.NewLine);
            messageBody.Append("Pozdrawiam,\n Administrator");

            return messageBody.ToString();

        }

        // wylogowanie z sesji

        protected void Button12_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();
            Response.Redirect("LoginPage.aspx");
        }

        protected string GetUsersNameFromDatabaseUponLogin()
        {
            string userName = String.Empty;
            string cs = ConfigurationManager.ConnectionStrings["Lokator"].ConnectionString;
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand("spGetUsersNameUponLogin", con);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                if (Session["User_Id"] != null)
                {
                    string sessionState = Convert.ToString(Session["User_Id"]);
                    SqlParameter param1 = new SqlParameter("@Login", sessionState);
                    cmd.Parameters.Add(param1);
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataSet ds = new DataSet();
                    da.Fill(ds);
                    userName = ds.Tables[0].Rows[0][0].ToString();
                }

            }

            return userName;
        }
    }
}