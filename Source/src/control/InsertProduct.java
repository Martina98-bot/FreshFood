package control;

import javax.servlet.annotation.WebServlet;
import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.*;
/**
 * Servlet dedicata all'inserimento di prodotti da parte dell'amministratore

 */
@WebServlet("/InsertProduct")
public class InsertProduct extends HttpServlet {
	//costruttore
	public InsertProduct() {
		super();
	}	
	//variabili di istanza
	private static final long serialVersionUID = 1L;
	static ProductModel model;

	//inizializzazione
	static {
		model = new ProductModelDS();
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		{
			int code = 0;
			try{
				code = model.getNewCode();
			}catch(SQLException e){
				e.printStackTrace();
			}

			String nome = " VUOTO";
			String misura = " ";
			String tipo_prodotto = " ";
			String stagione = " ";
			String descrizione = " ";
			String prezzo ="0";
			String quantità="0";
			String img = " ";

			nome = request.getParameter("nome");

			if(nome != null){

				misura=request.getParameter("misura"); 

				tipo_prodotto=request.getParameter("tipo_prodotto");
				stagione= request.getParameter("stagione");
				descrizione =   request.getParameter("descrizione"); 
				prezzo =   request.getParameter("prezzo");
				double p = Double.parseDouble(prezzo);
				quantità =   request.getParameter("quantita"); 
				int q = Integer.parseInt(quantità);
				img=request.getParameter("img");

				ProductBean bean = new ProductBean();
				bean.setCode(code);
				bean.setNome(nome);
				bean.setMisura(misura);
				bean.setTipo_prodotto(tipo_prodotto);
				bean.setStagione(stagione);
				bean.setDescrizione(descrizione);
				bean.setPrezzo(p);
				bean.setQuantità(q);
				bean.setImg(img);


				//da migliorare
				try {
					if(!bean.getNome().equals("VUOTO")){
						model.AddProduct(bean);
						request.setAttribute("inserimento",true);
					}
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			else{
				request.setAttribute("errore_inserimento",true);
			}

			String redirectedPage = "/Inserisci-Prodotto.jsp";
			response.sendRedirect(request.getContextPath() + redirectedPage);
		}
	}
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request, response);
	}
}


