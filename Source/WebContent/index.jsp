<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*,control.*,model.*"%>

<%
	Collection<?> products = (Collection<?>) request.getAttribute("products");
	ProductBean product = (ProductBean) request.getAttribute("product");
	Cart cart;
	synchronized (session) {
		cart = (Cart) session.getAttribute("CARRELLO");
	}
%>
<!DOCTYPE html>
<html>
<%@ page contentType="text/html; charset=UTF-8"
	import="java.util.*,control.*,model.*"%>


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
<link href="css/navbar.css" rel="stylesheet">
<link href="css/loading.css" rel="stylesheet">
<link href="css/NewFile.css" rel="stylesheet">
<link href="css/footer.css" rel="stylesheet">

<!-- JavaScript -->
<script src="vendor/jquery/jquery.min.js"></script>
<script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

<!--  CSS -->
<link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">


</head>

<body>
	<%@ include file="fragment/navbar.jsp"%>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<header>

		<div id="carouselExampleIndicators" class="carousel slide"
			data-ride="carousel">
			<ol class="carousel-indicators">
				<li data-target="#carouselExampleIndicators" data-slide-to="0"
					class="active"></li>
				<li data-target="#carouselExampleIndicators" data-slide-to="1"></li>
				<li data-target="#carouselExampleIndicators" data-slide-to="2"></li>
			</ol>
			<div class="carousel-inner" role="listbox">
				<!-- Slide One - Set the background image for this slide in the line below -->
				<div class="carousel-item active"
					style="background-image: url('https://i.pinimg.com/originals/29/19/61/291961883c08529b031c2db567fe1d4b.jpg')">

					<div class="carousel-caption d-none d-md-block">
						<h2>GUSTO</h2>
						<h3 style="color: #000000">
							<strong>Dal produttore al consumatore per assaporare la
								freschezza dei nostri prodotti.</strong>
						</h3>
					</div>
				</div>
				<!-- Slide Two - Set the background image for this slide in the line below -->
				<div class="carousel-item"
					style="background-image: url('http://www.centroclinicochimico.it/wp-content/uploads/2017/05/fruttaeverdurabenessere.png')">

					<div class="carousel-caption d-none d-md-block">
						<h2>BENESSERE</h2>
						<h3 style="color: #000000">
							<strong>Come azienda agricola biologica manteniamo una
								politica eco-sostenibile, producendo e vendendo cibi sani che
								piacciono davvero a tutti!.</strong>
						</h3>
					</div>
				</div>
				<!-- Slide Three - Set the background image for this slide in the line below -->
				<div class="carousel-item"
					style="background-image: url('http://www.autosufficienza.it/wp-content/uploads/2018/05/shutterstock_649767436.jpg')">

					<div class="carousel-caption d-none d-md-block">
						<h2>QUALITA'</h2>
						<h3 style="color: #000000">
							<strong>Ci occupiamo personalmente dei nostri prodotti
								sin dall'origine per garantirvi altà qualità.</strong>
						</h3>
					</div>
				</div>


			</div>
			<a class="carousel-control-prev" href="#carouselExampleIndicators"
				role="button" data-slide="prev"> <span
				class="carousel-control-prev-icon" aria-hidden="true"></span> <span
				class="sr-only">Previous</span>
			</a> <a class="carousel-control-next" href="#carouselExampleIndicators"
				role="button" data-slide="next"> <span
				class="carousel-control-next-icon" aria-hidden="true"></span> <span
				class="sr-only">Next</span>
			</a>
		</div>
	</header>

	<a href="product?action=lista">List</a>
	<h2>La nostra vetrina</h2>
	</header>




</body>

</html>


<!-- /.container -->
<center>
	<div class="container">
		<div id="element">
			<div id="outerlayer11"></div>
			<div id="loader11"></div>
			<div id="antiLoader11"></div>
			<div id="content">
				<h3>Caricamento...</h3>
			</div>
		</div>
</center>


</div>
<!-- Footer -->

<%
	synchronized (session) {
		Utente utente = (Utente) session.getAttribute("utente");
		if (utente != null) {
			UtenteModel model = new UtenteModel();
			OrdineModel model_ordine = new OrdineModel();
			model.Login(utente);
			cart = new Cart();
			model_ordine.caricaCarrelloDB(cart, utente.getUsername());
			session.setAttribute("CARRELLO", cart);
		}
	}
%>
<script type="text/javascript">
	function redirect() {
		location.href = "product?action=lista";
	}
	window.setTimeout("redirect()", 1000);
</script>


<%@ include file="fragment/footer.jsp"%>

</body>

</html>