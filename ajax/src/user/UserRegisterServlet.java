package user;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/UserRegisterServlet")
public class UserRegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		String userName = request.getParameter("userName");
		String userAge = request.getParameter("userAge");
		String userGender = request.getParameter("userGender");
		String userEmail = request.getParameter("userEmail");
		response.getWriter().write(register(userName,userAge,userGender,userEmail)+"");//int형태의 함수에 보내어지는 write가 안정적으로 동작하기위하여 뒤에 빈문자열을 붙여준다.//이 위치에는 레지스터함수에서 뭔가 값이 잘등록됬을때는 1값이 등록되고 에러가나면 0이란 값이 등록된다. //doPost의 내용은 서치서블릿에서 이미 했던 내용을 복사해온다. 그러나 유저네임안에서만 검색했던 이전과는 달리 네개의 입력사항을 받아야하기에 코드는 늘어난다. 또한 제이슨이 아니라 레지스터함수를 실행한다 4개의 매개변수를 넣어서 
		

	}

	public int register(String userName, String userAge, String userGender, String userEmail) {//기본적으로 넘어온값들은 모두 스트링인경우가 대부분이다.
		User user = new User();//유저인스턴스생성
		try {
			user.setUserName(userName);
			user.setUserAge(Integer.parseInt(userAge));
			user.setUserGender(userGender);
			user.setUserEmail(userEmail);
			
		}catch(Exception e) {
			return 0;//오류가 났을때 0을 반환한다.
		}
		return new UserDAO().register(user);//하나의 유저데이터를 등록할수있도록 만들어준다.
	}

}
