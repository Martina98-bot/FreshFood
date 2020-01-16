<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	import="java.util.*, model.ProductBean, model.Cart"%>

<%
	Collection<?> products = (Collection<?>) request.getAttribute("products");
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



<title>Cancella-Prodotto</title>

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

	<%@ include file="fragment/navbar.jsp"%>
	<a href="product?action=Cancella-Prodotto">List</a>
	
	<!-- CERCA -->
	<div class="div-cerca" style="margin-top:150px;">
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
	
	<div class="container">
		<a href="product?action=Cancella-Prodotto">List</a> <br>
		<br>
		<br>
		<br>
		<br>
		<h2>Cancella prodotto</h2>

		<%	int i=0;
			if (products != null && products.size() != 0) {
				Iterator<?> it = products.iterator();
				while (it.hasNext()) {
						ProductBean bean = (ProductBean) it.next();		%>



		<div class="col-md-3 col-sm-6">
			<div class="thumbnail">
				<img src=<%=bean.getImg() %> alt="Immagine non disponibile">
				<h4><%=bean.getNome()%></h4>
				<p><%=bean.getDescrizione() %></p>
				<hr class="line-qt">
				<table>
					<tr>
						<th>Quantità</th>
						<% if(bean.getQuantità()>0) {%>

						<% } %>
					</tr>

					<% if(bean.getQuantità()==0) {%>

					<td class="td-0">N D</td>
					</tr>
					<% } %>
				</table>
				<div class="row">
					<div class="col-md-6 col-sm-6">
						<%if(bean.getQuantità()>0) { %>
						<p class="fas fa-euro-sign"><%= bean.getPrezzo()%></p>
						<% } %>

					</div>
					<div class="col-md-6 col-sm-6">
						<% if(bean.getQuantità()>0) {%>
						<a href="product?action=deleteProduct&id=<%= bean.getCode() %>"
							data-toggle="tooltip" title="Elimina Prodotto"><img
							src="img/remove.gif" alt="remove" /></a> </a>
						<% } else {%>
						<button class="far fa-clock' style='font-size:24px"
							data-toggle="tooltip"
							title="Prodotto temporaneamente non disponibile"></button>
						<a href="product?action=deleteProduct&id=<%= bean.getCode() %>"
							data-toggle="tooltip" title="Elimina Prodotto"><img
							src="img/remove.gif" alt="remove" /></a> </a>
						<% } %>

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

		<%}} else { %>
		<div class="col-md-3 col-sm-6">Nessun prodotto disponibile</div>
		<%
					}
			%>
		<a href="product?action=Cancella-Prodotto">List</a>

	</div>
	<%@ include file="fragment/footer.jsp"%>
</body>
</html>