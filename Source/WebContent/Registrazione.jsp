
<%
	synchronized (session){
		String req = (String) session.getAttribute("registrazioneOK");
		if(req != null){
		 	if(req.equals("registrazioneOK")){
		 		session.removeAttribute("registrazioneOK");
		 		System.out.print("VOGLIO ANDARE A INDEX");
		 		response.sendRedirect("index.jsp");
		 	}
		}
	}
%>
<!DOCTYPE html>
<html lang="ita">

<head>
<meta charset="utf-8">
<title>Registrati</title>
<meta name="viewport" content="width=device-width">
<!-- Bootstrap core CSS -->
<link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">


<!-- CSS PERSONALI -->

<link href="css/testo.css" rel="stylesheet">
<link href="css/validazione.css" rel="stylesheet">
<link href="css/NewFile.css" rel="stylesheet">
<link href="css/footer.css" rel="stylesheet">

<link rel='stylesheet'
	href='https://use.fontawesome.com/releases/v5.7.0/css/all.css'
	integrity='sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ'
	crossorigin='anonymous'>

<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
</head>


<body>
	<%@ include file="fragment/navbar.jsp"%>

	<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
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
			$('#formRegistrazione').validate({
			rules: {	
				
			 	username: {
		       		minlength: 6,
		       		maxlength: 15,
		        	required: true,
		      	},
			 	password: {
					required: true,
					minlength: 6,
				},
				confirm_password: {
					required: true,
					minlength: 6,
					equalTo: "#password",
				},
			   	agree: "required",
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
			$(document).ready(function() {
			var form = $('#formRegistrazione');
				form.submit(function ()  {
					$.ajax({
						type: form.attr('method'),
						url: "RegisterAccount",
				   		data:  form.serialize(),
				  		success: function (data) {
				  			
					    	if (data == "usernameEsistente"){
					    		alert("Username non disponibile");
					        }
					    	
					    }
				    });	//chiude ajax
				});	//chiude function
			});	//chiude document.ready
			</script>

	<!-- Navigation -->

	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<center>
		<h2>Benvenuto nell'area di registrazione di Fresh Food</h2>

		<h3>Inserisci uno Username ed una password per diventare nostro
			cliente</h3>
	</center>

	<div class="container">
		<div class="row-fluid">
			<div class="span6 offset6">
				<div id="maincontent" class="span6">

					<form id="formRegistrazione" class="form-horizontal" method="POST">

						<div class="form-group">
							<label for="username" class="col-sm-2 control-label"><i
								class='fas fa-user' style='font-size: 24px'>Username</i></label>
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
							<label for="confirm_password" class="col-sm-2 control-label"><i
								class='fas fa-key' style='font-size: 24px'></i>Conferma Password</i></label>
							<div class="col-sm-10">
								<input type="password" class="form-control"
									name="confirm_password" id="confirm_password"
									placeholder="Conferma Password">
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label" for="message">
								Consenso ai termini di utilizzo </label>
							<div class="controls">
								<input id="agree" class="checkbox" type="checkbox" name="agree">
							</div>
						</div>

						<div class="form-actions">
							<input type="submit" class="btn btn-success btn-large"
								value="Registrati" />
							<button type="reset" class="btn">Annulla</button>
						</div>

					</form>



				</div>
				<!-- .span -->
			</div>
			<!-- .row -->

		</div>
		<!-- .container -->
	</div>
	<!-- Footer -->
	<%@ include file="fragment/footer.jsp"%>
</body>

</html>