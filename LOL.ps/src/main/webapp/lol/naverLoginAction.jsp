<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*"%>
<%@ page import = "com.yg_ac.dao.*" %>
<%@ page import = "com.yg_ac.dto.*" %>
<!DOCTYPE html>
<%
	String email = "naver/" + request.getParameter("email");
	String nickname = request.getParameter("nickname");
	Y_DBmanager y_dbmanager = new Y_DBmanager();
	Connection conn  = y_dbmanager.getConnection();
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	MemberDAO memberdao = new MemberDAO();
	
	MemberDTO member = new MemberDTO(0 , email , "naverPw" , nickname , null, null, null);
	
	//DB에 네이버 이메일이 아예 없는경우
	%>
<html>
<head>
<meta charset="UTF-8">
<title>로딩 중 . . .</title>
</head>
<body>
<% 
if(memberdao.isVaildEmail(email, conn, pstmt , rs)==false) {

		memberdao.snsSignIn(member, conn, pstmt);
		member = memberdao.findByEmailNicknameMemberInfo(email, nickname, conn, pstmt, rs);
		session.setAttribute("memberInfo", member);
%>
		<script>
			alert("환영합니다");
			location.href = "my-page.jsp";
		</script>
<% 		
	//이미 가입이 되어있으면 로그인 진행
	}
	else
	{
		member = memberdao.findByEmailNicknameMemberInfo(email, nickname, conn, pstmt, rs);
		session.setAttribute("memberInfo", member);
%>	
		<script>
			alert("환영합니다");
			location.href = "my-page.jsp";
		</script>
<% 		
	}
%>
</body>
</html>