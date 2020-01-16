<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*, model.Utente"%>

<%
	Collection<?> accounts = (Collection<?>) request.getAttribute("accounts");
	//Utente utente = (Utente) request.getAttribute("utente");
	
%>
<%
// Check user credentials


 Boolean adminRoles = (Boolean) session.getAttribute("adminRoles");
if ((adminRoles == null) || (!adminRoles.booleanValue()))
{	
    response.sendRedirect("./login.jsp");
    return;
}

%>
<!DOCTYPE html>
<html>
<meta name="viewport" content="width=device-width, initial-scale=1">

<link rel='stylesheet'
	href='https://use.fontawesome.com/releases/v5.7.0/css/all.css'
	integrity='sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ'
	crossorigin='anonymous'>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">


<link href="css/table.css" rel="stylesheet">


<link href="css/NewFile.css" rel="stylesheet">
<link href="css/footer.css" rel="stylesheet">

<!-- Bootstrap core JavaScript -->
<script src="vendor/jquery/jquery.min.js"></script>
<script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

<!-- Bootstrap core CSS -->
<link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

<meta charset="ISO-8859-1">
<title>Cancella-Utente</title>

<head>
<meta charset="ISO-8859-1">


<title>CANCELLA-UTENTE</title>
<style>
table, th, td {
	border: 1px solid black;
	border-collapse: collapse;
}

th, td {
	padding: 5px;
}
</style>

</head>
<body>
	<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
	<script src="js/npm.js"></script>
	<script src="js/bootstrap.js"></script>
	<script src="js/bootstrap.min.js"></script>


	<!-- Script per vedere i tipi di account presenti nel db -->
	<script> /*Ajax*/ 
			function loadXMLDoc() {
			  var xmlhttp = new XMLHttpRequest();
			  xmlhttp.onreadystatechange = function() {
			    if (this.readyState == 4 && this.status == 200) {
			      myFunction(this);
			    }
			  };
			  xmlhttp.open("GET", "adminFreshFood.xml", true);
			  xmlhttp.send();
			}
			function myFunction(xml) {
			  var i;
			  var xmlDoc = xml.responseXML;
			  var table="<tr><th>Username</th><th>Tipo di account</th></tr>";
			  var x = xmlDoc.getElementsByTagName("ADMIN");
			  for (i = 0; i <x.length; i++) { 
			    table += "<tr><td>" +
			    x[i].getElementsByTagName("USERNAME")[0].childNodes[0].nodeValue +
			    "</td><td>" +
			    x[i].getElementsByTagName("TYPE")[0].childNodes[0].nodeValue +
			    "</td></tr>";
			  }
			  document.getElementById("elimina").innerHTML = table;
			}
		</script>

	<!-- HEADER -->
	<%@ include file="fragment/navbar.jsp"%>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<h2>Utenti</h2>
	<hr class="line">

	<button class="show-user" type="button" onclick="loadXMLDoc()">Show
		account admin</button>


	<%	int i=0;
			if (accounts != null && accounts.size() != 0) {
				Iterator<?> it = accounts.iterator();
				while (it.hasNext()) {
						Utente user = (Utente) it.next();		%>
	<table id="elimina"
		class="table table-striped table-hover table-bordered">
		<tr>
			<th>Username</th>
			<th>Cancella</th>

		</tr>
		<tr>
			<td class="coloreCella"><%= user.getUsername()%></td>
			<td><a
				href="product?action=deleteUser&username=<%=user.getUsername()%>"
				data-toggle="tooltip" title="Elimina Utente"><img
					src="img/remove.gif" alt="remove" /></a> </a></td>
		</tr>

	</table>
	<!-- scrip per far comparire il tooltip -->
	<script>
							$(document).ready(function(){
   							$('[data-toggle="tooltip"]').tooltip();   
						   });
						</script>

	<%}} else { %>
	<div class="col-md-3 col-sm-6">Nessun utente dispoibile</div>
	<% } %>
	<br>
	<br>
	<br>
	<br>
	<br>
	<!-- Footer -->
	<%@ include file="fragment/footer.jsp"%>
</body>
</html>