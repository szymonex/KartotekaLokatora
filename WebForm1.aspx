<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebForm1.aspx.cs" Inherits="KartotekaLokatora.WebForm1" %>

<%@ Register Assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI.DataVisualization.Charting" TagPrefix="asp" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">

<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>Kartoteka Lokatora</title>
    <link href="Layout.css" rel="stylesheet" type="text/css" />
    <link href="CustomStyles.css" rel="stylesheet" />
  </head>
<body>
    <form id="form1" runat="server">
            
            

                    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:LokatorConnectionString %>" SelectCommand="SELECT [Koszt], [DataOdczytu] FROM [OdczytEnergii]"></asp:SqlDataSource>
            
            
                    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:LokatorConnectionString2 %>" SelectCommand="SELECT [DataOdczytu], [KosztZWCW] FROM [OdczytWody]"></asp:SqlDataSource>
            
           <fieldset style="border:0"> 
        <div id="Main">
            <div id="SessionInfo">
               
                <asp:Label ID="Label44" runat="server"></asp:Label>
               
                <asp:Button ID="Button12" runat="server" Height="31px" Text="Wyloguj" Width="122px" OnClick="Button12_Click" />
               
            </div>
            <div id="div1">
                <div id="tableContainer1" class="auto-style10">
                    <asp:MultiView Id="MultiView1" runat="server">
                        <asp:View Id="View1" runat="server">
                    <table id="table1">
                        <tr>
                            <td colspan="4" class="auto-style2">
                                <h2 id="h2energia">Odczyt energii</h2>
                            </td>
                        </tr>
                        <tr>
                            <td class="auto-style6">
                                <asp:Label ID="Label1" runat="server" Text="T1"></asp:Label>
                            </td>
                            <td class="auto-style70">
                                <asp:TextBox ID="TextBox1" runat="server" ValidationGroup="Energia"></asp:TextBox>
                                </td>
                            <td colspan="2">
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="TextBox1" Display="Dynamic" ErrorMessage="Pole nie może być puste." ForeColor="Red" ValidationGroup="Energia" EnableClientScript="False"></asp:RequiredFieldValidator>
                                <asp:CustomValidator ID="CustomValidator1" runat="server" ErrorMessage="Podaj bieżący stan licznika." ControlToValidate="TextBox1" ValidationGroup="Energia" Display="Dynamic" ForeColor="Red" EnableClientScript="false" OnServerValidate="CustomValidator1_ServerValidate"></asp:CustomValidator>
                            </td>
                        </tr>
                        <tr>
                            <td class="auto-style1">
                                <asp:Label ID="Label2" runat="server" Text="T2"></asp:Label>
                            </td>
                            <td class="auto-style71">
                                <asp:TextBox ID="TextBox2" runat="server" ValidationGroup="Energia"></asp:TextBox>
                            </td>
                            <td colspan="2">
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="TextBox2" ErrorMessage="Pole nie może być puste." Display="Dynamic" ForeColor="Red" ValidationGroup="Energia" EnableClientScript="False"></asp:RequiredFieldValidator>
                                <asp:CustomValidator ID="CustomValidator2" runat="server" ErrorMessage="Podaj bieżący stan licznika." ControlToValidate="TextBox2" ValidationGroup="Energia" Display="Dynamic" ForeColor="Red" OnServerValidate="CustomValidator2_ServerValidate"></asp:CustomValidator>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3">
                                <asp:Button ID="Button1" runat="server" Text="Prześlij" Width="122px" ValidationGroup="Energia" OnClick="Button1_Click1"/>
                            </td>
                            <td style="padding-bottom: 21px" padding-left: 20px>
                               
                            </td>
                        </tr>
                    </table>
                            </asp:View>
                        <asp:View ID="View2" runat="server">
                              <table id="table5" class="auto-style75">
                <tr>
                    <th colspan="2" class="auto-style79">
                        <asp:Label Id="Label27" runat="server" style="font-family: Arial" Text="Chcesz przesłać poniższe wskazania licznika?"></asp:Label>
                    </th>
                </tr>
                <tr>
                    <td class="auto-style77">
                        <asp:Label ID="Label28" runat="server" Text="T1" Font-Names="Arial"></asp:Label>
                    </td>
                    <td class="auto-style78">
                        <asp:Label ID="Label29" runat="server" Font-Names="Arial"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style80">
                        <asp:Label ID="Label30" runat="server" Text="T2" Font-Names="Arial"></asp:Label>
                    </td>
                    <td class="auto-style81">
                        <asp:Label ID="Label31" runat="server" Font-Names="Arial"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style76">
                        <asp:Button ID="Button3" runat="server" Text="Zatwierdź" Width="122px" OnClick="Button3_Click" ValidationGroup="Empty" />
                    </td>
                    <td>
                        <asp:Button ID="Button4" runat="server" Text="Cofnij" Width="122px" OnClick="Button4_Click" ValidationGroup="Empty" />
                    </td>
                </tr>
            </table>                                       
                            
                        </asp:View>
                       
                        <asp:View ID="View3" runat="server">
                             <table id="table6" class="auto-style82" style="border-style: solid; border-width: 1px">
                <tr style="font-family: Arial; font-weight:600" >
                    <td style="text-align: center" class="auto-style83">Odczyt został przesłany.<br />
                        Dziękujemy.<br />
                        Pamiętaj o rozliczeniu w przyszłym miesiącu.<br />
                        <br />
                        <asp:Button ID="Button5" runat="server" Text="Powrót" Width="122px" OnClick="Button5_Click" ValidationGroup="Empty" />



                    </td>
                </tr>
               
            </table>
                        </asp:View>
                        <asp:View ID="View4" runat="server">
                            <table id="table7" class="auto-style82" style="border-style: solid; border-width: 1px">
                <tr style="font-family: Arial; font-weight:600" >
                    <td style="text-align: center" class="auto-style83">Transakcja nie jest możliwa.<br />
                        W tym miesiącu odczyt został już przesłany.
                        <br />
                        <br />
                        <br />
                        <asp:Button ID="Button7" runat="server" Text="Powrót" Width="122px" OnClick="Button7_Click" ValidationGroup="Empty" />
                        <br />



                    </td>
                </tr>
               
            </table>
                        </asp:View>
                        </asp:MultiView>
                </div>
                <div id="chartContainer1">
                    <asp:Chart ID="Chart1" runat="server" Height="200px" BorderlineColor="Black" BorderlineDashStyle="Solid" DataSourceID="SqlDataSource1" Width="480px">
                        <Series>
                            <asp:Series Name="Series1" XValueMember="DataOdczytu" YValueMembers="Koszt"></asp:Series>
                        </Series>
                        <ChartAreas>
                            <asp:ChartArea Name="ChartArea1"></asp:ChartArea>
                        </ChartAreas>
                        <Titles>
                            <asp:Title Name="Title1" Text="Koszt zużycia energii" Font="Arial, 9.75pt, style=Bold">
                            </asp:Title>
                        </Titles>
                    </asp:Chart>
                    
                </div>
            </div>
            <div id="div2">
                <div id="tableContainer2">
                    <asp:MultiView ID="MultiView2" runat="server">
                        <asp:View ID="View5" runat="server">
                    <table id="table2">
                        <tr>
                            <td colspan="3" class="auto-style2">
                                <h2 id="h2woda">Odczyt wody</h2>
                            </td>
                        </tr>
                        <tr>
                            <td class="auto-style6">
                                <asp:Label ID="Label3" runat="server" Text="ZW"></asp:Label>
                            </td>
                            <td class="auto-style7">
                                <asp:TextBox ID="TextBox3" runat="server"></asp:TextBox>
                            </td>
                            <td class="auto-style72">
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" Font-Names="Arial" ControlToValidate="TextBox3" Display="Dynamic" ErrorMessage="Pole nie może być puste." ForeColor="Red" ValidationGroup="Woda" EnableClientScript="False"></asp:RequiredFieldValidator>
                                <asp:CustomValidator ID="CustomValidator3" runat="server" Font-Names="Arial" ControlToValidate="TextBox3" ForeColor="Red" Display="Dynamic"  ErrorMessage="Podaj bieżący stan licznika." ValidationGroup="Woda" OnServerValidate="CustomValidator3_ServerValidate" EnableClientScript="False"></asp:CustomValidator>
                            </td>
                        </tr>
                        <tr>
                            <td class="auto-style1">
                                <asp:Label ID="Label4" runat="server" Text="CW"></asp:Label>
                            </td>
                            <td class="auto-style5">
                                <asp:TextBox ID="TextBox4" runat="server"></asp:TextBox>
                            </td>
                            <td class="auto-style72">
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="TextBox4" Display="Dynamic" ErrorMessage="Pole nie może być puste." Font-Names="Arial" ForeColor="Red" EnableClientScript="False" ValidationGroup="Woda"></asp:RequiredFieldValidator>
                                <asp:CustomValidator ID="CustomValidator4" runat="server" ErrorMessage="Podaj bieżący stan licznika." Display="Dynamic" ControlToValidate="TextBox4" ValidationGroup="Woda" ForeColor="Red" Font-Names="Arial" OnServerValidate="CustomValidator4_ServerValidate" EnableClientScript="False"   ></asp:CustomValidator>
                                </td>
                        </tr>
                        <tr>
                            <td colspan="3">
                                <asp:Button ID="Button2" runat="server" Text="Prześlij" Width="122px" ValidationGroup="Woda" OnClick="Button2_Click" />
                            </td>
                        </tr>
                        </table>
                            </asp:View>
                        <asp:View ID="View6" runat="server">
                            <table class="auto-style84" style="border-style: solid; border-width: 1px">
        <tr>
            <th colspan="2" style="font-family: Arial" class="auto-style86">Chcesz przesłać poniższe wskazania liczników?</th>
        </tr>
        <tr>
            <td style="font-family: Arial" class="auto-style88">
                <asp:Label ID="Label40" runat="server" Text="ZW" ></asp:Label>
            </td>
            <td style="font-family: Arial" class="auto-style85">
                <asp:Label ID="Label41" runat="server" Text="Label"></asp:Label>
            </td>
        </tr>
        <tr>
            <td style="font-family: Arial" class="auto-style89">
                <asp:Label ID="Label42" runat="server" Text="CW"></asp:Label>
            </td>
            <td style="font-family: Arial" class="auto-style87">
                <asp:Label ID="Label43" runat="server" Text="Label"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="auto-style91">
                <asp:Button ID="Button8" runat="server" Text="Zatwierdź" Width="122px" OnClick="Button8_Click" ValidationGroup="Empty" />
            </td>
            <td>
                <asp:Button ID="Button9" runat="server" Text="Cofnij" Width="122px" ValidationGroup="Empty" OnClick="Button9_Click" />
            </td>
        </tr>
    </table>
                        </asp:View>
                        <asp:View ID="View7" runat="server">
                            <table id="table8" class="auto-style82" style="border-style: solid; border-width: 1px">
                <tr style="font-family: Arial; font-weight:600" >
                    <td style="text-align: center" class="auto-style83">Odczyt został przesłany.<br />
                        Dziękujemy.<br />
                        Pamiętaj o rozliczeniu w przyszłym miesiącu.<br />
                        <br />
                        <asp:Button ID="Button10" runat="server" Text="Powrót" Width="122px" ValidationGroup="Empty" OnClick="Button10_Click" />



                    </td>
                </tr>
               
            </table>
                        </asp:View>
                        <asp:View ID="View8" runat="server">
                            <table id="table9" class="auto-style82" style="border-style: solid; border-width: 1px">
                <tr style="font-family: Arial; font-weight:600" >
                    <td style="text-align: center" class="auto-style83">Transakcja nie jest możliwa.<br />
                        W tym miesiącu odczyt został już przesłany.
                        <br />
                        <br />
                        <br />
                        <asp:Button ID="Button11" runat="server" Text="Powrót" ValidationGroup="Empty" Width="122px" OnClick="Button11_Click" />
                        <br />



                    </td>
                </tr>
               
            </table>


                        </asp:View>

                        </asp:MultiView>
                </div>
                <div id="chartContainer2">
                    <asp:Chart ID="Chart2" runat="server" Height="200px" Width="480px" BorderlineColor="Black" BorderlineDashStyle="Solid" DataSourceID="SqlDataSource2">
                        <Series>
                            <asp:Series Name="Series1" XValueMember="DataOdczytu" YValueMembers="KosztZWCW"></asp:Series>
                        </Series>
                        <ChartAreas>
                            <asp:ChartArea Name="ChartArea1"></asp:ChartArea>
                        </ChartAreas>
                        <Titles>
                            <asp:Title Font="Arial, 9.75pt, style=Bold" Name="Title1" Text="Koszt zużycia wody">
                            </asp:Title>
                        </Titles>
                    </asp:Chart>
                </div>
                
            </div>

            <div id="div3">
                 <div id="tableContainer3">
                    <table id="table3">
                        <tr>
                            <td colspan="3" class="auto-style51">
                                <h2 id="h2stanKonta">Zaliczki</h2>
                            </td>
                        </tr>
                            
                        
                        <tr>
                            <td class="auto-style49">
                                <asp:Label ID="Label5" runat="server" Text="Suma zaliczek na ZW w bieżącym kwartale:"></asp:Label>
                            </td>
                            <td class="auto-style50">
                                <asp:Label ID="Label6" runat="server"></asp:Label>
                            </td>
                            <td>
                                <asp:Label ID="Label11" runat="server" Text="zł"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td class="auto-style49">
                                <asp:Label ID="Label7" runat="server" Text="Suma zaliczek na CW w bieżącym kwartale:"></asp:Label>
                            </td>
                            <td class="auto-style50">
                                <asp:Label ID="Label8" runat="server"></asp:Label>
                            </td>
                            <td>
                                <asp:Label ID="Label12" runat="server" Text="zł"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td class="auto-style49">
                                <asp:Label ID="Label9" runat="server" Text="Suma zaliczek na CO w okresie grzewczym:"></asp:Label>
                            </td>
                            <td class="auto-style50">
                                <asp:Label ID="Label10" runat="server"></asp:Label>
                            </td>
                            <td>
                                <asp:Label ID="Label13" runat="server" Text="zł"></asp:Label>
                            </td>
                            
                        </tr>
                        <tr>
                            <td colspan="3"></td>
                        </tr>
                    </table>
                </div>
                <div id="tableContainer4">
                    <table id="table4">
                        <tr>
                            <td colspan="4" class="auto-style63">
                                <h2 id="h2bilans">Bilans rachunku</h2>
                            </td>
                        </tr>
                        <tr>
                            <td class="auto-style66">
                                <asp:Label ID="Label14" runat="server" Text="ZW:"></asp:Label>
                            </td>
                            <td class="auto-style68">
                                <asp:Label ID="Label15" runat="server"></asp:Label>
                            </td>
                            <td class="auto-style64">
                                <asp:Label ID="Label16" runat="server"></asp:Label>
                            </td>
                            <td>
                                <asp:Label ID="Label23" runat="server" Text="zł"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td class="auto-style66">
                                <asp:Label ID="Label17" runat="server" Text="CW:"></asp:Label>
                            </td>
                            <td class="auto-style68">
                                <asp:Label ID="Label18" runat="server"></asp:Label>
                            </td>
                            <td class="auto-style64">
                                <asp:Label ID="Label19" runat="server"></asp:Label>
                            </td>
                            <td>
                                <asp:Label ID="Label24" runat="server" Text="zł"></asp:Label>
                            </td>
                        </tr>
                        <tr style="">
                            <td class="auto-style67">
                                <asp:Label ID="Label20" runat="server" Text="Razem:"></asp:Label>
                            </td>
                            <td class="auto-style69">
                                <asp:Label ID="Label21" runat="server"></asp:Label>
                            </td>
                            <td class="auto-style65">
                                <asp:Label ID="Label22" runat="server"></asp:Label>
                            </td>
                            <td>
                                <asp:Label ID="Label25" runat="server" Text="zł"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="4">

                            </td>
                        </tr>
                        
                    </table>
                </div>
            </div>
       
            
         </div>
        
        </fieldset>
        <fieldset style="border: 0">
            <div id="Email">
                kontakt: admin@kartotekalokatora.pl
            </div>
        </fieldset>
    </form>
</body>
</html>
