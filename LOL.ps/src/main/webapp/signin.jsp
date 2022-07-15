<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%
	if("nicknameoverlap".equals((String)request.getAttribute("nicknameoverlap"))) {
		
%>
		<script>
			alert("중복된 닉네임이 존재합니다.");
		</script>
<% 	
	}
%>
<%
	if("emailoverlap".equals((String)request.getAttribute("emailoverlap"))) {
		
%>
		<script>
			alert("중복된 email이 존재합니다.");
		</script>
<% 	
	}
%>
<%
	if("success".equals((String)request.getAttribute("success"))) {
		
%>
		<script>
			alert("회원가입이 완료되었습니다.");
		</script>
<% 	
	}
%>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge"> 
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<meta name="google-signin-scope" content="profile email">
<!--     <meta name="google-signin-client_id" content="617468967353-01kodva3scdm890l5ahl1t02rm12b42h.apps.googleusercontent.com"> -->
	<script src="Js/jquery-3.6.0.min.js"></script>
	<script src = 'https://cdn.jsdelivr.net/npm/jquery-validation@1.19.3/dist/jquery.validate.min.js'></script>
	 <script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script>
    <script src="https://developers.kakao.com/sdk/js/kakao.min.js"></script>
<!--     <script src="https://apis.google.com/js/platform.js"  async defer></script> -->
	<title>회원가입</title>
	<link rel="stylesheet" href="Css/all.css">
	<link href='//spoqa.github.io/spoqa-han-sans/css/SpoqaHanSansNeo.css' rel='stylesheet' type='text/css'>
	
