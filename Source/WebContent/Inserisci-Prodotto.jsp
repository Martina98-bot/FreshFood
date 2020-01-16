<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*,control.*,model.*"%>
<%
	// Check user credentials
	
	 Boolean adminRoles = (Boolean) session.getAttribute("adminRoles");
	if ((adminRoles == null) || (!adminRoles.booleanValue()))
	{	
	    response.sendRedirect("./index.jsp");
	    return;
	}
	ProductModel model = new ProductModelDS();
	int code = model.getNewCode();
	
	synchronized (session){
		session.setAttribute("code",code);
	}
	
	
%>
<!DOCTYPE html>
<html lang="ita">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">

<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
<title>Aggiungi prodotto</title>

<!-- Bootstrap -->
<!-- Bootstrap core CSS -->
<link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

<!-- Custom styles for this template -->
<link href="css/modern-business.css" rel="stylesheet">

<link hfref="bottone.css" rel="stylesheet">
<link rel='stylesheet'
	href='https://use.fontawesome.com/releases/v5.7.0/css/all.css'
	integrity='sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ'
	crossorigin='anonymous'>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

<!-- Bootstrap core JavaScript -->
<script src="vendor/jquery/jquery.min.js"></script>
<script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>


<script>
		if(${composizione == 'true'}){
			  alert("Prodotto inserito correttamente");
		};
		if (${errore_composizione == 'true'}){
			  alert("Errore durante l'inserimento del prodotto");
		};
		</script>
</head>
<body>
	<%@ include file="fragment/navbar.jsp"%>
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
			name: "Inserire un valore adatto per il nome.",
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
		
		
		$(document).ready(function(){
			$('#accedieregistrati').validate({
			rules: {			  
			 	nome: {
		       		minlength: 	6,
		        	required: 	true,
		      	},
		      	prezzo: {
		      		required:	true,
		      	   	range: 		[1, 99999],
		      		number: 	true,
		      	},
		      	percorso: {
		      		required: 	true,
		      		url: 		true,
		      	},
		      	descrizione: {
		      		required: 	true,
		      		minlength: 	10,
		      	},
		      	misura: {
		      		required: 	true,
		      		minlength: 	5,
		      	},
				quantita: {
					required: 	true,
					range: 		[1, 999],
		      		digits: 	true,
				},
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


	<!-- HEADER -->

	<br>
	<br>
	<br>

	<h2>Bentornato, inserisci qui i nuovi prodotti.</h2>

	<h4>Inserisci un nuovo prodotto.</h4>


	<!-- FORM PER L'INSERIMENTO DEI DATI PER L'INSERIMENTO DI UN NUOVO PRODOTTO -->
	<form action="InsertProduct" id="accedieregistrati"
		class="form-horizontal">

		<div class="form-group">
			<label class="col-sm-2 control-label">Codice</label> <label
				class="col-sm-2 control-label"><%= code%></label>
		</div>


		<div class="form-group">
			<label for="nome" class="col-sm-2 control-label">Nome</label>
			<div class="col-sm-10">
				<input type="text" class="form-control" name="nome"
					placeholder="Nome Prodotto">
			</div>
		</div>

		<div class="form-group">
			<label for="comment" class="col-sm-2 control-label">Misura</label>
			<div class="col-sm-10">
				<input type="text" class="form-control" name="misura"
					placeholder="Inserisci l'unita di misura">
			</div>
		</div>

		<div class="form-group">
			<label for="inputEmail3" class="col-sm-2 control-label">Tipo</label>
			<select class="form-control" name="tipo_prodotto" id="sel1">
				<option>Frutta</option>
				<option>Verdura</option>

			</select>
		</div>


		<div class="form-group">
			<label for="comment" class="col-sm-2 control-label">Stagione</label>
			<div class="col-sm-10">
				<input type="text" class="form-control" name="stagione"
					placeholder="Inserisci la stagione del tuo prodotto">
			</div>
		</div>

		<div class="form-group">
			<label for="comment">Descrizione</label>
			<textarea class="form-control" rows="5" name="descrizione"
				placeholder="Descrivi il prodotto"> </textarea>
		</div>




		<div class="form-group">
			<label for="comment" class="col-sm-2 control-label">Quantita</label>
			<div class="col-sm-10">
				<input type="text" class="form-control" name="quantita"
					placeholder="Inserisci la quantita che hai a disposizione">
			</div>
		</div>

		<div class="form-group">
			<label for="inputEmail3" class="col-sm-2 control-label">Prezzo</label>
			<div class="col-sm-10">
				<input type="text" class="form-control" name="prezzo"
					placeholder="Prezzo">
			</div>
		</div>


		<div class="form-group">
			<label for="comment" class="col-sm-2 control-label">Percorso
				immagine</label>
			<div class="col-sm-10">
				<input type="text" name="img" class="form-control"
					placeholder="Inserisci l'Url o il percorso dell'immagine">
			</div>
		</div>

		<div class="form-group">
			<div class="col-sm-offset-2 col-sm-10"></div>
		</div>

		<div class="form-actions">
			<button type="submit" class="btn btn-success btn-large">Inserisci
				Prodotto</button>
			<button type="reset" class="btn">Annulla</button>
			<br> <br> <br> <br> <br>

			<div class="col-sm-offset-2 col-sm-10"></div>
			<div class="col-sm-offset-2 col-sm-10"></div>

		</div>

	</form>

</body>
</html>
