<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
    <%@ page import="java.io.*,java.util.*,java.sql.*"%>
	<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<p style="color:Red;font-size:20px;">Modification Page</p>
<% try {
			// out.println("d");
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();		
			Statement stmt = con.createStatement();
			String strmod = request.getParameter("modquick");
			String query = ""+strmod+"" ;
			out.print(query);
			stmt.executeUpdate(query);
			
			db.closeConnection(con);
			
	} 
	catch (Exception e) {
				out.println("Violates foreign key");
				out.println(e);
				out.println("Violates foreign key");
			}%>
	</body>
	</html>