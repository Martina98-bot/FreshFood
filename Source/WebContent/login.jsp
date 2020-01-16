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
<meta charset="ISO-8859-1">
<title>Login</title>

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


<link href="css/NewFile.css" rel="stylesheet">
<link href="css/footer.css" rel="stylesheet">

<link href="css/bottone.css" rel="stylesheet">


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

	<%@ include file="fragment/navbar.jsp"%>

	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<center>
		<h2>Bentornato nell'area di accesso di Health Color</h2>

		<h3>Digita il tuo Username e la tua password per accedere alla
			tua arae personale</h3>
	</center>

	<div class="container">
		<div class="row-fluid">
			<div class="span6 offset6">
				<div id="maincontent" class="span8">

					<form action="Login" id="accediregistrati" class="form-horizontal"
						method="POST">

						<div class="form-group">
							<label for="username" class="col-sm-2 control-label"><i
								class='fas fa-user' style='font-size: 24px'></i>Username</i></label>
							<div class="col-sm-10">
								<input type="text" class="form-control" name="username"
									id="UserName_" placeholder="Username"> <label
									class="error" id="errore"></label>
							</div>
						</div>
						<div class="form-group">
							<label for="password" class="col-sm-2 control-label"><i
								class='fas fa-key' style='font-size: 24px'></i>Password</i></label>
							<div class="col-sm-10">
								<input type="password" class="form-control" name="password"
									id="password" placeholder="Password">
							</div>
						</div>
						<div class="form-group">
							<div class="col-sm-offset-2 col-sm-10">
								<button type="submit" class="button button1">Accedi</button>
							</div>
						</div>
					</form>



				</div>
				<!-- .span -->
			</div>
			<!-- .row -->

		</div>
		<!-- .container -->
	</div>

	<%@ include file="fragment/footer.jsp"%>
</body>
</html>