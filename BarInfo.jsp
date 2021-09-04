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
<p style="color:Red;font-size:20px;">Top 10 drinkers who are the largest spenders </p> 
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
			
			String entity = request.getParameter("barname");
			//Make a SELECT query from the table specified by the 'command' parameter at the index.jsp
			String str = "select drinker FROM Bills WHERE bar = '"+entity+"' group by drinker order by sum(total_price) desc limit 10";
			//Run the query against the database.
			ResultSet result = stmt.executeQuery(str);
		%>
			
		<!--  Make an HTML table to show the results in: -->
	<table>
			
  <thead>
 	<td>Ranking#</td>
	<td>Drinker</td>

  </thead>
  <%
  
  //parse out the results
  while (result.next()) { %>
  <tr>
    <td><%= counternum %></td>
    <td><%= result.getString("drinker") %></td>
    
    <style>
  td {
      padding: 0 0.5rem;
  }
</style>
  </tr>
  
  <% counternum++;
  }
  //close the connection.
  db.closeConnection(con);
  %>
</table>

			
		<%} catch (Exception e) {
			out.print(e);
		}%>
</body>

<body>
<p style="color:Red;font-size:20px;"> Top 10 beers which are the most popular </p> 
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
			
			String entity = request.getParameter("barname");
			//Make a SELECT query from the table specified by the 'command' parameter at the index.jsp
			String str = "select distinct t.item, sum(t.quantity) AS units_sold from Transactions t inner join Bills b on t.bill_id = b.bill_id where b.bar = '"+entity+"' and type = 'beer' group by t.item order by sum(t.quantity) desc LIMIT 10;";
			//Run the query against the database.
			ResultSet result = stmt.executeQuery(str);
		%>
			
		<!--  Make an HTML table to show the results in: -->
	<table>
			
  <thead>
 	<td>Ranking#</td>
	<td>Item</td>
	<td># of Units sold</td>

  </thead>
  <%
  
  //parse out the results
  while (result.next()) { %>
  <tr>
    <td><%= counternum %></td>
    <td><%= result.getString("item") %></td>
    <td><%= result.getString("units_sold") %></td>
    
    <style>
  td {
      padding: 0 0.5rem;
  }
</style>
  </tr>
  
  <% counternum++;
  }
  //close the connection.
  db.closeConnection(con);
  %>
</table>

			
		<%} catch (Exception e) {
			out.print(e);
		}%>
</body>

<body>
<p style="color:Red;font-size:20px;">Manufacturers who sell the most beers.</p> 
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
			
			String entity = request.getParameter("barname");
			//Make a SELECT query from the table specified by the 'command' parameter at the index.jsp
			String str = "select b.manf, sum(c.quantity) as units_sold from (select t.item,t.quantity, b.bar from Transactions t inner join Bills b on t.bill_id = b.bill_id where b.bar = '"+entity+"') as c join Beer b on c.item = b.name group by manf order by sum(c.quantity)desc";
			//Run the query against the database.
			ResultSet result = stmt.executeQuery(str);
		%>
			
		<!--  Make an HTML table to show the results in: -->
	<table>
			
  <thead>
  	<td>Ranking#</td>
 	<td>Manufacturers</td>
	<td># of Units sold</td>

  </thead>
  <%
  
  //parse out the results
  while (result.next()) { %>
  <tr>
    <td><%= counternum %></td>
    <td><%= result.getString("manf") %></td>
    <td><%= result.getString("units_sold") %></td>
    
    <style>
  td {
      padding: 0 0.5rem;
  }
</style>
  </tr>
  
  <% counternum++;
  }
  //close the connection.
  db.closeConnection(con);
  %>
</table>

			
		<%} catch (Exception e) {
			out.print(e);
		}%>
