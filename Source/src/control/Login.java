package control;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.*;

@WebServlet("/Login")

public class Login extends HttpServlet {

	//variabili di istanza
	static ProductModel model;
	static UtenteModel model_utente;
	static OrdineModel model_ordine;
	private static final long serialVersionUID = 2L;

	//inizializzazione
	static {
		model = new ProductModelDS();
		model_utente = new UtenteModel();
		model_ordine = new OrdineModel();
	}

	//costruttore
	public Login() {
		super();
	}	

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		/*GET*/
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String tipo= request.getParameter("tipo");


		String redirectedPage = "";

		HttpSession session = request.getSession(true);
		synchronized (session) {
			/*GET*/
			Utente utente = (Utente) session.getAttribute("utente");

			utente = new Utente();
			/*SET*/
			utente.setUsername(username);
			utente.setPassword(password);
			utente.setTipo(tipo);
			try {

				int tipoUtente = model_utente.Login(utente);
				/*se l'utente e di tipo cliente*/
				if(tipoUtente == 2){
					/*SET ATTRIBUTE*/
					session.setAttribute("clientRoles", new Boolean(true));
					session.setAttribute("adminRoles", new Boolean(false));	
				}
				/*Se l'utente è di tipo amministratorre*/
				else if(tipoUtente == 1){
					/*SET ATTRIBUTE*/
					session.setAttribute("clientRoles", new Boolean(false));
					session.setAttribute("adminRoles", new Boolean(true));			
				}
				if(tipoUtente == 1 || tipoUtente == 2){
					/*SET ATTRIBUTE*/
					session.setAttribute("utente", utente);
					session.setAttribute("nome", new String(username));

					redirectedPage = "/index.jsp";
					/*GET CART*/
					Cart cart = (Cart) session.getAttribute("CARRELLO");

					/* se il carrello è vuoto lo aggiunge alla sessione*/
					if(cart == null) 
						cart = new Cart();
					/*LOAD CART NEL DB*/
					cart = model_ordine.caricaCarrelloDB(cart, username);
					session.setAttribute("CARRELLO", cart);
					model_ordine.aggiornaCarrelloDB(cart, username);
				}

				else{
					/*SET ATTRIBUTE*/
					session.setAttribute("adminRoles", new Boolean(false));
					session.setAttribute("clientRoles", new Boolean(false));
					redirectedPage = "/login.jsp";
				}
			} catch (Exception e) {
				e.printStackTrace();
			}


			response.sendRedirect(request.getContextPath() + redirectedPage);
		}
	}
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request, response);
	}
}
