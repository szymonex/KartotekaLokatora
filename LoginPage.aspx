<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LoginPage.aspx.cs" Inherits="KartotekaLokatora.LoginPage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"/>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<link href="CustomStyles.css" rel="stylesheet" />
    <title>Kartoteka Lokatora</title>
</head>
<body>
    <form runat="server">
   <div class="container">
      
       <div class="row">
           <div class="col-md-4 offset-4 col-centered">
               <div class="panel panel-default rounded">
                   <asp:MultiView ID="MultiView1" runat="server">
                       <asp:View ID="View1" runat="server">
                   <div class="panel-heading panel-heading-padding">
                       <h3 class="panel-title">Logowanie</h3>
                   </div>
                   
                   <div class="panel-body panel-body-padding">
                      
                       <fieldset>
                           <div class="form-group">
                               <asp:TextBox ID="TextBox1" runat="server" class="form-control" placeholder="Identyfikator"></asp:TextBox>
                               
                           </div>
                           <div class="form-group">
                               <asp:TextBox ID="TextBox2" runat="server" TextMode="Password" class="form-control" placeholder="Hasło"></asp:TextBox>
                              
                           </div>
                           
                           <asp:Button ID="Button1" runat="server" Text="Zaloguj" class="btn btn-lg btn-block" OnClick="Button1_Click"/>
                              
                         </fieldset>
                           
                   </div>
                           </asp:View>
                       <asp:View ID="View2" runat="server">
                           <div class="panel-heading panel-heading-padding">
                       <h3 class="panel-title">Logowanie</h3>
                           </div>
                           <div class="panel-body panel-body-padding">
                      
                       <fieldset>
                           <div id="wrongPass">
                               <h4>Nieprawidłowy identyfikator lub hasło.</h4>
                           </div>
                           <asp:Button ID="Button2" runat="server" Text="Zaloguj się ponownie" class="btn btn-lg btn-block" OnClick="Button2_Click" />
                           </fieldset>
                               </div>
                       </asp:View>
                    </asp:MultiView>
               </div>
           </div>
       </div>
      
   </div>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.6/css/bootstrap.min.css" integrity="sha384-rwoIResjU2yc3z8GV/NPeZWAv56rSmLldC3R/AZzGRnGxQQKnKkoFVhFQhNUwEyJ" crossorigin="anonymous"/>
    <script src="https://code.jquery.com/jquery-3.1.1.slim.min.js" integrity="sha384-A7FZj7v+d/sdmMqp/nOQwliLvUsJfDHW+k9Omg/a/EheAdgtzNs3hpfag6Ed950n" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/tether/1.4.0/js/tether.min.js" integrity="sha384-DztdAPBWPRXSA/3eYEEUWrWCy7G5KFbe8fFjk5JAIxUYHKkDx6Qin1DkWx51bBrb" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.6/js/bootstrap.min.js" integrity="sha384-vBWWzlZJ8ea9aCX4pEW3rVHjgjt7zpkNpZk+02D9phzyeVkE+jo0ieGizqPLForn" crossorigin="anonymous"></script>
        </form>
</body>
</html>