<script>
$(function() {
	$(".member-form").validate({
		rules: {
			email : {
				required : true,
				email : true
			},
			password: {
				required : true,
				minlength  : 8
			},
			
			password_confirm : {
				required : true,
				minlength  : 8,
				equalTo : '#password'
			},
			nickname : {
				required : true ,
				minlength  : 3
			},
		},
		messages: {
			email : {
				required : '아이디는 필수입니다.',
				email : "이메일 형식을 올바르게 입력하세요"
			},
			password : {
				required : '암호를 입력하세요.',
				minlength  : '8자 이상 입력하세요'
			},
			password_confirm : {
				required : "암호를 입력하세요.",
				equalTo : "값이 다릅니다 다시 입력해주세요.",
				minlength  : '8자 이상 입력하세요'
			},
			nickname : {
				required : "암호를 입력하세요.",
				minlength  : "최소 3자이상 입력하세요"
			}
		},
			
			
	});
	naverLogin.init(); //initialize Naver Login Button
	 
	$(document).on("click", "#naver_id_login", function(){ 
		var btnNaverLogin = document.getElementById("naverIdLogin").firstChild;
		btnNaverLogin.click();
	});
});
</script>	
</head>
<body class="member-body" style="height:1200px;">
 	
	<!-- 위에 navbar 부분입니다 -->
    <header class="header-mainnav">
        <div class="header-container">
            <a href="main.jsp">
                <img src="Images/header-logo.webp" alt="LOL.PS">
            </a>
            <div class = "nav-item-container">
            	<a class="nav-items" href="notice/notice.html">공지사항</a>
                <a class="nav-items" href="ChampRank.jsp">챔피언 랭킹</a>
                <a class="nav-items" href="community/build.html">빌드게시판</a>
                <a class="nav-items" href="community/free.html">자유게시판</a>
            </div>
            <div class="sign-login">
                <a class="signin" href="signin.jsp">회원가입</a>
               	<a class="login" href="login.jsp">로그인</a>
            </div>
        </div>
    </header>
	
	<div class="all-main">
	    <main class="member-main">
	        <div class = "member-side-left" style="height: 754px;">
	            <section class = "member-ad"></section>
	        </div>
	        <div class = "member-contents">
	            <div class="member-row-sign">
	                <div class = "member-col-12">
	                    <h2 class="member-page-title">회원가입</h2>
	                </div>
	                <div class = "member-row">
	                    <div class = "member-email_login_box"> 
	                        <h3 class="member-h3">이메일 회원 가입</h3>
	                        <form action = "SignInServlet" class="member-form" name="signInForm" method = "POST" novalidate>
	                            <div class = "member-form-group">
	                                <label class="member-laber">이메일 주소</label>
	                                <input type="email" name="email" class="member-form-control" placeholder="gamer@lol.ps" >
	                                <small id = "email-validate" style = "display:none" class = form-error>이미 존재하는 email 입니다.</small>
	                                <p id="email-p"></p>
	                            </div>
	                            <div class = "member-form-group">
	                                <label class="member-laber">비밀번호</label>
	                                <input type="password" name="password" class="member-form-control" id="password" placeholder="비밀번호" >
	                                <p id="password-p"></p>
	                            </div>
	                            <div class = "member-form-group">
	                                <label class="member-laber">비밀번호 확인</label>
	                                <input type="password" name="password_confirm" class="member-form-control" placeholder="비밀번호 확인" >
	                                <small id = "pw-validate"style = "display:none" class = "form-error">비밀번호를 다시 확인하세요.</small>
	                                <p id="password-confirm-p"></p>
	                            </div>
	                            <div class = "member-form-group">
	                                <label class="member-laber">닉네임</label>
           	                        <small id = "nickname-validate" style = "display:none" class = form-error>이미 존재하는 닉네임 입니다.</small>                         
	                                <input type="text" name="nickname" class="member-form-control" id="nickname-input" placeholder="닉네임" >
	                            </div>
	                            <button class="member-btn-theme member-btn-big" id="submit-button">이메일 주소로 가입</button>
	                        </form>
	                    </div>
	
	                    <div class="member-sign-sns signin">
	                        <h3 class="member-h3">소셜계정으로 가입</h3>
	                        <ul class="member-ul">
	                            <li class="member-li">
	                                <a href="javascript:kakaoLogin();"><img src="Images/kakao_login_medium_narrow.png" alt="카카오계정 로그인" style="height: 50px;"/></a>
								 	<script type="text/javascript">
								 	 window.Kakao.init('e1ef84940dda0239cd6f5ad9c860e5b6');
								 		
								 		function kakaoLogin(){
								 			
								 	
								 			window.Kakao.Auth.login({
								 				scope:'account_email , profile_nickname',
								 				success:function(response) {
								 					console.log(response) // 로그인 성공하면 받아오는 데이터
								                    window.Kakao.API.request({ // 사용자 정보 가져오기 
								                        url: '/v2/user/me',
								                        success: (res) => {
								                            const kakao_account = res.kakao_account;
								                            console.log(kakao_account);
								                            var kakaoEmail =res.kakao_account.email;
								                            var kakaoNickname =res.kakao_account.profile.nickname;
								                            location.href = "kakaoLoginAction.jsp?kakaoEmail="+kakaoEmail+"&kakaoNickname="+kakaoNickname;
								 				}
								 			});
								 		},
								 		fail:function(error) {
								 			console.log(error);
								 			}
								 		});
								 		}
								 	</script>
	                            </li>
	                            <li class="member-li">
	                             	<a id = "naver_id_login" class = "sns_btn" >
	                             		 <script type="text/javascript">
											  	var naver_id_login = new naver_id_login("79hXuwg9931gTF0Q5VRD", "http://localhost:9090/LOL.ps/lol/naverCallback.jsp");
											  	var state = naver_id_login.getUniqState();
											  	naver_id_login.setButton("green", 2,30);
											  	naver_id_login.setDomain("http://localhost:9090/LOL.ps/lol/signin.jsp");
											  	naver_id_login.setState(state);
// 											  	naver_id_login.setPopup();
											  	naver_id_login.init_naver_id_login();
  										</script>
	                             	</a>
	                            </li>
	                            
	                            </ul>
	                        </div>
	                    </div>
	                </div>
	            </div>
		</main>
	</div>
<footer class="footer">

    <div class="footer-left">
        <span class="footer-left-item">공지사항</span>
        <span class="footer-left-item">버그리포팅</span>
        <span class="footer-left-item">파트너 신청</span><br/>
        <div style="margin-bottom: 10px;"></div>
        <span class="footer-left-item">이용약관</span>
        <span class="footer-left-item">개인정보처리방침</span>
    </div>

    <div class="footer-right">
        <h5>PS Analytics, Inc. © 2020</h5>
        <p>
            lol.ps is hosted by PS Analytics, Inc. lol.ps isn’t endorsed by Riot Games and doesn’t reflect the views or opinions of Riot Games or anyone officially involved in 
            producing or managing League of Legends. League of Legends and Riot Games are trademarks or registered trademarks of Riot Games, Inc. 
            League of Legends © Riot Games, Inc.
        </p>
    </div>

</footer>

<script src="https://unpkg.com/swiper@8/swiper-bundle.min.js"></script>
<script src="Js/all.js"></script>

</body>
</html>