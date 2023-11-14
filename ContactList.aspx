<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ContactList.aspx.cs" Inherits="HRWebsite.ContactList" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Companies Homepage</title>

    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
    <script type="text/javascript" src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css" />

    <script type="text/javascript">
        function openCoDetail() {
            //alert("Opening modal!");
            $('#modCoDetail').modal('show');
        }
    </script>

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

            <%-- Menu / Message / New link --%>
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
                <div class="col-sm-4" style="text-align: right;">
                    <asp:Label ID="Label5" runat="server" Text="[" Font-Size="12px" Visible="true"></asp:Label>
                    <asp:LinkButton ID="lbNewComp" runat="server" Font-Size="12px" OnClick="lbNewComp_Click">New</asp:LinkButton>
                    <asp:Label ID="Label6" runat="server" Text="]" Font-Size="12px" Visible="true"></asp:Label>
                </div>
            </div>

            <%-- Gridview --%>
            <div class="row" style="margin-top: 20px;">
                <div class="col-sm-12">
                    <asp:GridView ID="gvCompanies" runat="server" AutoGenerateColumns="False" AllowSorting="True"
                        DataKeyNames="ContactID"
                        CssClass="table table-striped table-bordered table-condensed" BorderColor="Silver"
                        OnRowDeleting="gvCompanies_RowDeleting"
                        OnRowCommand="gvCompanies_RowCommand"
                        EmptyDataText="No data for this request!">
                        <Columns>
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <%# Container.DataItemIndex + 1 %>
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Left" Width="25px" />
                                <ItemStyle HorizontalAlign="Left" Font-Bold="true" />
                            </asp:TemplateField>
                            <asp:BoundField DataField="FirstName" HeaderText="First Name">
                                <HeaderStyle HorizontalAlign="Left" />
                                <ItemStyle HorizontalAlign="Left" />
                            </asp:BoundField>
                            <asp:BoundField DataField="LastName" HeaderText="Last Name">
                                <HeaderStyle HorizontalAlign="Left" />
                                <ItemStyle HorizontalAlign="Left" />
                            </asp:BoundField>
                            <asp:BoundField DataField="Email" HeaderText="Email Address">
                                <HeaderStyle HorizontalAlign="Left" />
                                <ItemStyle HorizontalAlign="Left" />
                            </asp:BoundField>

                            <asp:BoundField DataField="Phone" HeaderText="Phone">
                                <HeaderStyle HorizontalAlign="Left" />
                                <ItemStyle HorizontalAlign="Left" />
                            </asp:BoundField>

                             <asp:BoundField DataField="Address" HeaderText="Address">
                                <HeaderStyle HorizontalAlign="Left" />
                                <ItemStyle HorizontalAlign="Left" />
                            </asp:BoundField>

                            <%-- Delete Company --%>
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <asp:LinkButton ID="lbDelCompany" Text="Del" runat="server"
                                        OnClientClick="return confirm('Are you sure you want to delete this company?');" CommandName="Delete" />
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Left" />
                                <ItemStyle HorizontalAlign="Center" Width="50px" />
                            </asp:TemplateField>

                            <%-- Update Company --%>
                            <asp:TemplateField HeaderText="">
                                <ItemTemplate>
                                    <asp:LinkButton ID="lbUpdCompany" runat="server" CommandArgument='<%# Eval("ContactID") %>'
                                        CommandName="UpdCompany" Text="Upd" CausesValidation="false"></asp:LinkButton>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" Width="80px" />
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </div>
            </div>
        </div>

        <!-- Modal to Add New or View / Update a Contact Details-->
        <div class="modal fade" id="modCoDetail" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg" style="width: 600px;">
                <div class="modal-content" style="font-size: 11px;">

                    <div class="modal-header" style="text-align: center;">
                        <asp:Label ID="lblCompanyNew" runat="server" Text="Add New Contact" Font-Size="24px" Font-Bold="true" />
                        <asp:Label ID="lblCompanyUpd" runat="server" Text="View / Update a Contact" Font-Size="24px" Font-Bold="true" />
                    </div>

                    <div class="modal-body">
                        <div class="row">
                            <div class="col-sm-12">

                                <%-- Contact Details Textboxes --%>
                                <div class="col-sm-12">
                                    <div class="row" style="margin-top: 20px;">
                                        <div class="col-sm-1"></div>
                                        <div class="col-sm-10">
                                            <asp:TextBox ID="txtContactFirstName" runat="server" MaxLength="255" CssClass="form-control input-xs" 
                                                ToolTip="Contact Name"
                                                AutoCompleteType="Disabled" placeholder="First Name" />
                                            <asp:Label runat="server" ID="lblCompID" Visible="false" Font-Size="12px" />
                                        </div>
                                        <div class="col-sm-1">
                                        </div>
                                    </div>

                                   <div class="row" style="margin-top: 20px;">
                                        <div class="col-sm-1"></div>
                                        <div class="col-sm-10">
                                            <asp:TextBox ID="txtContactLastName" runat="server" MaxLength="255" CssClass="form-control input-xs" 
                                                ToolTip="Contact Name"
                                                AutoCompleteType="Disabled" placeholder="Last Name" />
                                            <asp:Label runat="server" ID="Label1" Visible="false" Font-Size="12px" />
                                        </div>
                                        <div class="col-sm-1">
                                        </div>
                                    </div>

                                     <div class="row" style="margin-top: 20px;">
                                        <div class="col-sm-1"></div>
                                        <div class="col-sm-10">
                                            <asp:TextBox ID="txtEmail" runat="server" MaxLength="255" CssClass="form-control input-xs" 
                                                ToolTip="Email"
                                                AutoCompleteType="Disabled" placeholder="Email Address" />
                                            <asp:Label runat="server" ID="Label2" Visible="false" Font-Size="12px" />
                                        </div>
                                        <div class="col-sm-1">
                                        </div>
                                    </div>


                                   <div class="row" style="margin-top: 20px;">
                                        <div class="col-sm-1"></div>
                                        <div class="col-sm-10">
                                            <asp:TextBox ID="txtCompContactNo" runat="server" MaxLength="255" CssClass="form-control input-xs" 
                                                ToolTip="Company Contact Number"
                                                AutoCompleteType="Disabled" placeholder="Contact Number" />
                                        </div>
                                        <div class="col-sm-1">
                                        </div>
                                    </div>

                                    <div class="row" style="margin-top: 20px;">
                                        <div class="col-sm-1"></div>
                                        <div class="col-sm-10">
                                            <asp:TextBox ID="txtCompAddress" runat="server" MaxLength="255" CssClass="form-control input-xs" 
                                                ToolTip="Company Address"
                                                AutoCompleteType="Disabled" placeholder="Contact Address" />
                                        </div>
                                        <div class="col-sm-1">
                                        </div>
                                    </div>

                                </div>
                            </div>

                        </div>

                        <%-- Message label on modal page --%>
                        <div class="row" style="margin-top: 20px; margin-bottom: 10px;">
                            <div class="col-sm-1"></div>
                            <div class="col-sm-10">
                                <asp:Label ID="lblModalMessage" runat="server" ForeColor="Red" Font-Size="12px" Text="" />
                            </div>
                            <div class="col-sm-1"></div>
                        </div>
                    </div>

                    <%-- Add, Update and Cancel Buttons --%>
                    <div class="modal-footer">
                        <asp:Button ID="btnAddCompany" runat="server" class="btn btn-danger button-xs" data-dismiss="modal" 
                            Text="Add Contact"
                            Visible="true" CausesValidation="false"
                            OnClick="btnAddCompany_Click"
                            UseSubmitBehavior="false" />
                        <asp:Button ID="btnUpdCompany" runat="server" class="btn btn-danger button-xs" data-dismiss="modal" 
                            Text="Update Contact"
                            Visible="false" CausesValidation="false"
                            OnClick="btnUpdCompany_Click"
                            UseSubmitBehavior="false" />
                        <asp:Button ID="btnClose" runat="server" class="btn btn-info button-xs" data-dismiss="modal" 
                            Text="Close" CausesValidation="false"
                            UseSubmitBehavior="false" />
                    </div>

                </div>
            </div>
        </div>
    </form>
</body>
</html>


