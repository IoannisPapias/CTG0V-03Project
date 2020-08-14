<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="java.sql.*"%>
<%@ page import="clinicaltrials.*"%>


<!-- ---- ΑΝΑΖΗΤΗΣΗ ΒΑΣΕΙ ΑΣΘΕΝΕΙΑΣ ΚΑΙ ΕΜΦΑΝΙΣΗ ΚΛΙΝΙΚΩΝ ΜΕΛΕΤΩΝ (ΚΩΔΙΚΟΣ ΜΕΛΕΤΗΣ, ΤΙΤΛΟΣ, ΙΝΣΤΙΤΟΥΤΟ, ΠΟΛΗ, STATUS)----- -->

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

// Εισαγωγή ασθένειας για αναζήτηση στη βάση
//This method is used to get the value of a request’s parameter	   
	   
		if (request.getParameter("title") == null  
				) {
	%>

	       <br />
	       
	       <h2>Αναζήτηση κλινικών μελετών στον Ελλαδικό χώρο.</h2>
	       
	       <!-- The POST method is the method the browser uses to talk to the server when asking for a response 
	       that takes into account the data provided in the body of the HTTP request.-->
	       
	       <form method="post" action="search_results_1.jsp">
	       
		   <table>
			    <tr>
				  <td><h2>Παρακαλώ εισάγετε ασθένεια:</h2></td>
				  <td><input type="text" name="title" style="font-size:18px" /></td>
			    </tr>
			
			    <tr>
				  <td colspan=1><input type=submit name="submit1" value="Εμφάνιση αποτελεσμάτων σε πίνακα" style="font-size:18px"/></td>
				  <td colspan=1><input type=submit name="submit2" value="Εμφάνιση πόλεων" formaction="search_results_2.jsp" style="font-size:18px"/></td>
			    </tr>
		    </table>
	
	        </form>

	<%
			}else {
		
// Σύνδεση με τη βάση και αναζήτηση εγγραφών που ικανοποιούν τη συνθήκη σύμφωνα με την οποία η συγκεκριμένη ασθένεια - λέξη
// περιέχεται στον τίτλο της μελέτης

	    Connection connection = null;
	    Statement statement = null;
	    ResultSet rs = null;

	    String title = request.getParameter("title");
				
		connection = ConnectDB.getConnection();
	    statement = connection.createStatement();
	    
		rs = statement.executeQuery("Select studies.nct_id, city1 as city, studies.status, title, sponsor_collaborators, name, URL "+
                " from studies, location, cities "+ 
                " where studies.nct_id = location.nct_id and "+
                " location.city1 = cities.city and  "+
                " title like '%"+title+"%' order by nct_id ");  
		
		if (title == "") {
            title = "για όλες τις μελέτες";
      } else {
     	 title = "για " + title;
  }		        			
				                    
		%>
		
	<center>
	    <h1> Τα αποτελέσματα της αναζήτησης <%=title%> παρουσιάζονται στον ακόλουθο πίνακα:</h1>
	
	    <br/>
	    <br/>	

<!-- -----------------  Εμφάνιση πίνακα με τα στοιχεία της αναζήτησης  ---------------- -->	    	
	<table border="5">
	
		<tr>
			<th>ID</th>
			<th>ΠΟΛΗ</th>
			<th>ΤΙΤΛΟΣ</th>
			<th>ΙΝΣΤΙΤΟΥΤΟ</th>
			<th>STATUS ΜΕΛΕΤΗΣ</th>		
		</tr>
		
		<%
		while (rs.next()) {
		%>

		<tr>
		    <!-- Κωδικός κλινικής μελέτης και link αντίστοιχης σελίδας του https://clinicaltrials.gov/ για επιπλέον πληροφορίες -->
		    <td><a href= "<%=rs.getString("URL")%>" style="color:blue"><%=rs.getString("nct_id")%></a></td> 
		    <td><%=rs.getString("city")%></td>    <!-- Πόλη στην οποία έλαβε χώρα η κλινική μελέτη -->
		    <td><%=rs.getString("title")%></td>   <!-- Τίτλος της κλινικής μελέτης -->
			<td><%=rs.getString("name")%></td>    <!-- Ινστιτούτα, Νοσοκομεία, Ιδρύματα κ.λπ στα οποία έλαβαν χώρα η κλινική μελέτη -->
			<td><%=rs.getString("status")%></td>  <!-- Στάδιο της κλινικής μελέτης -->
		</tr>
		<%
		}
		rs.close();
		
		}
	    %>
	    
	</table>
	
	</center>

</body>
