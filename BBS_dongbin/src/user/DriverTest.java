package user;

	
//	6. DB 접속테스트 (java 테스트) * 클래스패스설정필요
//	
//	ex)c:\jdk1.4\jdbcmysql-connector-java-3.0.15-ga-bin.jar

import java.sql.*;

public class DriverTest { 
	

    private static String JDBC_DRIVER = "oracle.jdbc.OracleDriver";
    private static String JDBC_URL = "jdbc:oracle:thin:@dallae.cu8plpduhf29.ap-northeast-2.rds.amazonaws.com:1521:orcl";
    private static String DBUSER = "dancingvitamins";
    private static String DBUSER_PASS = "bongdallae";
	
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
