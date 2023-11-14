<%@ Language=VBScript %>
<!--#include file="includes/connection.asp" -->
<%
If Request.ServerVariables("REQUEST_METHOD") = "POST" Then
    Dim username, password
    username = Request.Form("username")
    password = Request.Form("password")

    ' Hash and salt the password (implement your own secure hashing)
    ' For simplicity, plain text password is used here
    Dim hashedPassword
    hashedPassword = password

    ' Check if user exists
    Set checkUser = conn.Execute("SELECT * FROM Users WHERE Username='" & username & "' AND Password='" & hashedPassword & "'")
    If Not checkUser.EOF Then
        ' User found, set session variable and redirect to home page
        Session("UserID") = checkUser("UserID")
        ' Set a common cookie as we need to share session with asp.net web application and also save te session under database.
        Response.Cookies("SharedSessionID") = Session.SessionID
        Response.Cookies("SharedUserID") = checkUser("UserID")
        conn.Execute "INSERT INTO Sessions (SessionToken, UserID,CreatedDate) VALUES ('" & Session.SessionID & "', '" & checkUser("UserID") & "',GETDATE())"
        Response.Redirect "Default.aspx"
    Else
        Response.Write "Invalid username or password."
    End If
    checkUser.Close
End If
%>
<!--#include file="includes/header.asp" -->
    <p class="p_text">
        Log in or create a new account to access your account.
      </p>
    <h2 class="h2_text">User Login</h2>
    <div id="login" class="normal_text">
        <form method="post" action="">
            <label>Username:</label>
            <input type="text" name="username" required><br><br>
            <label>Password:</label>
            <input type="password" name="password" required><br><br>
            <input type="submit" value="Login">
        </form>
        <p>Don't have an account? <a href="register.asp">Register here</a>.</p>
    </div>
<!--#include file="includes/footer.asp" -->

