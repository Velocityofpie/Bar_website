<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
<body>
<p style="color:Red;font-size:20px;">All transactions ordered by time</p> 
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
			
			
			String entity3 = request.getParameter("personname");
			
			//Make a SELECT query from the table specified by the 'command' parameter at the index.jsp
			
			
			//String entity = "Johnny Trexler";
			//Make a SELECT query from the table specified by the 'command' parameter at the index.jsp
			String str = "select distinct t.*, b.bar, b.date, b.time from Transactions t inner join Bills b on t.bill_id = b.bill_id where b.drinker = '"+entity3+"' order by b.bar, b.date, b.time;";
			
			//out.print(str);
			//Run the query against the database.
			
			
			ResultSet result = stmt.executeQuery(str);
			%>

			<table>
			
  <thead>
  <td>Bill ID</td>
  <td>Bar</td>
  <td>Item</td>
  <td>Item Type</td>
  <td>Quantity</td>
  <td>Price</td>
  <td>Date</td>
  <td>Time</td>

  </thead>
  <%
  //parse out the results
  while (result.next()) { %>
  <tr>
	<td><%= result.getString("bill_id") %></td>
    <td><%= result.getString("bar") %></td>
    <td><%= result.getString("item") %></td>
    <td><%= result.getString("type") %></td>
    <td><%= result.getString("quantity") %></td>
    <td><%= result.getString("price") %></td>
    <td><%= result.getString("date") %></td>
    <td><%= result.getString("time") %></td>
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
<p style="color:Red;font-size:20px;">The beers s/he orders the most</p> 
<% 
	StringBuilder myData=new StringBuilder();
	String strData ="";
    String chartTitle="";
    String legend="";
	try{
		//this list will hold the x-axis and y-axis data as a pair
		ArrayList<Map<String,Integer>> list= new ArrayList();
   		Map<String,Integer> map = null;

   		//Get the database connection
   		ApplicationDB db = new ApplicationDB();	
   		Connection con = db.getConnection();		

   		//Create a SQL statement
   		Statement stmt = con.createStatement();
   		String entity3 = request.getParameter("personname");
   		String graphType = "beersPerBar";   
   		//Make a query
   		String query = "" ;   		
	   		query = "select t.item, count(t.item) as tc from Transactions t inner join Bills b on t.bill_id = b.bill_id where t.type = 'beer' and b.drinker = '"+entity3+"' group by t.item order by tc DESC;";   		
   		
   		//Run the query against the database.
   		ResultSet result= stmt.executeQuery(query);
   		//Process the result
   		while (result.next()) { 
   			map=new HashMap<String,Integer>();
   	   			map.put(result.getString("item"),result.getInt("tc"));
   	   		
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

          chartTitle = "The beers s/he orders the most";
          legend = "item";

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
<p style="color:Red;font-size:20px;">Time distribution of sales for days</p> 
<% 
	StringBuilder myData2=new StringBuilder();
	String strData2 ="";
    String chartTitle2="";
    String legend2="";
	try{
		//this list will hold the x-axis and y-axis data as a pair
		ArrayList<Map<String,Integer>> list2= new ArrayList();
   		Map<String,Integer> map2 = null;

   		//Get the database connection
   		ApplicationDB db = new ApplicationDB();	
   		Connection con = db.getConnection();		

   		//Create a SQL statement
   		Statement stmt2 = con.createStatement();
   		String entity3 = request.getParameter("personname");
   		String graphType2 = "beersPerBar";   
   		//Make a query
   		String query2 = "" ;   		
	   		query2 = "select b.drinker, b.bar, b.day, sum(b.total_price) as total from Transactions t inner join Bills b on t.bill_id = b.bill_id where b.drinker = '"+entity3+"' group by b.bar, b.day;";   		
   		
   		//Run the query against the database.
   		ResultSet result2= stmt2.executeQuery(query2);
   		//Process the result
   		while (result2.next()) { 
   			map2=new HashMap<String,Integer>();
   	   			map2.put(result2.getString("day"),result2.getInt("total"));
   	   		
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

          chartTitle2 = "Time distribution of sales for days";
          legend2 = "day";

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
			var cat2 = [];
			data2.forEach(function(item2) {
			  cat2.push(item2[0]);
			});
			document.addEventListener('DOMContentLoaded', function () {
			var myChart2 = Highcharts.chart('graphContainer2', {
			    chart: {
			        defaultSeriesType: 'column',
			        events: {
			            //load: requestData
			        }
			    },
			    title: {
			        text: title2
			    },
			    xAxis: {
			        text: 'xAxis',
			        categories: cat2
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
<p style="color:Red;font-size:20px;">Time distribution of sales of Months </p> 
<% 
	StringBuilder myData7=new StringBuilder();
	String strData7 ="";
    String chartTitle7="";
    String legend7="";
	try{
		//this list will hold the x-axis and y-axis data as a pair
		ArrayList<Map<Integer,Integer>> list7= new ArrayList();
   		Map<Integer,Integer> map7 = null;

   		//Get the database connection
   		ApplicationDB db = new ApplicationDB();	
   		Connection con = db.getConnection();		

   		//Create a SQL statement
   		Statement stmt7 = con.createStatement();
   		String entity3 = request.getParameter("personname");
   		String graphType7 = "beersPerBar";   
   		//Make a query
   		String query7 = "" ;   		
	   		query7 = "select b.drinker, b.bar, month(b.date) as month, sum(b.total_price) as total from Transactions t inner join Bills b on t.bill_id = b.bill_id where b.drinker = '"+entity3+"' group by b.bar, month(b.date);";   		
   		
   		//Run the query against the database.
   		ResultSet result7= stmt7.executeQuery(query7);
   		//Process the result
   		while (result7.next()) { 
   			map7=new HashMap<Integer,Integer>();
   	   			map7.put(result7.getInt("month"),result7.getInt("total"));
   	   		
   			list7.add(map7);
   	    } 
   	    result7.close();
   	    
   	    //Create a String of graph data of the following form: ["Caravan", 3],["Cabana",2],...
        for(Map<Integer,Integer> hashmap : list7){
        		Iterator it7 = hashmap.entrySet().iterator();
            	while (it7.hasNext()) { 
           		Map.Entry pair7 = (Map.Entry)it7.next();
           		String key7 = pair7.getKey().toString().replaceAll("'", "");
           		myData7.append("['"+ key7 +"',"+ pair7.getValue() +"],");
           	}
        }
        strData7 = myData7.substring(0, myData7.length()-1); //remove the last comma
        
        //Create the chart title according to what the user selected

          chartTitle7 = "Time distribution of sales of Months";
          legend7 = "Month";

        //second time 
        
	}catch(SQLException e){
    		out.println(e);
    }
%>
<title>Graphs</title>
		<script src="https://code.highcharts.com/highcharts.js"></script>
		<script> 
		
			var data7 = [<%=strData7%>]; //contains the data of the graph in the form: [ ["Caravan", 3],["Cabana",2],...]
			var title7 = '<%=chartTitle7%>'; 
			var legend7 = '<%=legend7%>'
			//this is an example of other kind of data
			//var data = [["01/22/2016",108],["01/24/2016",45],["01/25/2016",261],["01/26/2016",224],["01/27/2016",307],["01/28/2016",64]];
			var cat7 = [];
			data7.forEach(function(item7) {
			  cat7.push(item7[0]);
			});
			document.addEventListener('DOMContentLoaded', function () {
			var myChart7 = Highcharts.chart('graphContainer7', {
			    chart: {
			        defaultSeriesType: 'column',
			        events: {
			            //load: requestData
			        }
			    },
			    title: {
			        text: title7
			    },
			    xAxis: {
			        text: 'xAxis',
			        categories: cat7
			    },
			    yAxis: {
			        text: 'yAxis'
			    },
			    series: [{
			        name: legend7,
			        data: data7
			    }]
			});
			});
		
		</script>
		</head>
	<body>

	<div id="graphContainer7" style="width: 900px; height: 600px; margin: 0 auto"></div>

</body>
</html>
