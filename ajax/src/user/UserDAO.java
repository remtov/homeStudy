package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class UserDAO {

	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;

	public UserDAO() {
		try {
			String dbURL = "jdbc:oracle:thin:@localhost:1521:XE";
			String dbID = "ictu";
			String dbPassword = "12345678";
			Class.forName("oracle.jdbc.driver.OracleDriver");
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public ArrayList<User> search(String userName) {
		String SQL = "SELECT * FROM USER_INFO WHERE userName LIKE ?";
		ArrayList<User> userList = new ArrayList<User>();
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, "%" + userName + "%");
			rs = pstmt.executeQuery();

			while (rs.next()) {
				User user = new User();
				user.setUserName(rs.getString(1));
				user.setUserAge(rs.getInt(2));
				user.setUserGender(rs.getString(3));
				user.setUserEmail(rs.getString(4));
				userList.add(user);

			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return userList;

	}

	public int register(User user) {// 유저에 유저를 입력받아 데이터베이스에 넣어줄것이다.
		String SQL = "INSERT INTO USER_INFO VALUES (?,?,?,?)";// 네개의 값을 입력받아 하나의 회원데이터로 입력하겠다
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, user.getUserName());
			pstmt.setInt(2, user.getUserAge());
			pstmt.setString(3, user.getUserGender());
			pstmt.setString(4, user.getUserEmail());
			return pstmt.executeUpdate();//성공적으로 작성된 결과를 반환해준다.

		} catch (Exception e) {
			e.printStackTrace();

		}
		return -1;// 데이터베이스 오류가 발생했을 때 -1을반환해라
	}
}
