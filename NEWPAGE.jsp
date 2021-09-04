<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		
		<title> Bar World</title>
		<br>
		

<%


	//Get the database connection
	ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();		
	Statement stmt = con.createStatement();
	ResultSet result = stmt.executeQuery("Select name from beer;");
	//out.print("result:"+result.next());
	
%>


		<style> 
body {
  background-image: url("https://insightfulmanagers.files.wordpress.com/2013/08/image.jpg");
  background-color: #cccccc;
  div.transbox p {
  margin: 5%;
  font-weight: bold;
  color: #000000;
  opacity: .4;
}
}
</style>
<style>
.content {
  max-width: 500px;
  margin: auto;
  padding: 10px;
	background-color:#DCDCDC;

</style>
	</head>

	<body>
<div class="content">
		Welcome to the Bar World <!-- the usual HTML way -->
		
		 <!-- output the same thing, but using 
	                                      jsp programming -->
							  
	<br>
	Finder a drinker info:
	<br>
		<form method="get" action="DrinkerInfo.jsp">
			<table>
				<tr>    
					<td>Preson's Name:</td><td><input type="text" name="personname"></td>
				</tr>
			</table>
			<input type="submit" value="Find!">
		</form>
	<br>
	Finder a Bar info:
	<br>
		<form method="get" action="BarInfo.jsp">
			<table>
				<tr>    
					<td>Bar Name:</td><td><input type="text" name="barname"></td>
				</tr>
			</table>
			<select name="Beerselcted" >
        <%  while(result.next()){ %>
            <option><%= result.getString("name")%></option>
        <% } %>
        </select>
        <% db.closeConnection(con);%>
          <select name="dayselected2" size=1>
				<option value="Monday">Monday</option>
				<option value="Tuesday">Tuesday</option>
				<option value="Wednesday">Wednesday</option>
				<option value="Thursday">Thursday</option>
				<option value="Friday">Friday</option>
				<option value="Saturday">Saturday</option>
				<option value="Sunday">Sunday</option>
			<input type="submit" value="Find!">
		</form>
		

	<br>
	
	Finder a Beer info:
	<br>
		<form method="get" action="BeerInfo.jsp">
			<table>
				<tr>    
					<td>Beer Name:</td><td><input type="text" name="beername"></td>
				</tr>
			</table>
			<input type="submit" value="Find!">
		</form>
	<br>
	Finder a Bartender info:
	<br>
		<form method="get" action="Bartenderinfo.jsp">
			<table>
				<tr>    
					<td>Bartender's Name:</td><td><input type="text" name="Bartendername"></td>
					<td>Bar's Name:</td><td><input type="text" name="barname2"></td>
					
					<tr>
					<td>Start time:</td><td><input type="text" name="starttime"></td>
					<td>End time:</td><td><input type="text" name="endtime"></td>
				</tr>
			</table>
				<select name="dayselected" size=1>
				<option value="Monday">Monday</option>
				<option value="Tuesday">Tuesday</option>
				<option value="Wednesday">Wednesday</option>
				<option value="Thursday">Thursday</option>
				<option value="Friday">Friday</option>
				<option value="Saturday">Saturday</option>
				<option value="Sunday">Sunday</option>
			<input type="submit" value="Find!">
		</form>
	<br>
	Finder a Manufacturer info:
	<br>
		<form method="get" action="ManufacturerInfo.jsp">
			<table>
				<tr>    
					<td>Manufacturer's Name:</td><td><input type="text" name="Manufacturername"></td>
				</tr>
			</table>
			<input type="submit" value="Find!">
		</form>
	<br>
	Modification page for:
	<br>
		<form method="get" action="modificationpage.jsp">
			<select name="modname" size=1>
				<option value="bar">Bar</option>
				<option value="barfood">Bar food</option>
				<option value="bartender">Bar tender</option>
				<option value="beer">Beer</option>
				<option value="bills">Bills</option>
				<option value="days">Days</option>
				<option value="drink">Drink</option>
				<option value="frequents">Frequents</option>
				<option value="inventory">Inventory</option>
				<option value="likes">Likes</option>
				<option value="operates">Operates</option>
				<option value="sellsbeer">Sells beer</option>
				<option value="sellsfood">Sells food</option>
				<option value="shifts">Shifts</option>
				<option value="transactions">Transactions</option>
				<select>
				<select name="modtype" size=1>
					<option value="Insert">Insert</option>
					<option value="Update">Update</option>
					<option value="Delete">Delete</option>
			</select>&nbsp;<br><input type="submit" value="submit"> 

		</form>		
	<br>
		Modification page query:
	<br>
		<form method="get" action="Modpagequick.jsp">
			<table>
				<tr>    
					<td>Query:</td><td><input type="text" name="modquick" style="width: 400px;height:50px;" ></td>
				</tr>
			</table>
			<input type="submit" value="Find!">
		</form>
	<br>
	
</div>

</body>
</html>