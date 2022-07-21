package mvc;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.yg_ac.dao.BoardDao;

public class CommentAction implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int memberkey = Integer.parseInt(request.getParameter("memberkey"));
		int bno = Integer.parseInt(request.getParameter("bno"));
		String content = request.getParameter("content");
		BoardDao bDao = new BoardDao();
		bDao.insertComment(memberkey, bno, content);
		
		request.getRequestDispatcher("ViewDetail.jsp").forward(request, response);
	}
}