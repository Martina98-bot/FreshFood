package model;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Collection;
import java.util.LinkedList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;
/**
 * Classe che modella le operazioni che si possono effettuare sulla tabella utente

 */
public class UtenteModel {
	//variabili di istanza
	private static DataSource ds;
	private static final String TABLE_NAME = "utente";

	static {
		try {
			Context initCtx = new InitialContext();
			Context envCtx = (Context) initCtx.lookup("java:comp/env");

			ds = (DataSource) envCtx.lookup("jdbc/negozio");

		} catch (NamingException e) {
			e.printStackTrace();
		}
	}


	/**
	 * Eliminazione utente tramite l'username
	 */
	public  synchronized void doDeleteAccount(String username) throws SQLException {

		Connection connection = null;
		PreparedStatement preparedStatement = null;

		int result = 0;

		String deleteSQL = "DELETE FROM " + TABLE_NAME + " WHERE username = ?";

		try {
			connection = ds.getConnection();
			preparedStatement = connection.prepareStatement(deleteSQL);
			preparedStatement.setString(1, username);

			result = preparedStatement.executeUpdate();
			if  (result!=0){

			}
		} finally {
			try {
				if (preparedStatement != null)
					preparedStatement.close();
			} finally {
				if (connection != null)
					connection.close();
			}
		}
	}
	/**
	 * Inserimento nuovo account nel db
	 */
	public  synchronized void doSaveNewAccount(Utente utente) throws SQLException {

		Connection connection = null;
		PreparedStatement preparedStatement = null;

		String insertSQL = "INSERT INTO " + TABLE_NAME
				+ " (username,password, tipo) VALUES (?, ?, ?)";

		try {
			connection = ds.getConnection();
			preparedStatement = connection.prepareStatement(insertSQL);

			preparedStatement.setString(1,utente.getUsername());
			preparedStatement.setString(2,utente.getPassword());
			preparedStatement.setString(3,utente.getTipo() );

			preparedStatement.executeUpdate();

			//	connection.commit();
		} finally {
			try {
				if (preparedStatement != null)
					preparedStatement.close();
			} finally {
				if (connection != null)
					connection.close();
			}
		}
	}
	/**
	 * Restituisce una collezione di utenti di tipo cliente.
	 * */
	public synchronized Collection<Utente> showAccount() throws SQLException {
		Connection connection = null;
		PreparedStatement preparedStatement = null;

		Collection<Utente> accounts = new LinkedList<Utente>();

		String selectSQL = "SELECT * FROM " + TABLE_NAME + " WHERE Tipo = 'Cliente'";


		try {
			connection = ds.getConnection();
			preparedStatement = connection.prepareStatement(selectSQL);

			ResultSet rs = preparedStatement.executeQuery();

			while (rs.next()) {
				Utente utente = new Utente();

				utente.setUsername(rs.getString(1));
				utente.setPassword(rs.getString(2));
				utente.setTipo(rs.getString(3));
				accounts.add(utente);
			}

		} finally {
			try {
				if (preparedStatement != null)
					preparedStatement.close();
			} finally {
				if (connection != null)
					connection.close();
			}
		}
		/*Lista di utenti*/
		return accounts;
	}
	/**
	 * Log in utente 
	 * Carica un oggetto utente restituisce un valore 
	 * 1 se è amministratore 
	 * 2 se cliente
	 */
	public synchronized int Login(Utente utente) throws SQLException {
		Connection connection = null;
		PreparedStatement preparedStatement = null;

		int temp = 0;

		String loginSQL = "SELECT * FROM " + TABLE_NAME + " WHERE username = ? and password = ?";

		try {
			connection = ds.getConnection();
			/*vedi se trovi un user o pass uguale nel database*/
			preparedStatement = connection.prepareStatement(loginSQL);
			preparedStatement.setString(1,utente.getUsername());
			preparedStatement.setString(2,utente.getPassword() );

			ResultSet result = preparedStatement.executeQuery();

			if(result.next()){
				utente.setTipo(result.getString("tipo"));
				if(utente.getTipo().equalsIgnoreCase("amministratore")){
					temp=1;
				}
				if(utente.getTipo().equalsIgnoreCase("cliente")){
					temp=2;
				}
			}
		} finally {
			try {
				if (preparedStatement != null)
					preparedStatement.close();
			} finally {
				if (connection != null)
					connection.close();
			}
		}
		if(temp != 0){	//se esiste una combinazione username password come quella inserita, crea il carrello per l'utente
			try {
				String carrelloDB = "SELECT * FROM ordine WHERE ordine.utente = ?";

				connection = ds.getConnection();
				preparedStatement = connection.prepareStatement(carrelloDB);
				preparedStatement.setString(1, utente.getUsername());
				ResultSet result = preparedStatement.executeQuery();

				if(!result.next()){	//se entra nell'if non esiste il carrello
					connection = ds.getConnection();
					String creaCarrelloSQL = "INSERT INTO Ordine VALUES (2,?,0,0,0,0)";

					preparedStatement = connection.prepareStatement(creaCarrelloSQL);
					preparedStatement.setString(1, utente.getUsername());
					preparedStatement.executeUpdate();
				}		
			} finally {
				try {
					if (preparedStatement != null)
						preparedStatement.close();
				} finally {
					if (connection != null)
						connection.close();
				}
			}
		}
		return temp;
	}
	/**
	 * Controlla se esiste uno username uguale a quello passato in input nel database
	 */

	public boolean checkUsername(String username)	{
		boolean nuovo = true;
		Connection connection = null;
		PreparedStatement preparedStatement = null;

		String getListaUsernameUtenti = "SELECT username from utente";

		try {
			connection = ds.getConnection();
			preparedStatement = connection.prepareStatement(getListaUsernameUtenti);

			ResultSet rs = preparedStatement.executeQuery();
			while(rs.next() && nuovo){
				String user = rs.getString(1);
				if(user.equalsIgnoreCase(username))
					nuovo = false;
			}

		}catch(SQLException e){
			e.printStackTrace();
		}
		return nuovo;
	}
}
