package bbs;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class BbsDAO {

	/* DB연결부 */
	private Connection conn;
	// private PreparedStatement pstmt; 데이터베이스 접근에있어서 마찰이 일어나지 않도록 스테이트먼트는 꺼준다.
	private ResultSet rs;

	public BbsDAO() {// 데이터접근 객체
		try {// 접속을 시도하는 부분
			String dbURL ="jdbc:oracle:thin:@dallae.cu8plpduhf29.ap-northeast-2.rds.amazonaws.com:1521:orcl";
			String dbID = "dancingvitamins";
			String dbPassword = "bongdallae";
			Class.forName("oracle.jdbc.OracleDriver");
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);

		} catch (Exception e) {
			e.printStackTrace();

		}
		
	}
	/* DB연결부 */

	/* 게시판 작성할때 현제 시간을 넣어주는 함수 */

	public String getDate() {
		String SQL = "SELECT NOW()";// 현제 시간을 알려주는 쿼리
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL); // 함수간의 충돌을 피해 안쪽에서 스테이트먼트 실행준비단계로 만들어준다.
			rs = pstmt.executeQuery();// 실행했을때 나오는 결과
			if (rs.next()) {// 결과가 있는 경우에
				return rs.getString(1);// 현재의 날짜를 그대로 반환해준다.
			}
		} catch (Exception e) {

			e.printStackTrace();
		}
		return "";// 데이터베이스 오류

	}

	/* 게시판 작성할때 현제 시간을 넣어주는 함수 */

	/* 게시글 번호 마지막 글과 그다음글의 처리를 위한 함수 */
	public int getNext() {
		String SQL = "SELECT bbsID FROM BBS ORDER BY bbsID DESC";// 내림 차순을 해서 가장 마지막에 쓰여진 데이터를 가져온다.
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL); // 함수간의 충돌을 피해 안쪽에서 스테이트먼트 실행준비단계로 만들어준다.
			rs = pstmt.executeQuery();// 실행했을때 나오는 결과
			if (rs.next()) {// 결과가 있는 경우에
				return rs.getInt(1) + 1;// 가장 마지막 번호에서 1을 더한 숫자를 반환한다.
			}
			return 1;// 결과가 없는 경우 첫번째 게시물일때
		} catch (Exception e) {

			e.printStackTrace();
		}
		return -1;// 데이터베이스 오류

	}
	/* 게시글 번호 마지막 글과 그다음글의 처리를 위한 함수 */

	/* 실제로 글을 작성하는 함수 */

	public int write(String bbsTitle, String userID, String bbsContent) {
		String SQL = "INSERT INTO BBS VALUEs(?,?,?,?,?,?)";// BBS테이블 작성 쿼리
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL); // 함수간의 충돌을 피해 안쪽에서 스테이트먼트 실행준비단계로 만들어준다.

			pstmt.setInt(1, getNext());// getNext함수를 호출하여 하나씩 번호를 늘려나간다//프리페어에 하니씩 물음표에 해당하는 내용을 넣어준다.
			pstmt.setString(2, bbsTitle);
			pstmt.setString(3, userID);
			pstmt.setString(4, getDate());
			pstmt.setString(5, bbsContent);
			pstmt.setInt(6, 1);// 삭제여부와 관련된 변수 1

			// rs = pstmt.executeQuery(); 실행했을때 나오는 결과를 RS에 담아주었는데 이것은 인서트 구문에는 필요없으므로 꺼준다.

			return pstmt.executeUpdate();
			// 0이상인 실행된결과값을 반환한다.

		} catch (Exception e) {

			e.printStackTrace();
		}
		return -1;// 데이터베이스 오류

	}

	/* 실제로 글을 작성하는 함수 */

	/* 데이터베이스에서 글들을 뽑아서 작성한 글들이 Write페이지에 보여지게 하는 함수들 */
	/* 글들이 많아지면 페이지로 나누어이동가능하게하는함수 */
	public ArrayList<Bbs> getList(int pageNumber) {
		String SQL = "SELECT * FROM BBS WHERE bbsID < ? AND bbsAvailable =1 ORDER BY bbsID DESC LIMIT 10";
		// bbsID가 특정숫자보다 작고 삭제되지 않은내림차순 정렬 10개를 가져와라
		ArrayList<Bbs> list = new ArrayList<Bbs>();

		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL); // 함수간의 충돌을 피해 안쪽에서 스테이트먼트 실행준비단계로 만들어준다.
			pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);// 다음작성될 겟넥스트함수에 공식
			rs = pstmt.executeQuery();// 실행했을때 나오는 결과
			while (rs.next()) {// 결과가 나올때마다 반복
				Bbs bbs = new Bbs();// bbs생성
				bbs.setBbsID(rs.getInt(1));
				bbs.setBbsTitle(rs.getString(2));
				bbs.setUserID(rs.getString(3));
				bbs.setBbsDate(rs.getString(4));
				bbs.setBbsContent(rs.getString(5));
				bbs.setBbsAvailable(rs.getInt(6));
				list.add(bbs);

			}

		} catch (Exception e) {

			e.printStackTrace();
		}
		return list;// 데이터베이스 오류

	}
	/* 글들이 많아질 때를 대비하여 페이지로 나누어 이동가능하게 하는 함수 */

	/* 게시글이 10개라면 다음페이지가 없어야 한다. 존재하지 않을때 페이징처리함수 */
	public boolean nextPage(int pageNumber) {
		String SQL = "SELECT * FROM BBS WHERE bbsID < ? AND bbsAvailable =1";
		// bbsID보다 크고 삭제되지 않은 bbs 데이터를 가져와라

		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL); // 함수간의 충돌을 피해 안쪽에서 스테이트먼트 실행준비단계로 만들어준다.
			pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);// 다음작성될 겟넥스트함수에 공식
			rs = pstmt.executeQuery();// 실행했을때 나오는 결과

			if (rs.next()) {// 결과가 하나라도 존재한다면 트루
				return true;
			}

		} catch (Exception e) {

			e.printStackTrace();
		}
		return false;// 결과가 없다면 펄스
		// 페이지가 20개면 그룹페이지가 2개고 페이지21개면 그룹페이지가 3개다.
		// 이함수는 다음 그룹페이지가 있냐없냐를 묻고있다.

	}
	/* 게시글이 10개라면 다음페이지가 없어야 한다. 존재하지 않을때 페이징처리함수 */

	/* 하나의 글이 보여지게 만드는 함수 */

	public Bbs getBbs(int bbsID) {
		String SQL = "SELECT * FROM BBS WHERE bbsID = ?";
		// 특정 숫자의 비비에스를 디비로부터 호출한다

		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL); // 함수간의 충돌을 피해 안쪽에서 스테이트먼트 실행준비단계로 만들어준다.
			pstmt.setInt(1, bbsID);// db에서 불러올 게시물숫자를 set해준다.
			rs = pstmt.executeQuery();// 실행했을때 나오는 결과

			if (rs.next()) {// 결과가 나왔다면
				Bbs bbs = new Bbs();// bbs생성
				bbs.setBbsID(rs.getInt(1));
				bbs.setBbsTitle(rs.getString(2));
				bbs.setUserID(rs.getString(3));
				bbs.setBbsDate(rs.getString(4));
				bbs.setBbsContent(rs.getString(5));
				bbs.setBbsAvailable(rs.getInt(6));
				// list.add(bbs);리스트는 안쓰기떄문에 지워준다.
				return bbs;
			}

		} catch (Exception e) {

			e.printStackTrace();
		}
		return null;// 해당 결과가 존재하지않을때 널값을 반환한다.
	}

	/* 하나의 글이 보여지게 만드는 함수 */

	/* 데이터베이스에서 글들을 뽑아서 작성한 글들이 Write페이지에 보여지게 하는 함수들 */

	/* 글을 수정하는 함수 */
	public int update(int bbsID, String bbsTitle, String bbsContent) {
		// 위 세개의 매개변수가 들어오면 바꿔치기하겠다는 로직
		String SQL = "UPDATE BBS SET bbsTitle =?, bbsContent =? where bbsID=?";// 수정 쿼리
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL); // 함수간의 충돌을 피해 안쪽에서 스테이트먼트 실행준비단계로 만들어준다.
			pstmt.setString(1, bbsTitle);// getNext함수를 호출하여 하나씩 번호를 늘려나간다//프리페어에 하니씩 물음표에 해당하는 내용을 넣어준다.
			pstmt.setString(2, bbsContent);
			pstmt.setInt(3, bbsID);
			// rs = pstmt.executeQuery(); 실행했을때 나오는 결과를 RS에 담아주었는데 이것은 인서트 구문에는 필요없으므로 꺼준다.
			return pstmt.executeUpdate();
			// 0이상인 실행된결과값을 반환한다.

		} catch (Exception e) {

			e.printStackTrace();
		}
		return -1;// 데이터베이스 오류

	}

}

/* 글을 수정하는 함수 */
