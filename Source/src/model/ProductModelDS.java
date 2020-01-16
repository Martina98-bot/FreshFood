package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Collection;
import java.util.LinkedList;
import java.util.ArrayList;
import control.*;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;






public class ProductModelDS implements ProductModel {

	private static DataSource ds;

	static {
		try {
			Context initCtx = new InitialContext();
			Context envCtx = (Context) initCtx.lookup("java:comp/env");

			ds = (DataSource) envCtx.lookup("jdbc/negozio");

		} catch (NamingException e) {
			System.out.println("Error:" + e.getMessage());
		}
	}

	private static final String TABLE_NAME = "product";

	@Override
	public synchronized void doSave(ProductBean product) throws SQLException {

		Connection connection = null;
		PreparedStatement preparedStatement = null;

		String insertSQL = "INSERT INTO " + ProductModelDS.TABLE_NAME
				+ " (CODE, NOME, MISURA, TIPO_PRODOTTO, STAGIONE, DESCRIZIONE, PREZZO, QUANTITA, IMG) VALUES (?,?, ?, ?, ?, ?, ?, ?, ?)";

		try {
			connection = ds.getConnection();
			preparedStatement = connection.prepareStatement(insertSQL);
			preparedStatement = connection.prepareStatement(insertSQL);
			preparedStatement.setInt(1, product.getCode());
			preparedStatement.setString(2, product.getNome());
			preparedStatement.setString(3, product.getMisura());
			preparedStatement.setString(4, product.getTipo_prodotto());
			preparedStatement.setString(5, product.getStagione());
			preparedStatement.setString(6, product.getDescrizione());
			preparedStatement.setDouble(7, product.getPrezzo());
			preparedStatement.setInt(8, product.getQuantità());
			preparedStatement.setString(9, product.getImg());

			preparedStatement.executeUpdate();

			connection.commit();
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

	@Override
	public synchronized ProductBean doRetrieveByKey(int code) throws SQLException {
		Connection connection = null;
		PreparedStatement preparedStatement = null;

		ProductBean bean = new ProductBean();

		String selectSQL = "SELECT * FROM " + ProductModelDS.TABLE_NAME + " WHERE CODE = ?";

		try {
			connection = ds.getConnection();
			preparedStatement = connection.prepareStatement(selectSQL);
			preparedStatement.setInt(1, code);

			ResultSet rs = preparedStatement.executeQuery();

			while (rs.next()) {
				bean.setCode(rs.getInt("CODE"));
				bean.setNome(rs.getString("NOME"));
				bean.setMisura(rs.getString("MISURA"));
				bean.setTipo_prodotto(rs.getString("tipoProdotto"));
				bean.setStagione(rs.getString("STAGIONE"));
				bean.setDescrizione(rs.getString("DESCRIZIONE"));
				bean.setPrezzo(rs.getDouble("PREZZO"));
				bean.setQuantità(rs.getInt("QUANTITA"));
				bean.setDescrizione(rs.getString("IMG"));

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
		return bean;
	}
	@Override
	public synchronized Collection<ProductBean>  doRetrieveByProd(String tipo) throws SQLException { /*se richimi questo è ovvio che non vaaaaa*/
		Connection connection = null;
		PreparedStatement preparedStatement = null;

		Collection<ProductBean> products = new LinkedList<ProductBean>();

		String selectSQL = "SELECT * FROM " + TABLE_NAME + " WHERE " + TABLE_NAME + ".tipoProdotto= ? ";



		try {
			connection = ds.getConnection();
			preparedStatement = connection.prepareStatement(selectSQL);
			preparedStatement.setString(1, tipo);

			ResultSet rs = preparedStatement.executeQuery();

			while (rs.next()) {
				ProductBean bean = new ProductBean();
				bean.setCode(rs.getInt("CODE"));
				bean.setNome(rs.getString("NOME"));
				bean.setMisura(rs.getString("MISURA"));
				bean.setTipo_prodotto(rs.getString("tipoProdotto"));
				bean.setStagione(rs.getString("STAGIONE"));
				bean.setDescrizione(rs.getString("DESCRIZIONE"));
				bean.setPrezzo(rs.getDouble("PREZZO"));
				bean.setQuantità(rs.getInt("QUANTITA"));
				bean.setImg(rs.getString("img"));

				products.add(bean);
			}

		} finally {
			try {
				if (preparedStatement != null)
					preparedStatement.close();
			} finally {
				DriverMaagerConnectionPool.releaseConnection(connection);
			}
		}
		return products;
	}
	/**
	 * Carica tutti i prodotti
	 */

	public synchronized ArrayList<ProductBean> doRetrieveAll2() throws SQLException {
		Connection connection = null;
		PreparedStatement preparedStatement = null;

		ArrayList<ProductBean> products = new ArrayList<ProductBean>();


		String selectSQL = "SELECT * FROM " + TABLE_NAME;

		try {
			connection = ds.getConnection();
			preparedStatement = connection.prepareStatement(selectSQL);

			ResultSet rs = preparedStatement.executeQuery();

			while (rs.next()) {
				ProductBean bean = new ProductBean();

				bean.setCode(rs.getInt("CODE"));
				bean.setNome(rs.getString("NOME"));
				bean.setMisura(rs.getString("MISURA"));
				bean.setTipo_prodotto(rs.getString("tipoProdotto"));
				bean.setStagione(rs.getString("STAGIONE"));
				bean.setDescrizione(rs.getString("DESCRIZIONE"));
				bean.setPrezzo(rs.getDouble("PREZZO"));
				bean.setQuantità(rs.getInt("QUANTITA"));
				bean.setImg(rs.getString("img"));

				products.add(bean);
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
		return products;
	}

	/**
	 * Resituisce una lista di prodotti in base al tipo.
	 * */
	public synchronized ArrayList<ProductBean> cercaPerTipo(String tipo) throws SQLException {
		Connection connection = null;
		PreparedStatement preparedStatement = null;

		ArrayList<ProductBean> products = new ArrayList<ProductBean>();

		String selectSQL = "";

		if (tipo!= null && !tipo.equals("")) {
			selectSQL = "SELECT * FROM " + TABLE_NAME + " WHERE " +  "tipoProdotto = ?";
		}

		try {
			connection = ds.getConnection();
			preparedStatement = connection.prepareStatement(selectSQL);
			preparedStatement.setString(1, tipo);
			ResultSet rs = preparedStatement.executeQuery();

			while (rs.next()) {
				ProductBean bean = new ProductBean();


				bean.setCode(rs.getInt("CODE"));
				bean.setNome(rs.getString("NOME"));
				bean.setMisura(rs.getString("MISURA"));
				bean.setTipo_prodotto(rs.getString("tipoProdotto"));
				bean.setStagione(rs.getString("STAGIONE"));
				bean.setDescrizione(rs.getString("DESCRIZIONE"));
				bean.setPrezzo(rs.getDouble("PREZZO"));
				bean.setQuantità(rs.getInt("QUANTITA"));
				bean.setImg(rs.getString("img"));

				products.add(bean);

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
		return products;
	}


	@Override
	public synchronized boolean doDelete(int code) throws SQLException {
		Connection connection = null;
		PreparedStatement preparedStatement = null;

		int result = 0;

		String deleteSQL = "DELETE FROM " + ProductModelDS.TABLE_NAME + " WHERE CODE = ?";

		try {
			connection = ds.getConnection();
			preparedStatement = connection.prepareStatement(deleteSQL);
			preparedStatement.setInt(1, code);

			result = preparedStatement.executeUpdate();

		} finally {
			try {
				if (preparedStatement != null)
					preparedStatement.close();
			} finally {
				if (connection != null)
					connection.close();
			}
		}
		return (result != 0);
	}

	@Override
	public synchronized Collection<ProductBean> doRetrieveAll(String order) throws SQLException {
		Connection connection = null;
		PreparedStatement preparedStatement = null;

		Collection<ProductBean> products = new LinkedList<ProductBean>();

		String selectSQL = "SELECT * FROM " + ProductModelDS.TABLE_NAME;

		if (order != null && !order.equals("")) {
			selectSQL += " ORDER BY " + order;
		}

		try {
			connection = ds.getConnection();
			preparedStatement = connection.prepareStatement(selectSQL);

			ResultSet rs = preparedStatement.executeQuery();

			while (rs.next()) {
				ProductBean bean = new ProductBean();
				bean.setCode(rs.getInt("CODE"));
				bean.setNome(rs.getString("NOME"));
				bean.setMisura(rs.getString("MISURA"));
				bean.setTipo_prodotto(rs.getString("tipoProdotto"));
				bean.setStagione(rs.getString("STAGIONE"));
				bean.setDescrizione(rs.getString("DESCRIZIONE"));
				bean.setPrezzo(rs.getDouble("PREZZO"));
				bean.setQuantità(rs.getInt("QUANTITA"));
				bean.setImg(rs.getString("img"));

				products.add(bean);
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
		return products;
	}

	/**
	 * Esamina tutti i prodotti presenti nel database e restituisce un nuovo codice per l'inserimento di un prodotto
	 */
	public synchronized int getNewCode(){
		int newCode = 0;

		Connection connection = null;
		PreparedStatement preparedStatement = null;

		String getNewCode = "SELECT code from " + TABLE_NAME;

		try {
			connection = ds.getConnection();
			preparedStatement = connection.prepareStatement(getNewCode);

			ResultSet rs = preparedStatement.executeQuery();

			while(rs.next()){
				int code = rs.getInt(1);
				if(code > newCode)
					newCode = code; 
			}
			newCode++;

		}catch(SQLException e){
			e.printStackTrace();
		}

		return newCode;
	}

	/** Aggiunge un nuovo prodotto al datatbase
	 */
	public  synchronized void AddProduct(ProductBean bean) throws SQLException {

		Connection connection = null;
		PreparedStatement preparedStatement = null;

		String insertSQL = "INSERT INTO " + TABLE_NAME + " VALUES (?,?,?,?,?,?,?,?,?)";

		try {
			connection = ds.getConnection();
			preparedStatement = connection.prepareStatement(insertSQL);

			preparedStatement.setInt(1, bean.getCode());
			preparedStatement.setString(2, bean.getNome());
			preparedStatement.setString(3, bean.getMisura());

			preparedStatement.setString(4, bean.getTipo_prodotto());
			preparedStatement.setString(5, bean.getStagione());
			preparedStatement.setString(6, bean.getDescrizione());
			preparedStatement.setDouble(7, bean.getPrezzo());
			preparedStatement.setInt(8, bean.getQuantità());
			preparedStatement.setString(9, bean.getImg());

			preparedStatement.executeUpdate();

			//connection.commit();
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

}