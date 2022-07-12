package ajax;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.yg_ac.dao.MypageProfileChangeDao;
import com.yg_ac.dao.Y_DBmanager;
import com.yg_ac.dto.MemberDTO;

@WebServlet("/MypageProfileChangeServlet")
public class MypageProfileChangeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		String image = request.getParameter("image_name");
		HttpSession session = request.getSession(false);
		MemberDTO member = (MemberDTO) session.getAttribute("memberInfo");
		
		Y_DBmanager db = new Y_DBmanager();
		Connection conn = db.getConnection();
		PreparedStatement pstmt = null;
		
		MypageProfileChangeDao mypageProfileChangeDao = new MypageProfileChangeDao();
		mypageProfileChangeDao.getmypageProfileChange(conn, pstmt, member.getMemberkey(), image);
		response.sendRedirect("lol/my-page.jsp?image_name=change");
	}
}
