<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*,control.*,model.*"%>

<%
	Collection<?> products = (Collection<?>) request.getAttribute("products");
	ProductBean product = (ProductBean) request.getAttribute("product");
	Utente utente = new Utente();
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
<!-- CSS PERSONALI -->
<link href="css/NewFile.css" rel="stylesheet">
<link href="css/footer.css" rel="stylesheet">
<link href="css/testo.css" rel="stylesheet">
<link href="css/bottone.css" rel="stylesheet">
<link href="css/cerca.css" rel="stylesheet">
<link href="css/navbar.css" rel="stylesheet">

<title>FreshFood</title>

<!-- Bootstrap core CSS -->
<link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

<!-- Custom styles for this template -->
<link href="css/modern-business.css" rel="stylesheet">


<!-- Bootstrap core JavaScript -->
<script src="vendor/jquery/jquery.min.js"></script>
<script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

<script>
	function openSearch() {
		document.getElementById("myOverlay").style.display = "block";
	}

	function closeSearch() {
		document.getElementById("myOverlay").style.display = "none";
	}
</script>


</head>

<body>
	<header>
		<!-- Navigation -->
		<%@ include file="fragment/navbar.jsp"%>

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
					style="background-image: url('https://www.mammapoppins.it/wp-content/uploads/2018/05/frutta-e-verdura-ai-bambini.jpg')">

					<div class="carousel-caption d-none d-md-block">
						<h2>BENESSERE</h2>
						<h3 style="color: #000000">
							<strong>Come azienda agricola biologica manteniamo una
								politica eco-sostenibile, producendo e vendendo cibi sani.</strong>
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
				<div class="carousel-item" style="background-image: url('')">

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
	<!-- CERCA -->



	<a href="product?action=lista">List</a>
	<h2>La nostra vetrina</h2>
	<div class="row">


		<%
			ArrayList<ProductBean> array = new ArrayList<ProductBean>();
			ArrayList<ProductBean> arrayVetrina = new ArrayList<ProductBean>();
			Random random = new Random();

			if (products != null && products.size() != 0) {
				Iterator<?> it = products.iterator();
				while (it.hasNext())
					array.add((ProductBean) it.next());

				while (arrayVetrina.size() < 3) {
					ProductBean b = array.get(random.nextInt(array.size()));

					boolean trovato = false;
					for (int j = 0; j < arrayVetrina.size() && !trovato; j++)
						if (arrayVetrina.get(j).getCode() == b.getCode())
							trovato = true;
					if (!trovato)
						arrayVetrina.add(b);
				}

				Iterator<?> it2 = arrayVetrina.iterator();
				while (it2.hasNext()) {
					ProductBean bean = (ProductBean) it2.next();
		%>
		<div class="col-lg-4 col-sm-6 portfolio-item">
			<div class="card h-100">

				<div class="container">
					<a href="#"><img class="card-img-top" src=<%=bean.getImg()%>
						height="250" width="100" alt=""></a>
					<div class="card-body">
						<h4 class="card-title"><%=bean.getNome()%></h4>
						<div class="overlay">
							<div class="text"><%=bean.getDescrizione()%></div>
						</div>
					</div>

					<h5>
						<i class='fas fa-euro-sign' style='font-size: 24px'></i><%=bean.getPrezzo()%></h5>


				</div>


			</div>

		</div>
		<%
			}
			}
		%>

	</div>
	<!-- /.row -->



	<!-- Footer -->

	<%@ include file="fragment/footer.jsp"%>


</body>

</html>
