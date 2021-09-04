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
<p style="color:Red;font-size:20px;">5 top bars where this beer sells the most </p> 
<% try {
	
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();		
			int counter= 0;
			int counternum= 1;
			//Create a SQL statement
			Statement stmt = con.createStatement();
			 
			//acutal input
			
			
			//String nameofbar = request.getParameter("barname");
			
			//Get the selected radio button from the index.jsp
			
			
			//String entity = request.getParameter("command");
			
			String entity6 = request.getParameter("beername");
			//Make a SELECT query from the table specified by the 'command' parameter at the index.jsp
			String str = "select b.bar, sum(t.quantity) as sold from Transactions t inner join Bills b on t.bill_id = b.bill_id where t.item = '"+entity6+"' group by b.bar order by sold DESC LIMIT 5;";
			//Run the query against the database.
			ResultSet result = stmt.executeQuery(str);
		%>
			
		<!--  Make an HTML table to show the results in: -->
		<table>
			<thead>
			<td>Ranking#</td>
 			<td>bar</td>
			<td>Beers sold the most</td>
			</thead>
			<%
			//parse out the results
			while (result.next()) { %>
				<tr>
				<td><%= counternum %></td>
				<td><%= result.getString("bar") %></td>
				<td><%= result.getString("sold") %></td>
				<style>
				td {
				padding: 0 0.5rem;
				}
				</style>
				</tr>
				  
				<%counternum++; }
			//close the connection.
			db.closeConnection(con);
			%>
		</table>
			
		<%} catch (Exception e) {
			out.print(e);
		}%>
</body>

<body>
<p style="color:Red;font-size:20px;">Biggest consumers of this beer </p> 
<% try {
	
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();		
			int counter= 0;
			int counternum= 1;
			//Create a SQL statement
			Statement stmt = con.createStatement();
			 
			//acutal input
			
			
			//String nameofbar = request.getParameter("barname");
			
			//Get the selected radio button from the index.jsp
			
			
			//String entity = request.getParameter("command");
			String entity6 = request.getParameter("beername");
			
			//Make a SELECT query from the table specified by the 'command' parameter at the index.jsp
			String str = "select b.drinker, sum(t.quantity) as count from Transactions t inner join Bills b on t.bill_id = b.bill_id where t.item = '"+entity6+"' group by b.drinker order by count DESC LIMIT 10;";
			//Run the query against the database.
			ResultSet result = stmt.executeQuery(str);
		%>
			
		<!--  Make an HTML table to show the results in: -->
		<table>
			<thead>
			<td>Ranking#</td>
 			<td>Drinkers</td>
			<td>Amount of Beers drunk</td>
			</thead>
			<%
			//parse out the results
			while (result.next()) { %>
				<tr>
				<td><%= counternum %></td>
				<td><%= result.getString("drinker") %></td>
				<td><%= result.getString("count") %></td>
				<style>
				td {
				padding: 0 0.5rem;
				}
				</style>
				</tr>
				  
				<%counternum++; }
			//close the connection.
			db.closeConnection(con);
			%>
		</table>
			
		<%} catch (Exception e) {
			out.print(e);
		}%>
</body>

<body>
<p style="color:Red;font-size:20px;">Time distribution of when this beer sells the most</p> 
<% 
	StringBuilder myData=new StringBuilder();
	String strData ="";
    String chartTitle="";
    String legend="";
	try{
		//this list will hold the x-axis and y-axis data as a pair
		ArrayList<Map<Integer,Integer>> list = new ArrayList();
   		Map<Integer,Integer> map = null;

   		//Get the database connection
   		ApplicationDB db = new ApplicationDB();	
   		Connection con = db.getConnection();		

   		//Create a SQL statement
   		Statement stmt = con.createStatement();
   		String entity6 = request.getParameter("beername");
   		String graphType = "beersPerBar";   
   		//Make a query
   		String query = "" ;   		
   	   		query = "select  sum(t.quantity) as unitssold, hour(b.time) as timeoftheday from Transactions t join Bills b on t.bill_id = b.bill_id where item = '"+entity6+"' group by hour(time) order by hour(time)";
   		
   		
   		//Run the query against the database.
   		ResultSet result = stmt.executeQuery(query);
   		//Process the result
   		while (result.next()) { 
   			map=new HashMap<Integer,Integer>();
   	   			map.put(result.getInt("timeoftheday"),result.getInt("unitssold"));
   	   		
   			list.add(map);
   	    } 
   	    result.close();
   	    
   	    //Create a String of graph data of the following form: ["Caravan", 3],["Cabana",2],...
        for(Map<Integer,Integer> hashmap : list){
        		Iterator it = hashmap.entrySet().iterator();
            	while (it.hasNext()) { 
           		Map.Entry pair = (Map.Entry)it.next();
           		String key = pair.getKey().toString().replaceAll("'", "");
           		myData.append("['"+ key +"',"+ pair.getValue() +"],");
           	}
        }
        strData = myData.substring(0, myData.length()-1); //remove the last comma
        
        //Create the chart title according to what the user selected

          chartTitle = "Number of beers sold by bar";
          legend = "Time of the day";

        //second time 
        
	}catch(SQLException e){
    		out.println(e);
    }
%>
<title>Graphs</title>
		<script src="https://code.highcharts.com/highcharts.js"></script>
		<script> 
		
			var data = [<%=strData%>]; //contains the data of the graph in the form: [ ["Caravan", 3],["Cabana",2],...]
			var title = '<%=chartTitle%>'; 
			var legend = '<%=legend%>'
			//this is an example of other kind of data
			//var data = [["01/22/2016",108],["01/24/2016",45],["01/25/2016",261],["01/26/2016",224],["01/27/2016",307],["01/28/2016",64]];
			var cat = [];
			data.forEach(function(item) {
			  cat.push(item[0]);
			});
			document.addEventListener('DOMContentLoaded', function () {
			var myChart = Highcharts.chart('graphContainer', {
			    chart: {
			        defaultSeriesType: 'column',
			        events: {
			            //load: requestData
			        }
			    },
			    title: {
			        text: title
			    },
			    xAxis: {
			        text: 'xAxis',
			        categories: cat
			    },
			    yAxis: {
			        text: 'yAxis'
			    },
			    series: [{
			        name: legend,
			        data: data
			    }]
			});
			});
		
		</script>
		</head>
	<body>
	<div id="graphContainer" style="width: 900px; height: 600px; margin: 0 auto"></div>

</body>
</html>