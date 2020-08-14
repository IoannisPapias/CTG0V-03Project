// first load Google Maps JavaScript API & jQuery CDN  from Google

// Εμφάνιση χάρτη Ελλάδας  
// creates a new map inside the <div> element with id="map", using the parameters that are passed 

	    var map = new google.maps.Map(document.getElementById('map'), {
	        // Map Options 
	    	zoom: 7,
	        center: new google.maps.LatLng(37.98381, 23.727539),
	        mapTypeId: google.maps.MapTypeId.ROADMAP
	    });

	    var infowindow = new google.maps.InfoWindow();

	    var marker;
	    
	  
// Διάβασμα συντεταγμένων και πλήθους μελετών από Json αρχείο 
// AJAX is the art of exchanging data with a server, and updating parts of a web page - without reloading the whole page
// request text, HTML, XML, or JSON from a remote server
// GET - Requests data from a specified resource
// AJAX - jQuery
	    $.ajax({
	        type: "Get",
	        url: "marker.json",
	        dataType: "json",
	        success: function(data) {
	        	
// Function key-value pairs από json για εμφάνιση markers στις πόλεις που πραγματοποιήθηκαν μελέτες  
// we need to be reading properties from the second argument
	        	$.each(data, function (key, val) {
                   	marker = new google.maps.Marker({
	       	        position: new google.maps.LatLng(val.lat, val.lng),
	       	        map: map
	       	      });
// Open an InfoWindow When Clicking on The Marker
// Εμφάνιση infowindow με την αναγραφή του πλήθους των μελετών             
	               google.maps.event.addListener(marker, 'click', (function(marker) {
	       	         return function() {
	       	            infowindow.setContent(val.num);
	       	            infowindow.open(map, marker);
	       	        }
	       	      })(marker));
	               
	              });
	       
	        },
	        error: function(){
	            alert("json not found");
	        }
	    });
	        

