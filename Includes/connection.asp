<%
' Database connection settings
Dim dbServer, dbName, dbUsername, dbPassword
dbServer = ""      ' Replace with your SQL Server instance name or IP address
dbName = ""       ' Replace with your database name
dbUsername = ""  ' Replace with your database username
dbPassword = ""   ' Replace with your database password

' Create connection object
Set conn = Server.CreateObject("ADODB.Connection")

' Connection string
connStr = "Provider=SQLOLEDB;Data Source=" & dbServer & ";Initial Catalog=" & dbName & ";User ID=" & dbUsername & ";Password=" & dbPassword & ";"

' Open the connection
conn.Open connStr

' Check for connection errors
If Err.Number <> 0 Then
    Response.Write "Error connecting to the database. " & Err.Description
    Response.End
End If
%>
