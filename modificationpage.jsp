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
			String str = request.getParameter("modname");
			String str2 = request.getParameter("modtype");
			//out.println(str);
			//out.println(str2);

					
			if(str2.equals("Insert")){
				if(str.equals("bar")){
					%>
					<form method="get" action="modificationpage.jsp">
					<table>
						<tr>    
							<td>Column Name</td><td><input type="text" name="Updateinfo"></td>
							<td>Column State</td><td><input type="text" name="Updateinfo"></td>
							
						</tr>
					</table>
					<input type="submit" value="Find!">
					</form>
					<%
				}
				else if(str.equals("barfood")){
					%>
					<form method="get" action="modificationpage.jsp">
					<table>
						<tr>    
							<td>Column Name</td><td><input type="text" name="Updateinfo"></td>
						</tr>
					</table>
					<input type="submit" value="Find!">
					</form>
					<%
				}
				else if(str.equals("Bartender")){
					%>
					<form method="get" action="modificationpage.jsp">
					<table>
						<tr>    
							<td>Column Name</td><td><input type="text" name="Updateinfo"></td>
							<td>Column State</td><td><input type="text" name="Updateinfo"></td>
							<td>Column phone</td><td><input type="text" name="Updateinfo"></td>
							
						</tr>
					</table>
					<input type="submit" value="Find!">
					</form>
					<%
				}
				else if(str.equals("beer")){
					%>
					<form method="get" action="modificationpage.jsp">
					<table>
						<tr>    
							<td>Column Name</td><td><input type="text" name="Updateinfo"></td>
							<td>Column Manf</td><td><input type="text" name="Updateinfo"></td>
							
						</tr>
					</table>
					<input type="submit" value="Find!">
					</form>
					<%
				}
				else if(str.equals("bills")){
					%>
					<form method="get" action="modificationpage.jsp">
					<table>
						<tr>    
							<td>Column bill_id</td><td><input type="text" name="Updateinfo"></td>
							<td>Column bar</td><td><input type="text" name="Updateinfo"></td>
							<td>Column Items_price</td><td><input type="text" name="Updateinfo"></td>
							<td>Column Tip</td><td><input type="text" name="Updateinfo"></td>
							<td>Column Time</td><td><input type="text" name="Updateinfo"></td>
							<td>Column day</td><td><input type="text" name="Updateinfo"></td>
							<td>Column date</td><td><input type="text" name="Updateinfo"></td>
							<td>Column drinker</td><td><input type="text" name="Updateinfo"></td>
							<td>Column Tax_price</td><td><input type="text" name="Updateinfo"></td>
							<td>Column Bartender</td><td><input type="text" name="Updateinfo"></td>
							
							
						</tr>
					</table>
					<input type="submit" value="Find!">
					</form>
					<%
				}
				else if(str.equals("days")){
					%>
					<form method="get" action="modificationpage.jsp">
					<table>
						<tr>    
							<td>Column Name</td><td><input type="text" name="Updateinfo"></td>							
						</tr>
					</table>
					<input type="submit" value="Find!">
					</form>
					<%
				}
				else if(str.equals("drink")){
					%>
					<form method="get" action="modificationpage.jsp">
					<table>
						<tr>    
							<td>Column Name</td><td><input type="text" name="Updateinfo"></td>
							<td>Column State</td><td><input type="text" name="Updateinfo"></td>
							
						</tr>
					</table>
					<input type="submit" value="Find!">
					</form>
					<%
				}
				else if(str.equals("frequents")){
					%>
					<form method="get" action="modificationpage.jsp">
					<table>
						<tr>    
							<td>Column Name</td><td><input type="text" name="Updateinfo"></td>
							<td>Column State</td><td><input type="text" name="Updateinfo"></td>
							
						</tr>
					</table>
					<input type="submit" value="Find!">
					</form>
					<%
				}
				else if(str.equals("inventory")){
					%>
					<form method="get" action="modificationpage.jsp">
					<table>
						<tr>    
							<td>Column Name</td><td><input type="text" name="Updateinfo"></td>
							<td>Column State</td><td><input type="text" name="Updateinfo"></td>
							
						</tr>
					</table>
					<input type="submit" value="Find!">
					</form>
					<%
		   		}
				else if(str.equals("likes")){
					%>
					<form method="get" action="modificationpage.jsp">
					<table>
						<tr>    
							<td>Column Name</td><td><input type="text" name="Updateinfo"></td>
							<td>Column State</td><td><input type="text" name="Updateinfo"></td>
							
						</tr>
					</table>
					<input type="submit" value="Find!">
					</form>
					<%
				}
				else if(str.equals("operates")){
					%>
					<form method="get" action="modificationpage.jsp">
					<table>
						<tr>    
							<td>Column Name</td><td><input type="text" name="Updateinfo"></td>
							<td>Column State</td><td><input type="text" name="Updateinfo"></td>
							
						</tr>
					</table>
					<input type="submit" value="Find!">
					</form>
					<%
				}
				else if(str.equals("sellsbeer")){
					%>
					<form method="get" action="modificationpage.jsp">
					<table>
						<tr>    
							<td>Column Name</td><td><input type="text" name="Updateinfo"></td>
							<td>Column State</td><td><input type="text" name="Updateinfo"></td>
							
						</tr>
					</table>
					<input type="submit" value="Find!">
					</form>
					<%
				}
				else if(str.equals("sellsfood")){
					%>
					<form method="get" action="modificationpage.jsp">
					<table>
						<tr>    
							<td>Column Name</td><td><input type="text" name="Updateinfo"></td>
							<td>Column State</td><td><input type="text" name="Updateinfo"></td>
							
						</tr>
					</table>
					<input type="submit" value="Find!">
					</form>
					<%
				}
				else if(str.equals("shifts")){
					%>
					<form method="get" action="modificationpage.jsp">
					<table>
						<tr>    
							<td>Column Name</td><td><input type="text" name="Updateinfo"></td>
							<td>Column State</td><td><input type="text" name="Updateinfo"></td>
							
						</tr>
					</table>
					<input type="submit" value="Find!">
					</form>
					<%
				}
				else if(str.equals("transactions")){
					%>
					<form method="get" action="modificationpage.jsp">
					<table>
						<tr>    
							<td>Column Name</td><td><input type="text" name="Updateinfo"></td>
							<td>Column State</td><td><input type="text" name="Updateinfo"></td>
							
						</tr>
					</table>
					<input type="submit" value="Find!">
					</form>
					<%
				}
				else {
					out.print("");
				}
				
			}
			if(str2.equals("Update")){		
			%>
				
								
						
				<form method="get" action="Update.jsp">
				<table>
					<tr>    
						<td>SET "Name"</td><td><input type="text" name="Updatename"></td>
						<td>, Set "Col2"</td><td><input type="text" name="Col2"></td>
						<td> "Content2"</td><td><input type="text" name="Updatecontent2"></td>
						<td>WHERE "Content"</td><td><input type="text" name="Updatecontent"></td>
						
					</tr>
				</table>
				<input type="submit" value="Find!">
			</form>
			
			<%
			String ustr4 = request.getParameter("modname");
			String ustr3 = request.getParameter("Updatename");
			String ustr6 = request.getParameter("Col2");
			String ustr2 = request.getParameter("Updatecontent2");
			String ustr = "UPDATE "+ustr4+" SET "+ustr6+" = 'Alfred Schmidt', City= 'Frankfurt' WHERE CustomerID = 1;";
			stmt.executeQuery(str);
			}
			else if(str2.equals("Delete")){
				%>
				
				
				<form method="get" action="modificationpage.jsp">
				<table>
					<tr>    
						<td>WHERE "Column Name"</td><td><input type="text" name="Updateinfo"></td>
						<td>Content Name</td><td><input type="text" name="Updateinfo"></td>
						
					</tr>
				</table>
				<input type="submit" value="Find!">
			</form>
			<%
			}
			else{
				out.print("invalid input");
			}
				
			//out.print(str);
			//Run the query against the database.	
			//ResultSet result = stmt.executeQuery(str);
	
			//out.print("It seems that you query has worked");
			%>

		<%
} 
catch (Exception e) {
			out.print("Violates foreign key");
		}%>
</body>


</html>