<%@ page contentType="text/html; charset=UTF-8"
	import="java.util.*,model.ProductBean, model.Cart"%>

<%  
	Cart cart;
	synchronized(session) { 
		cart = (Cart) session.getAttribute("CARRELLO");
		
		if(cart == null || cart.getNumeroOggettiCarrello() == 0){
			response.sendRedirect("./index.jsp");
		    return;
		}
	}
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">

<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
<title>Fresh Food</title>

<!-- Bootstrap -->
<link rel='stylesheet'
	href='https://use.fontawesome.com/releases/v5.7.0/css/all.css'
	integrity='sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ'
	crossorigin='anonymous'>

<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link href="css/bootstrap.min.css" rel="stylesheet">

<link href="css/modern-business.css" rel="stylesheet">
<link href="css/info-sped.css" rel="stylesheet">
<link href="css/NewFile.css" rel="stylesheet">
<link href="css/footer.css" rel="stylesheet">
</head>
<body>
	<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
	<script src="js/bootstrap.js"></script>
	<script src="js/bootstrap.min.js"></script>
	<script src="js/jquery.validate.js"></script>

	<!-- SCRIPT PER I CONTROLLI SULL'INPUT -->
	<script>
		jQuery.extend(jQuery.validator.messages, {
			required: "Questo campo è richiesto",
			remote: "C'è un errore in questo campo, controllare.",
			name: "Inserire un valore adatto per il nome\cognome.",
			email: "Inserire un indirizzo email valido.",
			url: "Inserire un indirizzo URL valido.",
			date: "Inserire una data valida.",
			dateISO: "Digitare una data valida (ISO).",
			number: "Digitare un numero valido.",
			digits: "Digitare solo caratteri numerici.",
			creditcard: "Digitare un numero valido di carta di credito.",
			equalTo: "I campi password non corrispondono, controllare.",
			accept: "Digitare un valore con una valida estensione.",
			maxlength: $.validator.format("Digitare al massimo {0} caratteri."),
			minlength: $.validator.format("Digitare almeno {0} caratteri."),
			rangelength: $.validator.format("Inserire un valore compreso tra gli {0} ed i {1} caratteri."),
			range: $.validator.format("Digitare un valore compreso tra {0} e {1}."),
			max: $.validator.format("Inserire un valore minore o uguale di {0}."),
			min: $.validator.format("Inserire un valore maggiore o uguale di {0}.")
		});
		</script>

	<script>
		
		$(document).ready(function(){
			$('#finalizza_ordine').validate({
			rules: {
		      	indirizzo: 	"required",
		      	provincia: 	"required",
		      	citta: 		"required",
		      	nome: 		"required",
		      	cognome: 	"required",
		      	email: {
		 	        required: 	true,
		 	        email: 		true,
		 	    },
		      	cap: {
		      		required: 	true,
		      		digits: 	true,
					minlength: 	5,
					maxlength: 	5,
		      	},
		      	telefono: {
		      		digits: 	true,
		      		required: 	true,
		      		minlength: 	10,
					maxlength: 	10,
		      	},
		      	ccv_carta:{
		      		digits: 	true,
		      		required: 	true,
		      		range: [100, 999],
		      	},	
				numero_carta: {
					required:	true,
					creditcard: true,
				},
				mese_scadenza_carta: "required",
				anno_scadenza_carta: "required",
		      	
		    },
				highlight: function(element) {
					$(element).closest('.control-group').removeClass('success').addClass('error');
				},
				success: function(element) {
					element
					.text('OK!').addClass('valid')
					.closest('.control-group').removeClass('error').addClass('success');
				}
		  });
		
		}); // end document.ready
		</script>
	<script>
			addEventListener('load', prettyPrint, false);
				$(document).ready(function(){
				$('pre').addClass('prettyprint linenums');
			});
		</script>





	<div class="container wrapper">
		<div class="row cart-head">
			<div class="container">
				<div class="row">
					<p></p>
				</div>

				<div class="row">
					<p></p>
				</div>
			</div>
		</div>
		<div class="row cart-body">

			<form class="form-horizontal" id="finalizza_ordine" action="ordine">

				<div
					class="col-lg-6 col-md-6 col-sm-6 col-xs-12 col-md-push-6 col-sm-push-6">
					<!--RIEPILOGO ORDINE-->
					<div class="panel panel-info">
						<div class="panel-heading">
							<i class='fas fa-list' style='font-size: 24px'></i> Riepilogo
							Ordine
						</div>
						<div class="panel-body">


							<%
							//elenca tutti i prodotti nel carrello
							List<ProductBean> list = cart.getProducts();
							Iterator<?> it = list.iterator();
							while(it.hasNext()){
								ProductBean bean = (ProductBean) it.next();
						
						%>

							<div class="form-group">
								<div class="col-sm-3 col-xs-3">
									<img class="img-responsive" src=<%=bean.getImg() %> />
								</div>
								<div class="col-sm-6 col-xs-6">
									<div class="col-xs-12">
										Prodotto:
										<%=bean.getNome() %>
									</div>
									<div class="col-xs-12">
										<small>Quantità: <span><b><%=bean.getQuantità() %></b></span></small>
									</div>
								</div>
								<div class="col-sm-3 col-xs-3 text-right">
									<h6>
										<span>€ </span><%=bean.getPrezzo() %></h6>
								</div>
							</div>
							<div class="form-group">
								<hr />
							</div>

							<% }	//end while %>

							<div class="form-group">
								<div class="col-xs-12">
									<strong>Totale Parziale</strong>
									<div class="pull-right">
										<span>€ </span><span><%= cart.getTotale() %></span>
									</div>
								</div>
								<div class="col-xs-12">
									<small>Costi di spedizione:</small>
									<div class="pull-right">
										<span>€ 10.00</span>
									</div>
								</div>
							</div>
							<div class="form-group">
								<hr />
							</div>
							<div class="form-group">
								<div class="col-xs-12">
									<strong>Totale Ordine</strong>
									<div class="pull-right">
										<span>€ </span><span><%= cart.getTotale()+10 %></span>
									</div>
								</div>
							</div>
						</div>
					</div>
					<!--FINE RIEPILOGO ORDINE-->

				</div>
				<div
					class="col-lg-6 col-md-6 col-sm-6 col-xs-12 col-md-pull-6 col-sm-pull-6">
					<!-- METODI DI SPEDIZIONE -->
					<div class="panel panel-info">
						<div class="panel-heading">
							<i class='fas fa-info-circle' style='font-size: 24px'></i>Informazioni
							per la Spedizione
						</div>
						<div class="panel-body">

							<div class="form-group">
								<div class="col-md-12">
									<h4>Indirizzo di Spedizione</h4>
								</div>
							</div>

							<div class="form-group">
								<div class="col-md-6 col-xs-12">
									<strong>Nome:</strong> <input type="text" name="nome"
										class="form-control" value="" />
								</div>
								<div class="span1"></div>
								<div class="col-md-6 col-xs-12">
									<strong>Cognome:</strong> <input type="text" name="cognome"
										class="form-control" value="" />
								</div>
							</div>
							<div class="form-group">
								<div class="col-md-12">
									<strong>Indirizzo:</strong>
								</div>
								<div class="col-md-12">
									<input type="text" name="indirizzo" class="form-control"
										value="" />
								</div>
							</div>
							<div class="form-group">
								<div class="col-md-12">
									<strong>Città:</strong>
								</div>
								<div class="col-md-12">
									<input type="text" name="citta" class="form-control" value="" />
								</div>
							</div>
							<div class="form-group">
								<div class="col-md-12">
									<strong>Provincia:</strong>
								</div>
								<div class="col-md-12">
									<input type="text" name="provincia" class="form-control"
										value="" />
								</div>
							</div>
							<div class="form-group">
								<div class="col-md-12">
									<strong>Codice Postale (CAP):</strong>
								</div>
								<div class="col-md-12">
									<input type="text" name="cap" class="form-control" value="" />
								</div>
							</div>
							<div class="form-group">
								<div class="col-md-12">
									<strong>Numero di Telefono:</strong>
								</div>
								<div class="col-md-12">
									<input type="text" name="telefono" class="form-control"
										value="" />
								</div>
							</div>
							<div class="form-group">
								<div class="col-md-12">
									<strong>Indirizzo Email:</strong>
								</div>
								<div class="col-md-12">
									<input type="text" name="email" class="form-control" value="" />
								</div>
							</div>
						</div>
					</div>
					<!--SHIPPING METHOD END-->
					<!--CREDIT CART PAYMENT-->
					<div class="panel panel-info">
						<div class="panel-heading">
							<span><i class='fas fa-credit-card'
								style='font-size: 24px'></i> Pagamento Sicuro
						</div>
						<div class="panel-body">
							<div class="form-group">
								<div class="col-md-12">
									<strong>Tipo di Carta:</strong>
								</div>
								<div class="col-md-12">
									<select id="CreditCardType" name="tipo_carta"
										class="form-control">
										<option value="5">Visa</option>
										<option value="6">MasterCard</option>
										<option value="7">American Express</option>
										<option value="8">Discover</option>
									</select>
								</div>
							</div>
							<div class="form-group">
								<div class="col-md-12">
									<strong>Numero della Carta di Credito:</strong>
								</div>
								<div class="col-md-12">
									<input type="text" class="form-control" name="numero_carta"
										value="" />
								</div>
							</div>
							<div class="form-group">
								<div class="col-md-12">
									<strong>CVV:</strong>
								</div>
								<div class="col-md-12">
									<input type="text" class="form-control" name="ccv_carta"
										value="" />
								</div>
							</div>
							<div class="form-group">
								<div class="col-md-12">
									<strong>Data di Scadenza</strong>
								</div>
								<div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
									<select class="form-control" name="mese_scadenza_carta">
										<option value="">Mese</option>
										<option value="01">01</option>
										<option value="02">02</option>
										<option value="03">03</option>
										<option value="04">04</option>
										<option value="05">05</option>
										<option value="06">06</option>
										<option value="07">07</option>
										<option value="08">08</option>
										<option value="09">09</option>
										<option value="10">10</option>
										<option value="11">11</option>
										<option value="12">12</option>
									</select>
								</div>
								<div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
									<select class="form-control" name="anno_scadenza_carta">
										<option value="">Anno</option>
										<option value="2020">2020</option>
										<option value="2021">2021</option>
										<option value="2022">2022</option>
										<option value="2023">2023</option>
										<option value="2024">2024</option>
										<option value="2025">2025</option>
										<option value="2026">2026</option>
										<option value="2027">2027</option>
										<option value="2028">2028</option>
									</select>
								</div>
							</div>
							<div class="form-group">
								<div class="col-md-12">
									<span></span>
								</div>
								<div class="col-md-12">
									<ul class="cards">
										<li class="visa hand">Visa</li>
										<li class="mastercard hand">MasterCard</li>
										<li class="amex hand">Amex</li>
									</ul>
									<div class="clearfix"></div>
								</div>
							</div>
							<div class="form-actions">
								<button type="submit" name="action" value="piazzaOrdine"
									class="btn btn-success btn-large">Piazza Ordine</button>
								<button type="reset" class="btn">Annulla</button>
								<br> <br> <br> <br> <br>

								<div class="col-sm-offset-2 col-sm-10"></div>
								<div class="col-sm-offset-2 col-sm-10"></div>
							</div>

						</div>
					</div>
					<!--CREDIT CART PAYMENT END-->
				</div>

			</form>
		</div>

	</div>
</body>

<!-- Footer -->



</html>