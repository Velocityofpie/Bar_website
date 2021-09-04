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
<% try {
	ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();	
	Statement stmt = con.createStatement();
	String str4 = request.getParameter("modname");
	String str3 = request.getParameter("Updatename");
	String str2 = request.getParameter("Updatecontent");
	String str = "DELETE FROM "+str4+" WHERE "+str3+"='"+str2+"';";
	stmt.executeQuery(str);
} 
catch (Exception e) {
			out.print("Violates foreign key");
		}%>
</body>
</html>