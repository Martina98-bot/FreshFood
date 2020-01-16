<%@ page contentType="text/html; charset=UTF-8" import=" model.Ordine"%>
<%
Ordine mioOrdine;
synchronized (session) {
		mioOrdine = (Ordine) request.getAttribute("ordine");
	 }

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

<!-- Bootstrap core CSS -->
<link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

<!-- Custom styles for this template -->
<link href="css/modern-business.css" rel="stylesheet">
<link href="css/info-sped.css" rel="stylesheet">

<link href="css/NewFile.css" rel="stylesheet">
<link href="css/footer.css" rel="stylesheet">
<!-- Bootstrap core JavaScript -->
<script src="vendor/jquery/jquery.min.js"></script>
<script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
<body>
	<%@ include file="fragment/navbar.jsp"%>

	<tbody>
		<tr>
			<td>Codice Ordine: <%=mioOrdine.getCodiceOrdine()  %>
			</td>
		</tr>

		<tr>
			<td>Spesa totale: <%=mioOrdine.getSpesaTotale() %></td>
		</tr>
		<tr>
			<td>Data Ordine: <%=mioOrdine.getDataOrdine() %></td>
		</tr>
		<tr>
			<td>Dati Spedizione:<br> <%=mioOrdine.getDatiSpedizione() %></td>
		</tr>
		<tr>
			<td>Dati Pagamento:<br> <%=mioOrdine.getDatiPagamento() %></td>
		</tr>
	</tbody>
	</table>

	<%@ include file="fragment/footer.jsp"%>
</body>

</html>