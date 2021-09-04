<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
	<body>
<p style="color:Red;font-size:20px;">See all shifts of this bartender</p> 
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
			
			String entity = request.getParameter("Bartendername");
			String entity2 = request.getParameter("barname2");

			//Make a SELECT query from the table specified by the 'command' parameter at the index.jsp
			String str = "select start, end, date from Shifts where bartender = '"+entity+"' and bar = '"+entity2+"'";
			//Run the query against the database.
			ResultSet result = stmt.executeQuery(str);
		%>
			
		<!--  Make an HTML table to show the results in: -->
		<table>
			<thead>
			<td>Date</td>
 			<td>Time started</td>
			<td>Time ended</td>
			</thead>
			<%
			//parse out the results
			while (result.next()) { %>
				<tr>
				<td><%= result.getString("date") %></td>
				<td><%= result.getString("start") %></td>
				<td><%= result.getString("end") %></td>
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
<%String dayselected="";
%>
 
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
   		Statement stmt5 = con.createStatement();
   		Statement stmt8 = con.createStatement();
   		String entity3=request.getParameter("dayselected");
   		//out.print(entity3);
		String entity2 = request.getParameter("barname2");
		String start1 = request.getParameter("starttime");
		String end1 = request.getParameter("endtime");
		//out.println("start:"+start1+"end:"+end1);
   		//entity3 = dayselected;
   		String graphType = "beersPerBar";   
   		//Make a query
   		String query = "" ;
   		String query2 = "" ;
	   		query = "select s.bartender ,sum(c.quantity) as numberofsales from (select  t.quantity ,b.bartender from Transactions t join Bills b on t.bill_id = b.bill_id where bar = '"+entity2+"' and day = '"+entity3+"') c join Shifts s on  c.bartender = s.bartender where start = '"+start1+"' and end ='"+end1+"' group by c.bartender order by sum(c.quantity) desc;";
	   		//query = "select s.bartender ,sum(c.quantity) as numberofsales from (select  t.quantity ,b.bartender from Transactions t join Bills b on t.bill_id = b.bill_id where bar = 'Safe Palm Inn' and day = '"+entity3+"') c join Shifts s on  c.bartender = s.bartender where start = '13:30' and end ='22:30' group by c.bartender order by sum(c.quantity) desc;";

   		
   		//Run the query against the database.
   		ResultSet result = stmt5.executeQuery(query);
   		//Process the result
   		while (result.next()) { 
   			map=new HashMap<String,Integer>();
   	   			map.put(result.getString("bartender"),result.getInt("numberofsales"));
   	   		
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
          legend = entity3;

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