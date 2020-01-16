<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="model.ProductBean , model.Cart"%>

<%
	Collection<?> products = (Collection<?>) session.getAttribute("products");
	ProductBean product = (ProductBean) request.getAttribute("product");
	Cart cart;
	synchronized (session) {
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


<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
<title>Pagina di ricerca</title>


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

	<script src="vendor/jquery/jquery.min.js"></script>
	<script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>




	<!-- HEADER -->

	<%@ include file="fragment/navbar.jsp"%>


	<br>
	<br>


	<div class="container">
		<h2>Risultati</h2>
		<hr class="line">

		<%
			int i = 0;

			if (products != null && products.size() != 0) {
				Iterator<?> it = products.iterator();
				while (it.hasNext()) {
					ProductBean bean = (ProductBean) it.next();
		%>

		<div class="col-md-3 col-sm-6">
			<div class="thumbnail">
				<a<%=bean.getCode()%>"> <img src=<%=bean.getImg()%>
					alt="Immagine non disponibile">
					<h4><%=bean.getNome()%></h4>
					<p><%=bean.getDescrizione()%></p>
				</a>
				<hr class="line-qt">
				<table>
					<tr>
						<th>Quantità</th>
						<%
							if (bean.getQuantità() > 0) {
						%>

						<%
							}
						%>
					</tr>

					<%
						if (bean.getQuantità() > 0) {
					%>

					<tr>
						<td class="td-1"><%=bean.getQuantità()%></td>


						<%
							}
						%>
						<%
							if (bean.getQuantità() == 0) {
						%>

						<td class="td-0">N D</td>
					</tr>
					<%
						}
					%>
				</table>
				<div class="row">
					<div class="col-md-6 col-sm-6">
						<%
							if (bean.getQuantità() > 0) {
						%>
						<p class='fas fa-euro-sign' style='font-size: 24px'><%=bean.getPrezzo()%></p>
						<%
							}
						%>

					</div>
					<div class="col-md-6 col-sm-6">
						<%
							if (bean.getQuantità() > 0) {
						%>
						<a
							href="product?action=addC&id=<%=bean.getCode()%>&pagina=result-cerca">

							<button class="fa fa-shopping-basket" style="font-size: 36px;"
								data-toggle="tooltip" title="Aggiungi al carrello"></button>
						</a>


						<%
							} else {
						%>

						<a id="NonDisponibile" class="popup-link" href="#"
							data-popup-target="#example-popup">
							<button class="btn btn-warning right glyphicon glyphicon-time"
								data-toggle="tooltip"
								title="Prodotto temporaneamente non disponibile"></button>
						</a>

						<%@ include file="fragment/popup-carrello-nondisp.jsp"%>

						<%
							}
						%>

					</div>
					<!-- scrip per far comparire il tooltip -->
					<script>
						$(document).ready(function() {
							$('[data-toggle="tooltip"]').tooltip();
						});
					</script>

				</div>
			</div>
		</div>

		<%
			} /*end while*/
		%>
		<div class="container">
			<!-- questo div serve a mandare alla fine della pagina il numero delle pagine -->
		</div>
		<nav aria-label="Page navigation example"></nav>
		<%
			} else {
		%>
		<div class="col-md-3 col-sm-6">Nessun risultato trovato</div>
		<%
			}
		%>

	</div>
</body>

<!-- Footer -->

<%@ include file="fragment/footer.jsp"%>

</html>