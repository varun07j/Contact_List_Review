<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>HR Database Home Page</title>

    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
    <script type="text/javascript" src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css" />

</head>
<body>
    <form id="form1" runat="server">
        <div class="container" align="center">

            <%-- Webpage Heading --%>
            <div class="row">
                <div class="col-xs-12">
                    <h1>Contact Listing Homepage</h1>
                </div>
            </div>

            <%-- Menu / Message --%>
            <div class="navbar-collapse collapse">
                <div class="col-sm-4">
                    <ul class="nav navbar-nav" style="font-weight: bold;">
                        <li>
                            <asp:HyperLink ID="hlHome" NavigateUrl="Default.aspx" runat="server">Home</asp:HyperLink><br />
                        </li>
                        <li>
                            <asp:HyperLink ID="hlCompanies" NavigateUrl="ContactList.aspx" runat="server">Contact Listing</asp:HyperLink><br />
                        </li>
                        <li>
                            <asp:HyperLink ID="HyperLink1" NavigateUrl="LogOut.asp" runat="server">Logout</asp:HyperLink><br />
                        </li>
                    </ul>
                </div>
                <div class="col-sm-4">
                    <asp:Label ID="lblMessage" runat="server" Text="" />
                </div>
                <div class="col-sm-4" style="text-align: right;"></div>
            </div>
        </div>
    </form>
</body>
</html>

