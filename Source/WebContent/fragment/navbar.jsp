
<nav
	class="navbar fixed-top navbar-expand-lg navbar-dark bg-dark fixed-top">
	<div class="container">
		<a class="navbar-brand"><img src="img/logo1.png"></a>
		<button class="navbar-toggler navbar-toggler-right" type="button"
			data-toggle="collapse" data-target="#navbarResponsive"
			aria-controls="navbarResponsive" aria-expanded="false"
			aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>

		<div class="collapse navbar-collapse" id="navbarResponsive">

			<ul class="navbar-nav ml-auto">

				<%
					Boolean adminRolesSession123 = (Boolean) session.getAttribute("adminRoles");
					if ((adminRolesSession123 == null) || (!adminRolesSession123.booleanValue())) {
				%>
				<li class="nav-item"><a class="nav-link" href="index.jsp">
						Home </a></li>
				<%
					} else {
				%>
				<li class="nav-item"><a class="nav-link" href="index.jsp">
						Home </i>
				</a></li>
				<%
					}
				%>

				<li class="nav-item"><a class="nav-link"
					href="product?action=frutta&tipo=frutta">Frutta</a></li>

				<li class="nav-item"><a class="nav-link"
					href="product?action=verdura&tipo=verdura">Verdura</a></li>

				<li class="nav-item"><a class="nav-link" href="#contatti">Contattaci</a></li>
			</ul>

			<!-- import necessario  -->
			<%@page import="java.util.* , model.Cart"%>
			<%
				Cart cart2;
				synchronized (session) {
					cart2 = (Cart) session.getAttribute("CARRELLO");
				}
			%>
			<%
				/*richiama il metodo che prende da log in il quale setta l'attribbuto  */
				String nome = (String) session.getAttribute("nome");
				if (nome == null) {
					nome = "";

				}
			%>
			<%
				/*se ho effettuato l'accesso quindi la stringa nome è piena*/
				if (!nome.equals("")) {
			%>

			<ul class="nav navbar-nav navbar-right">
				<%
					if (cart2 != null) {
							if (cart2.getNumeroOggettiCarrello() > 0) {
				%>
				<li class="nav-item"><a class="nav-link"
					href="product?action=carrello"><span id="cart-pieno"
						class="fa fa-shopping-basket" style="font-size: 24px"> <%=cart2.getNumeroOggettiCarrello()%></span></a></li>
				<%
					} else {
				%>
				<li class="nav-item"><a class="nav-link"
					href="product?action=carrello"><span
						class="fa fa-shopping-basket" style="font-size: 24px"></span></a></li>

				<%
					}
						}
				%>

				<li class="dropdown"><a class="dropdown-toggle"
					data-toggle="dropdown" href="#"><span id="loggato"
						class="fa fa-user-circle" style="font-size: 24px"></span> <span
						class="caret"></span></a>
					<ul class="dropdown-menu">
						<%
							if ((adminRolesSession123 == null) || (!adminRolesSession123.booleanValue())) {
						%>
						<li><a href="ordine?action=Ordini&username=<%=nome%>"><i
								class='fas fa-list-ul' style='font-size: 24px'></i>I miei ordini</a></li>
						<li><a href="product?action=Log-out"> <i
								class='fas fa-sign-out-alt' style='font-size: 24px'></i>Log-out
						</a></li>
						<%
							} else {
						%>
						<li class="nav-item"><a href="Inserisci-Prodotto.jsp"><i
								class='fas fa-plus' style='font-size: 24px'></i> Inserisci
								prodotto</a></li>
						<li class="nav-item"><a
							href="product?action=Cancella-Prodotto"><i
								class='fas fa-minus' style='font-size: 24px'></i> Cancella
								prodotto</a></li>
						<li class="nav-item"><a href="utente?action=Cancella-Utente"><i
								class='fas fa-user-minus' style='font-size: 24px'></i> Cancella
								utente</a></li>
						<li class="nav-item"><a
							href="ordine?action=Ordini&username=<%=nome%>"><i
								class='fas fa-list-ul' style='font-size: 24px'></i>I miei ordini</a></li>
						<li class="nav-item"><a href="product?action=Log-out"><i
								class='fas fa-sign-out-alt' style='font-size: 24px'></i> Log-out</a></li>
						<%
							}
						%>

					</ul></li>

			</ul>
			<%
				}
				/*se non ho effettuato il log out*/
				else {
			%>
			<!-- carrello efetti  -->
			<ul class="nav navbar-nav navbar-right">
				<%
					if (cart2 != null) {
							if (cart2.getNumeroOggettiCarrello() > 0) {
				%>
				<li class="nav-item"><a class="nav-link"
					href="product?action=carrello"><span id="cart-pieno"
						class="fa fa-shopping-basket" style="font-size: 24px"> <%=cart2.getNumeroOggettiCarrello()%></span></span></a></li>
				<%
					} else {
				%>
				<li class="nav-item"><a class="nav-link"
					href="product?action=carrello"><span
						class="fa fa-shopping-basket" style="font-size: 24px"></span></a></li>

				<%
					}
						}
				%>

				<li class="dropdown"><a class="nav-link" href="#"
					class="dropdown-toggle" data-toggle="dropdown"><span
						class="fa fa-user-circle" style="font-size: 24px"></span><span
						class="caret"></span></a>
					<ul id="login-dp" class="dropdown-menu">
						<li>
							<div class="bottom text-center">Accedi alla tua area
								personale</div>
							<div class="row">
								<div class="col-md-12">
									<form class="form" role="form" method="post" action="Login"
										accept-charset="UTF-8" id="login-nav">
										<div class="form-group">
											<label class="sr-only" for="InputEmail3">Username</label> <input
												type="text" name="username" class="form-control"
												id="inputUsername3" placeholder="username">
										</div>
										<div class="form-group">
											<label class="sr-only" for="inputPassword3">Password</label>
											<input type="password" name="password" class="form-control"
												id="inputPassword3" placeholder="Password">

										</div>

										<div class="form-group">
											<button type="submit" class="btn btn-primary btn-block">Accedi</button>
										</div>
									</form>

								</div>
							</div>
							<div class="bottom text-center">
								Sei nuovo? <a href="Registrazione.jsp"><b>Registrati</b></a>
							</div>
							<br>
							<div class="bottom text-center">
								Vai alla pagina di accesso... <a href="login.jsp"><b>Accedi</b></a>
							</div>

						</li>
					</ul>
			</ul>
			<%
				}
			%>



		</div>
</nav>
