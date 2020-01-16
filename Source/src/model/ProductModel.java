package model;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collection;

import control.*;

public interface ProductModel {

	/**Salva un nuovo prodotto
	 * @param product prodotto da salvare
	 * @return void di conseguenza non ritorna niente, il metodo si limita a salvare il nuovo prodotto
	 *  @throws SQLException in caso di errore con il database
	 */
	public void doSave(ProductBean product) throws SQLException;
	/**
	 * Elimina un prodotto dal database in base al codice fornito
	 * @param code il codice del prodotto da eliminare
	 * @return true in caso di eliminazione avvenuta, false altrimenti
	 * @throws SQLException in caso di errore con il database
	 */

	public boolean doDelete(int code) throws SQLException;
	/**
	 * Permette di ricerca un prodotto fornendo il codice
	 * @param code il codice del prodotto da ricercare
	 * @return un oggetto di tipo ProductBean
	 * @throws SQLException in caso di errore con il database
	 */
	public ProductBean doRetrieveByKey(int code) throws SQLException;

	/**Permette di selezionare i prodotti di un determinato tipo
	 * @param tipo del prodotto da selezionare
	 * @return una lista dei prodotti di quel particolare tipo
	 *  @throws SQLException in caso di errore con il database*/
	public Collection<ProductBean> doRetrieveByProd(String tipo) throws SQLException;


	/**
	 *Permette di cercare i prodotti di un determinato tipo
	 *@return un arraylist contenente i prodotti del tipo specificato
	 *  @throws SQLException in caso di errore con il database 
	 */

	public ArrayList<ProductBean> cercaPerTipo(String tipo) throws SQLException;
	/**
	 * Carica tutti i prodotti presenti nel database
	 * @return una collezione di prodotti
	 * @throws SQLException in caso di errore con il database
	 */
	public Collection<ProductBean> doRetrieveAll(String order) throws SQLException;
	/**
	 * Permette di caricare tutti i prodotti dal database
	 * @return un arraylist contenente tutti i prodotti presenti
	 * @throws SQLException in caso di errore con il database
	 */
	public ArrayList<ProductBean> doRetrieveAll2() throws SQLException;

	/**Riservato agli amministratori associa un nuovo codice(non associato giàad un altro prodotto) per inserire un nuovo prodotto nel datatbase
	 * @return un intero che corrisponde al codice del nuovo prodotto
	 * @throws SQLException in caso di errore con il database 
	 * */
	public int getNewCode() throws SQLException;

	/**  Aggiunge un prodotto al database
	 * @param bean il nuovo prodotto da inserire 
	 * @throws SQLException in caso di errore con il database
	 */
	public void AddProduct(ProductBean bean) throws SQLException;
}