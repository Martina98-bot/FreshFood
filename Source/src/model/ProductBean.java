package model;

public class ProductBean {
	private static final long serialVersionUID = 1L;
	int code;
	String nome;
	String descrizione;
	String stagione;
	String tipo_prodotto;
	String misura;
	String img;
	int quantit�;
	double prezzo;

	public ProductBean() {
		code = -1;
		nome = "";
		descrizione = "";
		stagione="";
		tipo_prodotto= "";
		prezzo= 0;
		misura= "";
		quantit� = 0;
		img="";

	}

	public double getPrezzo() {
		return prezzo;
	}

	public void setPrezzo(double prezzo) {
		this.prezzo = prezzo;
	}

	public int getCode() {
		return code;
	}

	public void setCode(int code) {
		this.code = code;
	}

	public String getNome() {
		return nome;
	}

	public void setNome(String nome) {
		this.nome = nome;
	}

	public String getDescrizione() {
		return descrizione;
	}

	public void setDescrizione(String descrizione) {
		this.descrizione = descrizione;
	}

	public String getStagione() {
		return stagione;
	}

	public void setStagione(String stagione) {
		this.stagione = stagione;
	}

	public String getTipo_prodotto() {
		return tipo_prodotto;
	}

	public void setTipo_prodotto(String tipo_prodotto) {
		this.tipo_prodotto = tipo_prodotto;
	}

	public String getMisura() {
		return misura;
	}

	public void setMisura(String misura) {
		this.misura = misura;
	}

	public int getQuantit�() {
		return quantit�;
	}

	public void setQuantit�(int quantit�) {
		this.quantit� = quantit�;
	}
	public String getImg() {
		return img;
	}

	public void setImg(String img) {
		this.img= img;
	}
	@Override
	public String toString() {
		return "ProductBean [code=" + code + ", nome=" + nome + ", descrizione=" + descrizione + ", stagione="
				+ stagione + ", tipo_prodotto=" + tipo_prodotto + ", misura=" + misura + ", quantit�=" + quantit�
				+ ", prezzo=" + prezzo + "]";
	}




}
