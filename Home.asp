<%@ Language=VBScript %>
<%
If Session("UserID") = "" Then
    ' Redirect to login if not logged in
    Response.Redirect "login.asp"
End If
%>
<!--#include file="includes/header.asp" -->
    <h2 class="h2_text">Welcome to the Home Page</h2>
    <p class="p_text">Hello, User!</p>
    <p class="p_text"><a href="logout.asp">Logout</a></p>
<!--#include file="includes/footer.asp" -->
