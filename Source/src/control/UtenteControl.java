package control;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.*;

/**
 * Servlet dedicata alle azioni da parte dell'utente e vari controlli su tutti gli utenti

 */
@WebServlet("/utente")
public class UtenteControl extends HttpServlet{

	//variabili di istanza
	private static final long serialVersionUID = 6L;
	static UtenteModel model;

	//inizializzazione
	static {
		model = new UtenteModel();
	}

	//costruttore
	public UtenteControl(){
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Cart cart;
		HttpSession session = request.getSession();
		synchronized(session) {
			cart = (Cart) session.getAttribute("CARRELLO");

			/* se il carrello è vuoto lo aggiunge alla sessione*/
			if(cart == null) {
				cart = new Cart();
				session.setAttribute("CARRELLO", cart);
			}
		}
		String action = request.getParameter("action");

		try {
			if (action != null) {
				if(action.equals("Log-out")){
					synchronized(session) {
						session.invalidate();
					}
				}	
				/*Apre la pagina di cancella utenti caricando gli untenti con il metodo showOrder */
				else if(action.equals("Cancella-Utente")){
					request.removeAttribute("accounts");
					/*setta l'attributo accounts( lista di utenti) con ciò che restituisce il metodo*/
					request.setAttribute("accounts", model.showAccount());
				}
				/*Delete utente*/
				else if (action.equalsIgnoreCase("deleteUser")) {
					String  username = (request.getParameter("username"));
					model.doDeleteAccount(username);
				}
			}

		}
		catch (SQLException e) {
			e.printStackTrace();
		}

		RequestDispatcher dispatcher;

		if(action.equals("deleteUser")){
			request.removeAttribute("accounts");
			try {
				request.setAttribute("accounts", model.showAccount());

			} catch (SQLException e) {

				e.printStackTrace();
			}
			dispatcher = getServletContext().getRequestDispatcher("/Cancella-Utente.jsp");
		}

		else if(action.equals("Cancella-Utente"))
			dispatcher = getServletContext().getRequestDispatcher("/Cancella-Utente.jsp");
		else
			dispatcher = getServletContext().getRequestDispatcher("/index.jsp");
		dispatcher.forward(request, response);
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request,response);
	}
}
