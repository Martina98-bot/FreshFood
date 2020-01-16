<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*,control.*,model.*"%>
<%
	Collection<?> listaOrdini = (Collection<?>) request.getAttribute("listaOrdini");	
%>
<!DOCTYPE html>
<html>
<head>

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


<title>FreshFood</title>
<!-- CSS PERSONALI -->
<link href="css/NewFile.css" rel="stylesheet">
<link href="css/footer.css" rel="stylesheet">

<!-- Bootstrap core JavaScript -->
<script src="vendor/jquery/jquery.min.js"></script>
<script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

<!-- Bootstrap core CSS -->
<link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">


</head>

<body>

	<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
	<script src="js/npm.js"></script>
	<script src="js/bootstrap.js"></script>
	<script src="js/bootstrap.min.js"></script>
	<script type="text/javascript" src="js/Bottone_torna_su.js"></script>

	<!-- HEADER -->
	<%@ include file="fragment/navbar.jsp"%>

	<h2>I Miei Ordini</h2>
	<hr class="line">

	<%	int i=0;
			if (listaOrdini != null && listaOrdini.size() != 0) {
				Iterator<?> it =listaOrdini.iterator();
				while (it.hasNext()) {
						Ordine ordine = (Ordine) it.next();		
		%>

	<table id="carrello"
		class="table table-striped table-hover table-bordered">
		<tr>
			<th>Codice Ordine: <%= ordine.getCodiceOrdine()	%></th>
			<th>Data Acquisto: <%= ordine.getDataOrdine()	%></th>
			<th>Quantità</th>
			<th>Dettagli ordine<a
				href="ordine?action=dettagli&idOrdine=<%= ordine.getCodiceOrdine() %>"><img
					height="30px" width="30px"
					src="http://www.tilghmansautoparts.com/wp-content/uploads/2014/10/shipping.png"></a>
		</tr>

		<% for(int j=0 ; j < ordine.getProdottiOrdine().size() ; j++){	%>
		<tr>
			<td><%= ordine.getProdottiOrdine().get(j).getNome()		%></td>
			<td><%= ordine.getProdottiOrdine().get(j).getPrezzo()	%></td>
			<td><%= ordine.getProdottiOrdine().get(j).getQuantità()	%></td>
			<td><img height="100px" width="100px"
				src=<%= ordine.getProdottiOrdine().get(j).getImg()%>></td>
		</tr>
		<% } %>


	</table>

	<h3>
		Totale Ordine:
		<%= ordine.getSpesaTotale() 	%></h3>
	<hr class="line">
	<br>
	<!-- scrip per far comparire il tooltip -->
	<script>
							$(document).ready(function(){
   							$('[data-toggle="tooltip"]').tooltip();   
						   });
						</script>

	<%}} else { %>
	<div class="col-md-3 col-sm-6">Nessun ordine effettuato</div>
	<% } %>
</body>

<!-- Footer -->

<%@ include file="fragment/footer.jsp"%>


</html>