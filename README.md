**Contact List Project****

**Production URL:**
http://memberportal-backup.azurewebsites.net/Contact_List_Project/login.asp

**Overview****

This is a simple Classic ASP and ASP.NET project with a basic login functionality with feature of adding contacts under your account. The project is built using Classic ASP and ASP.NET Web Forms and utilizes a SQL Server database for user authentication. It shares the session between classic ASP and ASP.net pages through shared sessions and cookies.

**Features**

User registration

User login/logout

Add Contacts under account

SQL Server database for user data storage

Technologies Used

Classic ASP

ASP.NET Web Forms

C#

SQL Server

**Getting Started**

Prerequisites

Visual Studio

SQL Server Management Studio (SSMS) or a similar database management tool

.NET Framework (3.5 or later)

****Installation**

**
Clone the repository:

bash

Copy code

git clone https://github.com/varun07j/Contact_List.git

Open the project in Visual Studio.

Update the connection string in Web.config to point to your SQL Server database.

Update the connection string in connection.asp to your SQL Server database

xml

Copy code

<connectionStrings>
    <add name="DefaultConnection" connectionString="your-connection-string-here" providerName="System.Data.SqlClient" />
</connectionStrings>
        
Open the SQL Server Management Studio and execute the SQL script Contact_List.sql at the root directory to create the necessary tables.

Build and run the project.

**Database Schema**

The database schema includes the following tables:

ActivityLog

Contacts

Roles

Sessions

UserRoles

Users

