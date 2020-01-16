package model;

import java.io.Serializable;
import java.util.ArrayList;
/**
 * Classe che modella un ordine, formato da un codice univoco ed una serie di prodotti, 
 * con riferimento alla data in cui è stato effettuato e all'utente che lo ha effettuato
 
 */
public class Ordine implements Serializable  {
	
	//variabili di istanza
	private static final long serialVersionUID = 2L;
	private int codiceOrdine;
	private double spesaTotale;
	private String utente;
	private String dataOrdine;
	private String datiSpedizione;
	private String datiPagamento;
	public ArrayList<ProductBean> prodotti;
	
	//costruttore
	public Ordine() {
		codiceOrdine = 0;
		spesaTotale = 0;
		utente = "";
		dataOrdine = "";
		datiSpedizione = "";
		datiPagamento = "";
		prodotti = new ArrayList<ProductBean>();
	}
	//metodi
	/**
	 * Aggiunge un singolo prodotto all'ordine
	 * @param p il prodotto da inserire nell'ordine
	 */
	public void aggiungiProdotto(ProductBean p){
		this.prodotti.add(p);
	}
	/**
	 * Imposta il codice del nuovo ordine
	 * @param aCodiceOrdine un intero che corrisponde al codice ordine
	 */
	public void setCodiceOrdine(int CodiceOrdine){
		codiceOrdine = CodiceOrdine;
	}
	/**
	 * Restituisce il codice ordine
	 * @return un intero corrispondente al codice ordine
	 */
	public int getCodiceOrdine(){
		return codiceOrdine;
	}
	/**
	 * Imposta la spesa totale per l'ordine
	 * @param spesaTotale un double corrispondente alla spesa
	 */
	public void setSpesaTotale( double spesaTotale) {
    this.spesaTotale=spesaTotale;
	}
	/**
	 * Restituisce il valore complessivo dell'ordine
	 * @return un double corrispondente alla spesa dell'ordine
	 */
	public double getSpesaTotale(){
		return spesaTotale;
	}
	/**
	 * Imposta il nome dell'utente che ha effettuato l'ordine 
	 * @param utente il nome (o username) dell'utente
	 */
	public void setUtente(String utente) {
      this.utente=utente;
	}
	/**
	 * Restituisce il nome dell'utente che ha effettuato l'ordine
	 * @return una stringa contenente il nome utente
	 */
	public String getUtente(){
		return utente;
	}
	/**
	 * Imposta la data in cui è stato effettuato l'ordine
	 * @param dataOrdine una stringa che corrisponde alla data dell'ordine
	 */
	public void setDataOrdine(String dataOrdine) {
	      this.dataOrdine=dataOrdine;
		}
	/**
	 * Restituisce la data in cui è stato effettuato l'ordine
	 * @return una stringa che corrisponde alla data dell'ordine
	 */
	public String getDataOrdine(){
			return dataOrdine;
	}
	/**
	 * Imposta tutti i prodotti presenti nell'ordine in una volta
	 * @param prodottiDaInserire l'insieme dei prodotti che compongono l'ordine
	 */
	public void setProdottiOrdine(ArrayList<ProductBean> prodottiDaInserire){
		this.prodotti = prodottiDaInserire;
	}
	/**
	 * Restituisce tutti i prodotti presenti nell'ordine
	 * @return un arraylist di productbean
	 */
	public ArrayList<ProductBean> getProdottiOrdine(){
		return this.prodotti;
	}
	/**
	 * Restituisce sotto forma di stringa tutti i valori dell'ordine
	 */
	public String toString(){
		String stringa = "ORDINE [CODICE: " + this.codiceOrdine + " ,DATA: " + this.dataOrdine + " ,TOTALE: " + spesaTotale + " ,UTENTE: " + this.utente + " ]\n";
		for(int i=0 ; i < prodotti.size() ; i++){
			stringa = stringa + prodotti.get(i).toString() + "\n";
		}
		return stringa;
	}
	/**
	 * Imposta i dati per la spedizione dell'ordine
	 * @param aDati una stringa che indica i dati della spedizione
	 */
	public void setDatiSpedizione(String aDati){
		datiSpedizione = aDati;
	}
	/**
	 * Restituisce i dati per la spedizione
	 * @return una stringa che indica i dati della spedizione
	 */
	public String getDatiSpedizione(){
		return datiSpedizione;
	}
	/**
	 * Imposta i dati per il pagamento dell'ordine
	 * @param aDati una stringa che indica le informazioni di pagamento
	 */
	public void setDatiPagamento(String aDati){
		datiPagamento = aDati;
	}
	/**
	 * Restituisce i dati per il pagamento dell'ordine
	 * @return una stringa che indica le informazioni di pagamento
	 */
	public String getDatiPagamento(){
		return datiPagamento;
	}
}