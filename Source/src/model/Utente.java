package model;


public class Utente {

	String username;
	String password;
	String tipo ;

	public Utente() {
		username= "";
		password="";
		tipo = "";
	}

	public String getUsername() {
		return username;
	}
	public String getPassword() {
		return password;
	}


	public String getTipo() {
		return tipo;
	}
	public void setUsername(String username) {
		this.username=username;
	}
	public void setPassword(String password) {
		this.password=password;
	}

	public void setTipo(String tipo) {
		this.tipo=tipo;
	}




}


