
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	import="java.util.*, model.Cart , model.ProductBean "%>

<%

	Collection<?> products = (Collection<?>) request.getAttribute("products");
	ProductBean product = (ProductBean) request.getAttribute("product");
	
	/*Sessione*/
	Cart cart;
	synchronized(session) { 
		cart = (Cart) session.getAttribute("CARRELLO");
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
<title>Carrello</title>


<link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
<link href="css/carrello.css" rel="stylesheet">
<link rel='stylesheet'
	href='https://use.fontawesome.com/releases/v5.7.0/css/all.css'
	integrity='sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ'
	crossorigin='anonymous'>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link href="css/footer.css" rel="stylesheet">
<meta charset="ISO-8859-1">
<title>CARRELLO</title>
</head>
<body>

	<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
	<script src="js/npm.js"></script>
	<script src="js/bootstrap.js"></script>
	<script src="js/bootstrap.min.js"></script>
	<script type="text/javascript" src="js/Bottone_torna_su.js"></script>

	<!-- scrip per far comparire il tooltip -->
	<script>
			$(document).ready(function(){
			   $('[data-toggle="tooltip"]').tooltip();   
			});
		</script>

	<!-- HEADER -->
	<%@ include file="fragment/navbar.jsp"%>
	<br>
	<br>
	<br>
	<br>

	<div class="container">
		<% 
					if(cart == null){
				 %>
		<h2>Carrello</h2>
		<hr class="line">
		<h4>Il carrello è ancora vuoto</h4>

		<% } %>

		<% if(cart != null){
						 if(cart.getNumeroOggettiCarrello()==0) { %>
		<h2>Carrello</h2>
		<hr class="line">
		<div class="alert alert-danger">
			<a href="index.jsp" class="btn btn-xs btn-primary pull-right">Continua
				lo shopping</a> <strong>Info:</strong> Il Carrello è ancora vuoto

			<% } /*end if ==0*/
					
						if(cart.getNumeroOggettiCarrello()!=0) { %>

			<h2>
				<span class="fa fa-shopping-basket"></span> Carrello
			</h2>
			<hr class="line">

			<table id="carrello" class="able table-hover table-condensed">
				<!--  ho apportato una modifica al css table, ho dato un id=carrello e messo margini destro e sinistro a 0 -->
				<thead>
					<tr>
						<th style="width: 50%">Prodotto</th>
						<th style="width: 15%">Prezzo</th>
						<th style="width: 15%">Quantità</th>
						<th style="width: 30%">Rimuovi dal Carrello</th>
					</tr>
				</thead>
				<tbody>
					<% List<ProductBean> prodcart = cart.getProducts(); 	
					   for(ProductBean beancart: prodcart) {
			
					%>
					<tr>
						<td data-th="Product">
							<div class="row">
								<div class="card-img-top">
									<img src=<%=beancart.getImg()%>>
								</div>
								<div class="col-sm-10">
									<h4 class="nomargin"><%=beancart.getNome()%></h4>
								</div>
							</div>
						</td>

						<td class="text-center" data-th="Price"><%=beancart.getPrezzo()%></td>

						<td class="text-center" data-th="Quantity"><%=beancart.getQuantità()%></td>

						<td class="centro" class="actions" data-th=""><a id="remove"
							href="product?action=deleteC&id=<%=beancart.getCode()%>"
							data-toggle="tooltip" title="Elimina dal  carrello"><img
								src="img/remove.gif" alt="remove" /></a></td>
					</tr>
				</tbody>

				<% } /*end for */%>
				<tfoot>
					<tr class="visible-xs">
						<td class="text-center"><strong> Totale: <%= cart.getTotale() %></strong></td>
					</tr>

					<%	
			         	/*Se non ho efettuato l'accessso non posso efettuare il check out*/
			         	Boolean adminRoles = (Boolean) session.getAttribute("adminRoles");
			         	Boolean clientRoles = (Boolean) session.getAttribute("clientRoles");
			         	if(((adminRoles == null) || (!adminRoles.booleanValue())) && ((clientRoles == null) || (!clientRoles.booleanValue())) ){
			         %>
					<table>
						<tr>
							<td><h4>
									<span class="glyphicon glyphicon-exclamation-sign"></span> Non
									hai effettuato nessun accesso...per comprare hai bisogno di un
									profilo
								</h4></td>
						</tr>
						<tr>
							<td><a href="login.jsp" class="btn btn-warning">Accedi</a></td>
							<td><a href="Registrazione.jsp"
								class="btn btn-success btn-block">Registrati </a></td>
						</tr>
					</table>


					<%
			         		} else {	
						%>
					<tr>
						<td><a href="index.jsp" class="btn btn-warning"> Continua
								lo Shopping</a></td>
						<td colspan="2" class="hidden-xs"></td>
						<td class="hidden-xs text-center"><strong>Totale: <%= cart.getTotale() %></strong></td>
						<td><a href="Checkout.jsp" class="btn btn-success btn-block">Checkout
						</a></td>
					</tr>
				</tfoot>
			</table>

			<% } /*end else*/ %>
			<% } /*end if !=0 */%>
			<% } /*end if !=null*/%>
		</div>
	</div>
	<footer>
		<%@ include file="fragment/footer.jsp"%>
	</footer>
</body>


</html>