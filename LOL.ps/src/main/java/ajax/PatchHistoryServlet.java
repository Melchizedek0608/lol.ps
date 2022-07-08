package ajax;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import com.yg_ac.dao.ChampPatchHistoryDao;
import com.yg_ac.dao.Y_DBmanager;
import com.yg_ac.dto.ChampPatchHistoryDto;
import com.yg_ac.dto.ChampRoleDto;

/**
 * Servlet implementation class PatchHistoryServlet
 */
@WebServlet("/PatchHistoryServlet")
public class PatchHistoryServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public PatchHistoryServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String champion_name = request.getParameter("name");
		
		Y_DBmanager db = new Y_DBmanager();
		Connection conn = db.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		ChampPatchHistoryDao patchHistory = new ChampPatchHistoryDao();
		ArrayList<ChampPatchHistoryDto> patchHistoryList = new ArrayList<ChampPatchHistoryDto>();
		patchHistoryList = patchHistory.getChampPatchHistory(conn, pstmt, rs, champion_name);
		
		response.setCharacterEncoding("UTF-8");
		response.setContentType("application/json");
		PrintWriter out = response.getWriter();
		
		JSONArray patchArray = new JSONArray();
		for(ChampPatchHistoryDto dto:patchHistoryList) {
			JSONObject obj = new JSONObject();
			obj.put("name",dto.getName());
			obj.put("version",dto.getVersion());
			obj.put("skillkey",dto.getSkillKey());
			obj.put("skillname",dto.getSkillName());
			obj.put("content",dto.getContent());
			obj.put("image",dto.getImage());
			patchArray.add(obj);
		}
		out.println(patchArray);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

}
