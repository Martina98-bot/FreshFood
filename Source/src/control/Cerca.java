package control;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.LinkedList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.ProductBean;
import model.ProductModel;
import model.ProductModelDS;

/*
 Servlet per la ricerca dei prodotti all'interno del database in base ad una chiave di ricerca
 */
@WebServlet("/Cerca")
public class Cerca extends HttpServlet {

	//variabili di istanza
	static ProductModel model;
	private static final long serialVersionUID = 1L;

	//inizializzazione
	static {
		model = new ProductModelDS();
	}

	//costruttore
	public Cerca() {
		super();
	}	

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		{
			String cerca = request.getParameter("cerca");
			//	System.out.println(cerca);
			String redirectedPage = "";
			/*try {
				Collection<ProductBean> products = model.cercaPerNome(cerca); 

				System.out.println(products.size());

				request.getSession().setAttribute("products", products);	
				redirectedPage = "/result-cerca.jsp";

			} catch (Exception e) {
				e.printStackTrace();
			}*/

			try {

				ArrayList<ProductBean> products = new ArrayList<ProductBean>();
				Collection<ProductBean> productsResult = new LinkedList<ProductBean>();
				request.getSession().removeAttribute("products");
				products = model.doRetrieveAll2(); 
				//System.out.println(products.size());
				int i =0;
				String parola="";
				int indiceScorrimentoParolaFine = 1;
				/*Altrimenti agiunge un prodotto due volte se è presente la parola in pù posti*/
				boolean trovato = false;
				/*Estrae dal nome ogni possibile parola */
				while (i<products.size()){
					for(int indiceScorrimentoParolaInizio = 0  ;indiceScorrimentoParolaInizio <= products.get(i).getNome().length()-1 && !trovato ; indiceScorrimentoParolaInizio++){
						for( indiceScorrimentoParolaFine = indiceScorrimentoParolaInizio +1  ;indiceScorrimentoParolaFine <= products.get(i).getNome().length() && !trovato; indiceScorrimentoParolaFine++){
							parola= products.get(i).getNome().substring(indiceScorrimentoParolaInizio,indiceScorrimentoParolaFine);
							//	System.out.println("Indici : "+ "inizio "+ indiceScorrimentoParolaInizio  + "fine "+ indiceScorrimentoParolaFine );
							//	System.out.println("Eccola: "+parola);
							if(parola.equalsIgnoreCase(cerca)){
								//System.out.println("Trovato : "+products.get(i).getNome());
								productsResult.add(products.get(i));
								trovato=true;
							}
						}

					}				
					i++;
					trovato=false;
				}

				request.getSession().setAttribute("products", productsResult);				
				redirectedPage = "/result-cerca.jsp";

			} catch (Exception e) {
				redirectedPage = "/result-cerca.jsp";
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