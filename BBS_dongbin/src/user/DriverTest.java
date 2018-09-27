package user;

	
//	6. DB 접속테스트 (java 테스트) * 클래스패스설정필요
//	
//	ex)c:\jdk1.4\jdbcmysql-connector-java-3.0.15-ga-bin.jar

import java.sql.*;

public class DriverTest { 
	

    private static String JDBC_DRIVER = "com.mysql.jdbc.Driver";
    private static String JDBC_URL = "jdbc:mysql://localhost:3306/BBS";
    private static String DBUSER = "root";
    private static String DBUSER_PASS = "12345678";


	public static void main(String args[]) {
		Connection con = null;
		try {
			Class.forName(JDBC_DRIVER).newInstance();
			con = DriverManager.getConnection(JDBC_URL, DBUSER, DBUSER_PASS);
			System.out.println("Success");
		} catch (SQLException ex) {
			System.out.println("SQLException" + ex);
			ex.printStackTrace();
		} catch (Exception ex) {
			System.out.println("Exception:" + ex);
			ex.printStackTrace();
		}
	}
}
