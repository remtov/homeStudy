package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO {

	/*DB연결부*/
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;

	public UserDAO() {// 데이터접근 객체
		try {// 접속을 시도하는 부분
			String dbURL = "jdbc:mysql://localhost:3306/BBS";
			String dbID = "root";
			String dbPassword = "12345678";
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);

		} catch (Exception e) {
			e.printStackTrace();

		}

	}
	/*DB연결부*/
	
	
	
	public int login(String userID, String userPassword) {
		String SQL = "SELECT userPassword FROM USER WHERE userID=?";// 물음표에 나중에 물음표에 해당되는곳에 내용을 넣어준다.
		try {
			pstmt = conn.prepareStatement(SQL);// SQL데이터베이스에 삽입 SQLexception해킹방어기법
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery(); // 실행한 결과를 넣어준다
			if (rs.next()) {
				// 결과가 존재하면 이곳이실행된다.
				if (rs.getString(1).equals(userPassword)) // 결과와 접속을시도했던 패스워드와 동일하다면
					return 1; // 로그인 성공
				else
					return 0;// 비밀번호 불일치

			}
			return -1;// 아이디가 없을때 이쪽이실행

		} catch (Exception e) {
			e.printStackTrace();
		}
		return -2;// 데이터베이스 오류
	}

	public int join(User user) {// user클래스를 이용하여 만들어지는 인스턴스
		String SQL = "INSERT INTO USER VALUES (?,?,?,?,?)";

		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, user.getUserID());
			pstmt.setString(2, user.getUserPassword());
			pstmt.setString(3, user.getUserName());
			pstmt.setString(4, user.getUserGender());
			pstmt.setString(5, user.getUserEmail());
			return pstmt.executeUpdate(); //해당 스테이트먼트를 실행한 결과를 리턴해준다.
			//인서트문장을 실행한경우 0 이상의 숫자가 반드시 반환된다.

		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;//데이터베이스 오류

	}

}
