package control;
import model.*;
import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/*@WebServlet("/Product")
/**
 * Servlet implementation class ProductControl
 */
public class ProductControl extends HttpServlet {
	private static final long serialVersionUID = 1L;

	// ProductModelDS usa il DataSource
	// ProductModelDM usa il DriverManager	
	static boolean isDataSource = true;

	static ProductModel model;
	static OrdineModel model_ordine;
	static UtenteModel um;
	private int indice;

	static {
		if (isDataSource) {
			model = new ProductModelDS();

		}
		model_ordine = new OrdineModel();
		um = new UtenteModel();
	}

	public ProductControl() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {




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

		/*log-out  con session.invalidate: annulla una sessione e rimuove eventuali oggetti salvati nel session object*/
		try {
			if (action != null) {
				if(action.equals("Log-out")){
					synchronized(session) {
						session.invalidate();
					}
				}	

				else if(action.equals("vetrina")){
					request.removeAttribute("products");
					request.setAttribute("products", model.doRetrieveAll(""));
				}

				/**Ordini */
				/*Se scegli di eliminare il prodotto dal carrello*/
				else if (action.equalsIgnoreCase("deleteC")) {
					int id = Integer.parseInt(request.getParameter("id"));
					cart.deleteProduct(model.doRetrieveByKey(id));

					String nomeutente;
					synchronized(session) {
						session.setAttribute("CARRELLO", cart);
						nomeutente = (String) session.getAttribute("nome");
					}
					if(nomeutente != null)
						model_ordine.aggiornaCarrelloDB(cart,nomeutente);
				} 

				/*Se scegli di aggiungere il prodotto al carrello*/
				else if (action.equalsIgnoreCase("addC")) {
					int id = Integer.parseInt(request.getParameter("id"));
					ProductBean p = model.doRetrieveByKey(id);

					int quantitaMassimaProdotto = p.getQuantità();
					p.setQuantità(1);
					cart.addProduct(p,quantitaMassimaProdotto);
					String nomeutente;
					synchronized(session) {
						session.setAttribute("CARRELLO", cart);
						nomeutente = (String) session.getAttribute("nome");
					}
					if(nomeutente != null)
						model_ordine.aggiornaCarrelloDB(cart,nomeutente);
				} 

				if (action != null) {
					if (action.equalsIgnoreCase("read")) {
						int id = Integer.parseInt(request.getParameter("id"));
						request.removeAttribute("product");
						request.setAttribute("product", model.doRetrieveByKey(id));

					} 
					if (action.equalsIgnoreCase("lista")) {

						request.removeAttribute("products");
						request.setAttribute("products", model.doRetrieveAll(""));

					} 
					if (action.equalsIgnoreCase("verdura")) {
						String tipoProd = request.getParameter("tipo");
						request.removeAttribute("products");
						request.setAttribute("products", model.cercaPerTipo(tipoProd));

					} 
					if (action.equalsIgnoreCase("frutta")) {
						String tipoProd="";
						tipoProd = request.getParameter("tipo");
						request.removeAttribute("products");
						request.setAttribute("products", model.cercaPerTipo(tipoProd));

					} 
					else if (action.equalsIgnoreCase("delete")) {
						int id = Integer.parseInt(request.getParameter("id"));
						model.doDelete(id);

					} else if (action.equalsIgnoreCase("insert")) {
						String nome = request.getParameter("nome");
						String misura= request.getParameter("misura");
						String tipo_prodotto=request.getParameter("tipo_prodotto");
						String stagione= request.getParameter("stagione");
						String descrizione = request.getParameter("descrizione");
						double prezzo = Double.parseDouble(request.getParameter("prezzo"));
						int quantità = Integer.parseInt(request.getParameter("quantita"));
						String img = request.getParameter("img");



						ProductBean bean = new ProductBean();

						bean.setNome(nome);
						bean.setMisura(misura);
						bean.setTipo_prodotto(tipo_prodotto);
						bean.setStagione(stagione);
						bean.setDescrizione(descrizione);
						bean.setPrezzo(prezzo);
						bean.setQuantità(quantità);
						bean.setImg(img);
						model.doSave(bean);
					}

					/**Prodotto e utente */

					/*Apre la pagina di cancella prodotti caricando i prodotti con il metodo doRetriveAll */
					else if(action.equals("Cancella-Prodotto")){
						request.removeAttribute("products");
						request.setAttribute("products", model.doRetrieveAll(""));
					}

					/*Delete prodotto*/
					else if (action.equalsIgnoreCase("deleteProduct")) {
						int id = Integer.parseInt(request.getParameter("id"));
						model.doDelete(id);
					}
					/*Apre la pagina di cancella utenti caricando gli untenti con il metodo showOrder */
					else if(action.equals("Cancella-Utente")){
						request.removeAttribute("accounts");
						/*setta l'attributo accounts( lista di utenti) conciò che mi restituisce il metodo*/
						request.setAttribute("accounts", um.showAccount());
					}
					/*Delete utente*/
					else if (action.equalsIgnoreCase("deleteUser")) {
						String  username = (request.getParameter("username"));
						um.doDeleteAccount(username);
					}


				}
			}
		}
		catch (SQLException e) {
			e.printStackTrace();
		}
		RequestDispatcher dispatcher=null;


		if(action.equals("lista")) {
			dispatcher = getServletContext().getRequestDispatcher("/NewFile.jsp");
		}

		if(action.equals("vetrina")) {
			dispatcher = getServletContext().getRequestDispatcher("/index.jsp");
		}
		if(action.equals("verdura")) {
			dispatcher = getServletContext().getRequestDispatcher("/verdura.jsp");
		}
		if(action.equals("frutta")) {
			dispatcher= getServletContext().getRequestDispatcher("/frutta.jsp");
		}

		if(action.equals("InsertProduct")) {
			dispatcher= getServletContext().getRequestDispatcher("/Inserisci-Prodotto.jsp");
		}
		/**Carrello*/
		if(action.equals("carrello")) {
			dispatcher = getServletContext().getRequestDispatcher("/carrello.jsp");	
		}	
		if(action.equals("deleteC")) {
			dispatcher = getServletContext().getRequestDispatcher("/carrello.jsp");
		}
		if(action.equals("Log-out")) {
			dispatcher = getServletContext().getRequestDispatcher("/index.jsp");
		}
		if(action.equals("deleteProduct")){
			request.removeAttribute("products");
			try {
				/*SET ATTRIBUTE*/
				request.setAttribute("products", model.doRetrieveAll(""));
			} catch (SQLException e) {

				e.printStackTrace();
			}
			dispatcher = getServletContext().getRequestDispatcher("/Cancella-Prodotto.jsp");
		}
		if(action.equals("Cancella-Prodotto"))	{		
			dispatcher = getServletContext().getRequestDispatcher("/Cancella-Prodotto.jsp");
		}
		if(action.equals("addC")) {
			dispatcher = getServletContext().getRequestDispatcher("/carrello.jsp");
		}

		if(action.equals("addC") && request.getParameter("pagina").equals("result-cerca")){

			dispatcher = getServletContext().getRequestDispatcher("/result-cerca.jsp");
		}

		dispatcher.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
