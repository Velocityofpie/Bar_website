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
<p style="color:Red;font-size:20px;"> Total sales of all beers that manufacturers produced</p>
<% try {
			// out.println("d");
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();		
			int counter= 0;
			//out.println("d2");
			//Create a SQL statement 
			Statement stmt = con.createStatement();
			//acutal input
			//out.println("d3");
			//String nameofbar = request.getParameter("barname");
			//Get the selected radio button from the index.jsp
			String entity = request.getParameter("Manufacturername");
			
			//Make a SELECT query from the table specified by the 'command' parameter at the index.jsp
			//String entity = "Johnny Trexler";
			//Make a SELECT query from the table specified by the 'command' parameter at the index.jsp
			String str = "select c2.state, sum(quantity) as 'beers sold' from (select c.quantity, c.item, b.state from (select b.bar, t.quantity, t.item from Transactions t join Bills b on b.bill_id = t.bill_id where type = 'beer') c join Bar b on c.bar = b.name) c2 join Beer b2 on b2.name = c2.item where manf = '"+entity+"' group by state order by sum(quantity) desc";
			//out.print(str);
			//Run the query against the database.	
			ResultSet result = stmt.executeQuery(str);
			%>
			<table>
  <thead>
  <td>State</td>
  <td># of Beers sold</td>


  </thead>
  <%
  //parse out the results
  while (result.next()) { %>
  <tr>
    <td><%= result.getString("State") %></td>
    <td><%= result.getString("beers sold") %></td>

    <style>
  td {
      padding: 0 0.5rem;
  }
</style>
  </tr>

  <% }
  //close the connection.
  db.closeConnection(con);
  %>
</table>


		<%
} 
catch (Exception e) {
			out.print(e);
		}%>
</body>

<body>
<p style="color:Red;font-size:20px;">The states where this manufacturer's beers are liked the </p>

<% try {
			// out.println("d");
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();		
			int counter= 0;
			//out.println("d2");
			//Create a SQL statement 
			Statement stmt = con.createStatement();
			//acutal input
			//out.println("d3");
			//String nameofbar = request.getParameter("barname");
			//Get the selected radio button from the index.jsp
			String entity = request.getParameter("Manufacturername");
			
			//Make a SELECT query from the table specified by the 'command' parameter at the index.jsp
			//String entity = "Johnny Trexler";
			//Make a SELECT query from the table specified by the 'command' parameter at the index.jsp
			String str = "select state , count(drinker) as likem from (select l.*, d.state from Likes l join Drinker d on l.drinker = d.name) c join Beer b on c.beer = b.name where manf = '"+entity+"' group by state order by count(drinker) desc";
			//out.print(str);
			//Run the query against the database.	
			ResultSet result = stmt.executeQuery(str);
			%>
			<table>
  <thead>
  <td>State</td>
  <td>Beer's liked</td>


  </thead>
  <%
  //parse out the results
  while (result.next()) { %>
  <tr>
    <td><%= result.getString("state") %></td>
    <td><%= result.getString("likem") %></td>

    <style>
  td {
      padding: 0 0.5rem;
  }
</style>
  </tr>

  <% }
  //close the connection.
  db.closeConnection(con);
  %>
</table>


		<%
} 
catch (Exception e) {
			out.print(e);
		}%>

</body>
</html>