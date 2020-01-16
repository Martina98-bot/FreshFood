<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	import="java.util.*, model.Cart, control.*, model.*"%>
<%
	ArrayList<ProductBean> products = (ArrayList<ProductBean>) request.getAttribute("products");
 
Cart cart;
	synchronized(session) { 
		cart = (Cart) session.getAttribute("CARRELLO");
	}
	
%>
<!DOCTYPE html>
<html lang="ita">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">

<link rel='stylesheet'
	href='https://use.fontawesome.com/releases/v5.7.0/css/all.css'
	integrity='sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ'
	crossorigin='anonymous'>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

<title>Verdura</title>

<link href="css/bottone.css" rel="stylesheet">
<link href="css/NewFile.css" rel="stylesheet">
<link href="css/footer.css" rel="stylesheet">

<!-- Bootstrap core JavaScript -->
<script src="vendor/jquery/jquery.min.js"></script>
<script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

<!-- Bootstrap core CSS -->
<link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">


</head>
<body>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<h3>La nostra verdura: pronta per essere spedita direttamente a
		casa tua</h3>
	<%@ include file="fragment/navbar.jsp"%>

	<!-- CERCA -->

	<div class="div-cerca">
		<div class="row">
			<div class="col-md-4 col-md-offset-3">
				<form action="Cerca" method="post" class="search-form">
					<div class="form-group has-feedback">
						<label for="search" class="sr-only">Cerca</label> <input
							type="text" class="form-control" name="cerca" id="search"
							placeholder="Digita le parole chiave e poi premi Invio">
					</div>
				</form>
			</div>
		</div>
	</div>

	<div class="row">
		<%	
			if(products !=null){
				
			
			
        if (products.size()!= 0) {	
			int i = 0;
			
			while (i  < products.size()){
					
		%>

		<div class="col-lg-4 col-sm-6 portfolio-item">
			<div class="card h-100">
				<div class="container">
					<a href="product?action=verdura&tipo=verdura"> <img
						class="card-img-top" src=<%=products.get(i).getImg()%>
						height="250" width="100" alt=""></a>
					<div class="card-body">
						<h4 class="card-title"><%=products.get(i).getNome()%></h4>
						<div class="overlay">
							<div class="text"><%=products.get(i).getDescrizione()%></div>
						</div>
					</div>

				</div>

				<hr class="line-qt">
				<table>

					<th><h5>Quantità :</h5></th>
					<% if(products.get(i).getQuantità()>0){%>

					<tr>
						<td class="td-1"><%=products.get(i).getQuantità()%></td>


						<% } %>
						<% if(products.get(i).getQuantità()==0) {%>

						<td class="td-0">N D</td>
					</tr>
					<% } %>
				</table>
				<div class="row">
					<div class="col-md-6 col-sm-6">
						<th><h5>Prezzo :</h5></th>
						<%if(products.get(i).getQuantità()>0) { %>
						<i class='fas fa-euro-sign' style='font-size: 24px'></i><%=products.get(i).getPrezzo()%>
						<% } %>

					</div>
					<div class="col-md-6 col-sm-6">
						<% if(products.get(i).getQuantità()>0) {%>
						<a href="product?action=addC&id=<%=products.get(i).getCode()%>">

							<button class="fa fa-shopping-basket" style="font-size: 36px;"
								data-toggle="tooltip" title="Aggiungi al carrello"></button>
						</a>


						<% } else {%>

						<a class="popup-link" href="#" data-popup-target="#example-popup">
							<button id="NonDisponibile" data-toggle="tooltip"
								title="Prodotto temporaneamente non disponibile"></button>
						</a>

						<%@ include file="fragment/popup-carrello-nondisp.jsp"%>

						<% }
		      				%>

					</div>
					<!-- scrip per far comparire il tooltip -->
					<script>
							$(document).ready(function(){
   							$('[data-toggle="tooltip"]').tooltip();   
						   });
						</script>

				</div>
			</div>
		</div>


		<% i = i+1; } /*end while*/
			
        }
			} /*end if null*/
	%>
	</div>
	<!-- /.row -->
	<!-- Footer -->

	<%@ include file="fragment/footer.jsp"%>

</body>
</html>