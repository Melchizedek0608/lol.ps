package mvc;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.yg_ac.dao.MemberDAO;
import com.yg_ac.dto.MemberDTO;

public class GoogleLoginAction implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		MemberDAO memberdao = new MemberDAO();
		HttpSession session = request.getSession();
		String googleEmail = "google/" + request.getParameter("googleEmail") ;
		String googleNickName =request.getParameter("googleNickName") ;
		MemberDTO member = new MemberDTO(0 , googleEmail , "snsAdmin" , googleNickName , null, null, null);
		System.out.println("email : " + googleEmail  + "  nickname :   " + googleNickName);
		// 이메일이 가입된 적이 없으면  . . .
		//회원가입 진행 
	

		if(memberdao.isVaildEmail(googleEmail)==false) {

			memberdao.snsSignIn(member);
			member = memberdao.findByEmailNicknameMemberInfo(googleEmail, googleNickName);
			session.setAttribute("memberInfo", member);
			request.setAttribute("member", "alright");
			request.getRequestDispatcher("my-page.jsp").forward(request, response);
		//이미 가입이 되어있으면 로그인 진행
		}else {
			member = memberdao.findByEmailNicknameMemberInfo(googleEmail, googleNickName);
			session.setAttribute("memberInfo", member);
			request.setAttribute("welcome", "welcome");
			request.getRequestDispatcher("my-page.jsp").forward(request, response);
		}
	}

}