</body>
<body>
<p style="color:Red;font-size:20px;">Busiest periods of the day</p> 
<% 
	StringBuilder myData=new StringBuilder();
	String strData ="";
    String chartTitle="";
    String legend="";
	try{
		//this list will hold the x-axis and y-axis data as a pair
		ArrayList<Map<String,Integer>> list = new ArrayList();
   		Map<String,Integer> map = null;

   		//Get the database connection
   		ApplicationDB db = new ApplicationDB();	
   		Connection con = db.getConnection();		

   		//Create a SQL statement
		String entity = request.getParameter("barname");

   		Statement stmt = con.createStatement();
   		//String entity3="monday";
   		//entity3 = request.getParameter("dayselected");
   		String graphType = "beersPerBar";   
   		//Make a query
   		String query = "" ;   		
   	   		query = "select  count(c.bill_id) as total_transaction, timeslot from (select  t.bill_id, hour(b.time) as timeslot from Transactions t inner join Bills b on t.bill_id = b.bill_id where b.bar = '"+entity+"') as c group by timeslot order by timeslot asc";
   		
   		
   		//Run the query against the database.
   		ResultSet result = stmt.executeQuery(query);
   		//Process the result
   		while (result.next()) { 
   			map=new HashMap<String,Integer>();
   	   			map.put(result.getString("timeslot"),result.getInt("total_transaction"));
   	   		
   			list.add(map);
   	    } 
   	    result.close();
   	    
   	    //Create a String of graph data of the following form: ["Caravan", 3],["Cabana",2],...
        for(Map<String,Integer> hashmap : list){
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
          legend = "Time";

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
<body>
<p style="color:Red;font-size:20px;">Time distribution of sales</p> 
<% 
	StringBuilder myData2=new StringBuilder();
	String strData2 ="";
    String chartTitle2="";
    String legend2="";
	try{
		//this list will hold the x-axis and y-axis data as a pair
		ArrayList<Map<String,Integer>> list2 = new ArrayList();
   		Map<String,Integer> map2 = null;

   		//Get the database connection
   		ApplicationDB db = new ApplicationDB();	
   		Connection con = db.getConnection();		

   		//Create a SQL statement
   		Statement stmt2 = con.createStatement();
   		//String entity4="monday";
   		String graphType = "beersPerBar";   
   		//Make a query
   		String query2 = "" ;   		
   	   		query2 = "select sum(total_price) as totalprice2, hour(time) as time2 from Bills group by hour(time) order by hour(time)";
   		
   		
   		//Run the query against the database.
   		ResultSet result2 = stmt2.executeQuery(query2);
   		//Process the result
   		while (result2.next()) { 
   			map2=new HashMap<String,Integer>();
   	   			map2.put(result2.getString("time2"),result2.getInt("totalprice2"));
   	   		
   			list2.add(map2);
   	    } 
   	    result2.close();
   	    
   	    //Create a String of graph data of the following form: ["Caravan", 3],["Cabana",2],...
        for(Map<String,Integer> hashmap : list2){
        		Iterator it2 = hashmap.entrySet().iterator();
            	while (it2.hasNext()) { 
           		Map.Entry pair2 = (Map.Entry)it2.next();
           		String key2 = pair2.getKey().toString().replaceAll("'", "");
           		myData2.append("['"+ key2 +"',"+ pair2.getValue() +"],");
           	}
        }
        strData2 = myData2.substring(0, myData2.length()-1); //remove the last comma
        
        //Create the chart title according to what the user selected

          chartTitle2 = "Number of beers sold by bar";
          legend2 = "Time";

        //second time 
        
	}catch(SQLException e){
    		out.println(e);
    }
%>
<title>Graphs</title>
		<script src="https://code.highcharts.com/highcharts.js"></script>
		<script> 
		
			var data2 = [<%=strData2%>]; //contains the data of the graph in the form: [ ["Caravan", 3],["Cabana",2],...]
			var title2 = '<%=chartTitle2%>'; 
			var legend2 = '<%=legend2%>'
			//this is an example of other kind of data
			//var data = [["01/22/2016",108],["01/24/2016",45],["01/25/2016",261],["01/26/2016",224],["01/27/2016",307],["01/28/2016",64]];
			var cat = [];
			data2.forEach(function(item) {
			  cat.push(item[0]);
			});
			document.addEventListener('DOMContentLoaded', function () {
			var myChart = Highcharts.chart('graphContainer2', {
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
			        name: legend2,
			        data: data2
			    }]
			});
			});
		
		</script>
		</head>
	<body>

	<div id="graphContainer2" style="width: 900px; height: 600px; margin: 0 auto"></div>
</body>
<body>
<p style="color:Red;font-size:20px;"> Bar Analytics </p> 
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
			
			String entity9 = request.getParameter("Beerselcted");
			//Make a SELECT query from the table specified by the 'command' parameter at the index.jsp
			String str = "select  b.bar, count(quantity) as unitsgsold from Transactions t inner join Bills b on t.bill_id = b.bill_id where item = '"+entity9+"' and b.day = 'monday' group by bar order by count(quantity) desc limit  10;";
			//Run the query against the database.
			ResultSet result = stmt.executeQuery(str);
		%>
			
		<!--  Make an HTML table to show the results in: -->
	<table>
			
  <thead>
 	<td>Ranking#</td>
	<td>bar</td>
	<td># of Units sold</td>

  </thead>
  <%
  
  //parse out the results
  while (result.next()) { %>
  <tr>
    <td><%= counternum %></td>
    <td><%= result.getString("bar") %></td>
    <td><%= result.getString("unitsgsold") %></td>
    
    <style>
  td {
      padding: 0 0.5rem;
  }
</style>
  </tr>
  
  <% counternum++;
  }
  //close the connection.
  db.closeConnection(con);
  %>
</table>

			
		<%} catch (Exception e) {
			out.print(e);
		}%>
</body>


</html>
