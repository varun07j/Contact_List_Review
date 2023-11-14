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

    ' Check if username is already taken
    Set checkUser = conn.Execute("SELECT * FROM Users WHERE Username='" & username & "'")
    If checkUser.EOF Then
        ' Insert new user
        conn.Execute "INSERT INTO Users (Username, Password) VALUES ('" & username & "', '" & hashedPassword & "')"
        Response.Redirect "login.asp"
    Else
        Response.Write "Username is already taken. Please choose another one."
    End If
    checkUser.Close
End If
%>
<!--#include file="includes/header.asp" -->
            <p class="p_text">
                Log in or create a new account to access your account.
              </p>
            <h2 class="h2_text">User Registration</h2>
            <div id="login" class="normal_text">
            <form method="post" action="">
                <label>Username:</label>
                <input type="text" name="username" required><br><br>
                <label>Password:</label>
                <input type="password" name="password" required><br><br>
                <input type="submit" value="Register">
            </form>
            <p>Already have an account? <a href="login.asp">Login here</a>.</p>
            </div>
<!--#include file="includes/footer.asp" -->