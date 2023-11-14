<%@ Language=VBScript %>
<%
Session("UserID") = ""
Session("SharedUserID_Net") = ""
Session("SharedSessionID_Net") = ""
' Set the cookie expiration date to the past
Response.Cookies("SharedSessionID").Expires = Now() - 1   
Response.Cookies("SharedUserID").Expires = Now() - 1   
Response.Redirect "login.asp"
%>
