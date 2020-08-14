<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="java.sql.*"%>

<!-- ΕΜΦΑΝΙΣΗ ΤΩΝ ΠΟΛΕΩΝ ΣΤΙΣ ΟΠΟΙΕΣ ΕΛΑΒΑΝ ΧΩΡΑ ΚΛΙΝΙΚΕΣ ΜΕΛΕΤΕΣ ΠΑΝΩ ΣΕ ΧΑΡΤΗ ΚΑΙ ΤΟΥ ΠΛΗΘΟΥΣ ΜΕΛΕΤΩΝ ΩΣ ΠΛΗΡΟΦΟΡΙΑ -->

<html>


 <head>
	       <title lang='gr'>Project CTG0V-03</title>
           <link rel='icon' href='prometheus.png' type='image/png'/>
           <meta name='viewport' content='width=device-width, initial-scale=1.0'></meta>
           <link rel='stylesheet' href='common.css'></link>
 </head>
       
 <body>
           
          <center><a href="home.html"><img src="prometheus.png" alt="CTG0V-03" style="width:200px;height:200px;"></a>
           
           <div class="navbar" id='navbar'>
               <a href="home.html">Αρχική Σελίδα</a>
               <a href="about.html">Σχετικά Με</a>
           </div>
                  
        	<h1> ΠΟΛΕΙΣ ΣΤΙΣ ΟΠΟΙΕΣ ΕΛΑΒΑΝ ΧΩΡΑ ΚΛΙΝΙΚΕΣ ΜΕΛΕΤΕΣ </h1>
 
<!-- The Google Maps JavaScript API is loaded --> 
<script src="http://maps.google.com/maps/api/js?sensor=false" type="text/javascript"></script> 

<!-- jQuery CDN (Content Delivery Network) from Google -->
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>  
      	  
<!-- Εμφάνιση χάρτη στη σελίδα και ορισμός μεγέθους χάρτη  -->        	 
<div id="map" style="width: 1000px; height: 1000px;"></div>
   
  
 <script type="text/javascript" src="map.js"></script> 
	              
      
</center>

</body>

















