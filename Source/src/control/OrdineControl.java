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

@WebServlet("/ordine")
/**
 * Classe che gestisce la servlet che controlla gli ordini che è possibile effettuare o quelli già effettuati, da parte dall'utente

 */
public class OrdineControl extends HttpServlet{
	private static final long serialVersionUID = 3L;
	static ProductModel model_prodotto;
	static OrdineModel model;

	static {
		model_prodotto = new ProductModelDS();
		model = new OrdineModel();
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
				/*Lista ordini di un utente specifico*/
				if (action.equalsIgnoreCase("Ordini")) {
					String  username = (request.getParameter("username"));
					request.removeAttribute("listaOrdini");
					request.setAttribute("listaOrdini", model.mostraOrdiniEffettuati(username));
				}
				//finalizza l'ordine dell'utente attuale
				else if (action.equalsIgnoreCase("piazzaOrdine")){
					String nomeutente;
					synchronized (session) {
						nomeutente = (String) session.getAttribute("nome");
					}
					if(nomeutente == null || nomeutente.equals(""))
						return;

					//INFORMAZIONI PER LA SPEDIZIONE
					String nomeSpedizione = request.getParameter("nome");
					String cognomeSpedizione = request.getParameter("cognome");
					String indirizzoSpedizione = request.getParameter("indirizzo");
					String cittaSpedizione = request.getParameter("citta");
					String provinciaSpedizione = request.getParameter("provincia");
					String capSpedizione = request.getParameter("cap");
					String telefono = request.getParameter("telefono");
					String email = request.getParameter("email");

					String infoSpedizione = "Nome: " + nomeSpedizione 			+ ",\n"
							+ "Cognome: " + cognomeSpedizione 		+ ",\n"
							+ "Indirizzo: " + indirizzoSpedizione 	+ ",\n"
							+ "Città: " + cittaSpedizione 			+ ",\n"
							+ "Provincia: " + provinciaSpedizione 	+ ",\n"
							+ "CAP: " + capSpedizione 				+ ",\n"
							+ "Telefono: " + telefono 				+ ",\n"
							+ "Email: " + email 					+ ".";


					//INFORMAZIONI PAGAMENTO
					String tipoCartaPagamento = request.getParameter("tipo_carta");
					String numeroCartaPagamento = request.getParameter("numero_carta");
					String ccvCartaPagamento = request.getParameter("ccv_carta");
					String meseCartaPagamento = request.getParameter("mese_scadenza_carta");
					String anno_scadenza_carta = request.getParameter("anno_scadenza_carta");


					String infoPagamento = "Tipo di carta utlizzata: " + tipoCartaPagamento	+ ",\n"
							+ "Numero della Carta : " + numeroCartaPagamento 	+ ",\n"
							+ "CCV: " + ccvCartaPagamento 						+ ",\n"
							+ "Data di scadenza - MESE: " + meseCartaPagamento + ", ANNO: "+anno_scadenza_carta+ ".";

					model.piazzaOrdine(nomeutente, cart, infoSpedizione , infoPagamento);
					cart.svuotaCarrello();
					synchronized (session) {
						session.setAttribute("CARRELLO", cart);
					}
				}else if(action.equalsIgnoreCase("dettagli")){
					String idOrdineStringa = (String) request.getParameter("idOrdine");
					int idOrdine = Integer.parseInt(idOrdineStringa);

					request.removeAttribute("ordine");
					request.setAttribute("ordine", model.getOrdineByCodice(idOrdine));
				}
			}

		}
		catch (SQLException e) {
			e.printStackTrace();
		}

		RequestDispatcher dispatcher;

		if(action.equals("Ordini"))
			dispatcher = getServletContext().getRequestDispatcher("/ordini.jsp");

		else if(action.equals("dettagli"))
			dispatcher = getServletContext().getRequestDispatcher("/Info-Spedizione.jsp");
		else
			dispatcher = getServletContext().getRequestDispatcher("/index.jsp");

		dispatcher.forward(request, response);
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request,response);
	}
}