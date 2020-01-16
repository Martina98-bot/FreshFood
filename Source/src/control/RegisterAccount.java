package control;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.*;
/**
 * Servlet che permette di registrare un nuovo account
 */
@WebServlet("/RegisterAccount")
public class RegisterAccount extends HttpServlet {

	//variabili di istanza
	static UtenteModel user_model;
	private static final long serialVersionUID = 5L;

	//inizializzazione
	static {
		user_model = new UtenteModel();
	}
	//costruttore
	public RegisterAccount() {
		super();
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)	throws ServletException, IOException {
		String username = request.getParameter("username");
		String password = request.getParameter("password");

		if(username.equals("") || password.equals("") || username == null || password == null)
			return;

		try{
			if(user_model.checkUsername(username)) {

				Utente utente = new Utente();
				utente.setUsername(username);
				utente.setPassword(password);
				utente.setTipo("Cliente");

				user_model.doSaveNewAccount(utente);

				HttpSession session = request.getSession();
				synchronized (session) {
					session.setAttribute("registrazioneOK", "registrazioneOK");
				}
			} 
			else{		
				response.getWriter().write("usernameEsistente");
			}			
		}catch(Exception e){
			e.printStackTrace();
		}
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}
}