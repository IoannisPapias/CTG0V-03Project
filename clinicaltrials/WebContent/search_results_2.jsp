<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="clinicaltrials.*"%>
<%@  page import="org.json.JSONArray"%> 
<%@  page import="org.json.JSONObject" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>

    <head>
	       <title lang='gr'>Project CTG0V-03</title>
           <link rel='icon' href='prometheus.png' type='image/png'/>
           <meta name='viewport' content='width=device-width, initial-scale=1.0'></meta>
           <link rel='stylesheet' href='common.css'></link>
          
       </head>
  <body>
           
          <center><a href="home.html"><img src="prometheus.png" alt="CTG0V-03" style="width:200px;height:200px;"></a></center>
           
           <div class="navbar" id='navbar'>
               <a href="home.html">Αρχική Σελίδα</a>
               <a href="about.html">Σχετικά Με</a>
           </div>
           
               
           <br/>
           <br/>
	<%
		if (request.getParameter("title") == null  
				) {
	%>


	<%
			}else {
			
	    String title = request.getParameter("title");
				
		Connection connection = null;
	    Statement statement = null;
	    ResultSet rs = null;
			
		connection = ConnectDB.getConnection();
		statement = connection.createStatement();
		
		rs = statement.executeQuery("Select city1 as city , count(DISTINCT studies.nct_id) as num_studies,latitude ,longitude"  +
				                    " from studies, location, cities" +
				                    " where studies.nct_id = location.nct_id and" +
				                    " location.city1 = cities.city and " +
				                    " title like '%"+title+"%'  " +
				                    " group by city1 order by num_studies desc");  
	
		JSONArray marker = new JSONArray();	
		JSONObject obj = new JSONObject();
		
		if (title == "") {
                   title = "";
             } else {
            	 title = "ΓΙΑ "+title;
         }
		
		%>
		<center>

	<h1> ΠΟΛΕΙΣ ΣΤΙΣ ΟΠΟΙΕΣ ΕΛΑΒΑΝ ΧΩΡΑ ΚΛΙΝΙΚΕΣ ΜΕΛΕΤΕΣ <%=title%></h1>
	

	    <form method="post" action="map.jsp">
	       
		   <table>
		        <tr>
				  <td colspan=1><input type=submit  value="Εμφάνιση αποτελεσμάτων σε χάρτη" style="font-size:18px"/></td>
				   
				</tr>
		    </table>
	
	      </form>
	 
	 
	<br/>
	<br/>	
		
	<table border="5">
	
		<tr>
			<th>ΠΟΛΗ</th>
			<th>ΠΛΗΘΟΣ ΚΛΙΝΙΚΩΝ ΜΕΛΕΤΩΝ</th>	
		</tr>
		
		<%	
		int i=0;
		while (rs.next()) {
			
			//Creating a JSONObject object
			 obj = new JSONObject();
			
			//Inserting key-value pairs into the json object
			 obj.put("lat",rs.getString("latitude"));
             obj.put("lng",rs.getString("longitude"));
             obj.put("num",rs.getString("num_studies"));
             obj.put("city",rs.getString("city"));
            
          i++;
      
             marker.put(obj);
                       
		%>

		<tr>
		    <td><%=rs.getString("city")%></td>		     
		    <td><%=rs.getString("num_studies")%></td>	
		</tr>
					  
		<%
		}
        %>
        		 
       </table>
           	
        <%   
        String jsonText = marker.toString();
        //java.lang.String markers =jsonText;
       // out.println(jsonText);
      		
	  // out.println(application.getRealPath(""));
		   
		// Δημιουργία json αρχείου   	
		FileWriter filewrt = new FileWriter(application.getRealPath("/marker.json"));
        BufferedWriter fileout = new BufferedWriter(filewrt);
        fileout.write(jsonText);
		fileout.close();
		
	//	String fileName = application.getRealPath("/marker.json");
	//	System.out.println(fileName+" records");
	
		rs.close();
			
			}
	    %>
	    
	  </center>

</body>
