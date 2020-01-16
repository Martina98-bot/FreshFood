package model;
import java.util.ArrayList;
import java.util.List;

import model.*;

public class Cart {

	//variabili di istanza

	private ArrayList<ProductBean> products;

	//costruttore
	public Cart() {
		products = new ArrayList<ProductBean>();
	}
	//metodi
	/**
	 * Metodo per aggiungere un prodotto al carrello
	 * @param product = il prodotto da aggiungere
	 * @param maxQuantitaDisponibile = la quantità massima di prodotto presente in magazzino
	 */
	public boolean addProduct(ProductBean product,int maxQuantitaDisponibile) {
		int i=0;
		if(products.size() == 0){
			products.add(product);
			return true;
		}	
		for(i=0 ; i < products.size() ; i++){
			if(product.getCode() ==  products.get(i).getCode()){	//il prodotto è gia nel carrello
				if(products.get(i).getQuantità() < maxQuantitaDisponibile){		//controllo sulla quantità massima che posso aggiungere
					products.get(i).setQuantità(products.get(i).getQuantità()+1);	
					return true;	//se il controllo va a buon fine, incremento di 1 la quantità e restituisce true
				}
				else return false;	//altrimenti restituisce false
			}
		}
		if(i == products.size()){
			products.add(product);
			return true;
		}
		else 
			return false;
	}
	/**
	 * Restituisce il numero di oggetti presenti nel carrello
	 * @return un intero corrispondente agli oggetti nel carrello
	 */
	public int getNumeroOggettiCarrello(){	
		int conta = 0;
		for (int i=0 ; i < products.size() ; i++){
			conta = conta + products.get(i).getQuantità();
		}
		return conta;
	}
	/**
	 * Elimina tutte le copie di un prodotto presente nel carrello
	 * @param product = il prodotto da eliminare
	 */
	public void deleteProduct(ProductBean product) {
		for(ProductBean prod : products) {
			if(prod.getCode() == product.getCode()) {
				products.remove(prod);
				break;
			}
		}
	}
	/**
	 * Restituisce l'insieme dei prodotti presenti nel carrello
	 * @return una lista di prodotti
	 */
	public List<ProductBean> getProducts() {
		return  products;
	}
	/**
	 * Restituisce il contenuto del carrello sotto forma di stringa
	 */
	public String toString(){
		String daRestituire = "CARRELLO: ";
		if(this.getNumeroOggettiCarrello() == 0)
			daRestituire = daRestituire + "VUOTO";
		else
			for(int i=0 ; i < products.size() ; i++)
				daRestituire = daRestituire + "\n" +  products.get(i).toString();

		return daRestituire;
	}
	/**
	 * Restituisce la somma dei prezzi di tutti gli articoli nel carrello
	 * @return il totale presente nel carrello
	 */
	public double getTotale(){
		double totale = 0;
		for(int i=0 ; i < products.size() ; i++)
			totale = totale + ( products.get(i).getPrezzo() * products.get(i).getQuantità());
		totale = Math.rint(totale*Math.pow(10,2))/Math.pow(10,2);
		return totale;
	}
	/**
	 * Elimina tutti gli oggetti all'interno del carrello
	 */
	public void svuotaCarrello(){
		products.clear(); 
	}

}
