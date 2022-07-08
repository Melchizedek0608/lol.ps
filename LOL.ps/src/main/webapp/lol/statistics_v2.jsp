<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.yg_ac.dao.*" %>
<%@ page import="com.yg_ac.dto.*" %>
<%@ page import="ajax.*" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<%
	//JDBC
	Y_DBmanager db = new Y_DBmanager();
	Champion champion = new Champion();
	Connection conn = db.getConnection();
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	//sql용 변수
	String champion_name = "갱플랭크";
	String champion_line = "탑";
	/* String champion_name = request.getParameter("name");
	String champion_line = request.getParameter("line"); */
	String champion_rate = "pick";
	
	//요약
	
	//챔피언 해드 이미지, 이름
	String championName = champion.championSummaryHead(conn, pstmt, rs, champion_name).get(0);
	String championImg = champion.championSummaryHead(conn, pstmt, rs, champion_name).get(1);
	
	//높은 포지션 (라인 이름, 퍼센트)
	String[] championLineHighNamePer = new String[6];
	int clhnp = 0;
	for(String str : champion.championSummaryHighPosition(conn, pstmt, rs, champion_name) ) {
		championLineHighNamePer[clhnp] = str;
		clhnp++;
	}
	
	//선택한 포지션 (퍼센트)
	String[] championLineSelectPer = new String[5];
	int clsp = 0;
	for(String str : champion.championSummarySelectPosition(conn, pstmt, rs, champion_name) ) {
		championLineSelectPer[clsp] = str;
		clsp++;
	}
	
	//ps스코어 전
	String championSummaryPsRankBefore = champion.championSummaryPsRankBefore(conn, pstmt, rs, champion_name, champion_line);
	if(championSummaryPsRankBefore==null) {
		championSummaryPsRankBefore = "no score";
	}
	
	//ps스코어 현
	String championSummaryPsRankNow = champion.championSummaryPsRankNow(conn, pstmt, rs, champion_name, champion_line);
	if(championSummaryPsRankNow==null) {
		championSummaryPsRankNow = "no score";
	}
	
	//챔피언 순위 전
	String championSummaryRankingBefore = champion.championSummaryRankingBefore(conn, pstmt, rs, champion_name, champion_line);
	if(championSummaryRankingBefore==null) {
		championSummaryRankingBefore = "no rank";
	} else {
		championSummaryRankingBefore = championSummaryRankingBefore + "등";
	}
	
	//챔피언 순위 현
	String championSummaryRankingNow = champion.championSummaryRankingNow(conn, pstmt, rs, champion_name, champion_line);
	if(championSummaryRankingNow==null) {
		championSummaryRankingNow = "no rank";
	} else {
		championSummaryRankingNow = championSummaryRankingNow + "등";
	}
	
	// 승률 픽률 밴율 카운트
	String championSummaryWin_rate = " ";
	String championSummaryPick_rate = " ";
	String championSummaryBan_rate = " ";
	String championSummaryCount = " ";
	if(champion.championSummaryWinPickBan_rate(conn, pstmt, rs, champion_name, champion_line).size()!=0) {
		championSummaryWin_rate = champion.championSummaryWinPickBan_rate(conn, pstmt, rs, champion_name, champion_line).get(0);
		championSummaryPick_rate = champion.championSummaryWinPickBan_rate(conn, pstmt, rs, champion_name, champion_line).get(1);
		championSummaryBan_rate = champion.championSummaryWinPickBan_rate(conn, pstmt, rs, champion_name, champion_line).get(2);
		championSummaryCount = champion.championSummaryWinPickBan_rate(conn, pstmt, rs, champion_name, champion_line).get(3);	
	} else {
		championSummaryWin_rate = "0";
		championSummaryPick_rate = "0";
		championSummaryBan_rate = "0";
		championSummaryCount = "0"; 
	}
	
	// 챔피언 메인룬
	String[] championSummaryMainRune = new String[42];
	int csmr = 0;
	for(String str : champion.championSummaryMainRune(conn, pstmt, rs, champion_name, champion_line, champion_rate) ) {
		championSummaryMainRune[csmr] = str;
		csmr++;
	}
	
	// 챔피언 보조룬
	String[] championSummaryAssisRune = new String[30];
	int csar = 0;
	if(champion.championSummaryAssisRune(conn, pstmt, rs, champion_name, champion_line, champion_rate).size()!=0) {
		for(String str : champion.championSummaryAssisRune(conn, pstmt, rs, champion_name, champion_line, champion_rate) ) {
			championSummaryAssisRune[csar] = str;
			csar++;
		}
	}
	
	// 챔피언 서브룬
	String[] championSummarySubRune = new String[18];
	int cssr = 0;
	if(champion.championSummarySubRune(conn, pstmt, rs, champion_name, champion_line, champion_rate).size()!=0) {
		for(String str : champion.championSummarySubRune(conn, pstmt, rs, champion_name, champion_line, champion_rate) ) {
			championSummarySubRune[cssr] = str;
			cssr++;
		}	
	}
	
	// 챔피언 1~3 코어 아이템
	String[] championSummaryItemEach1 = new String[9];
	int csie = 0;
	if(champion.championSummaryItemEach1(conn, pstmt, rs, champion_name, champion_line, champion_rate).size()!=0) {
		for(String str : champion.championSummaryItemEach1(conn, pstmt, rs, champion_name, champion_line, champion_rate) ) {
			championSummaryItemEach1[csie] = str;
			csie++;
		}	
	}
	
	String[] championSummaryItemEach2 = new String[9];
	csie = 0;
	if(champion.championSummaryItemEach2(conn, pstmt, rs, champion_name, champion_line, champion_rate).size()!=0) {
		for(String str : champion.championSummaryItemEach2(conn, pstmt, rs, champion_name, champion_line, champion_rate) ) {
			championSummaryItemEach2[csie] = str;
			csie++;
		}	
	}
	
	String[] championSummaryItemEach3 = new String[9];
	csie = 0;
	if(champion.championSummaryItemEach3(conn, pstmt, rs, champion_name, champion_line, champion_rate).size()!=0) {
		for(String str : champion.championSummaryItemEach3(conn, pstmt, rs, champion_name, champion_line, champion_rate) ) {
			championSummaryItemEach3[csie] = str;
			csie++;
		}
	}
	// 챔피언 스킬 마스터 추천 순서
	StatisticsDao statisticsDao = new StatisticsDao();
	ArrayList<GetSkillMasterDto> gsmlist = statisticsDao.getSkillMaster(conn, pstmt, rs, champion_name, champion_line, champion_rate);
	// 챔피언 추천 스펠
	ArrayList<RecommendedSpellsDto> reslist = statisticsDao.recommendedSpells(conn, pstmt, rs, champion_name, champion_line, champion_rate);
	// 챔피언 시작 아이템
	ArrayList<RecommendedSpellsDto> stilist = statisticsDao.startItem(conn, pstmt, rs, champion_name, champion_line, champion_rate);
	// 신발
	ArrayList<RecommendedSpellsDto> shoeslist = statisticsDao.shoes(conn, pstmt, rs, champion_name, champion_line, champion_rate);
	// 챔피언 qwer 이미지
	ArrayList<ChampionQWERDto> csilist = statisticsDao.championSkillImageQWER(conn, pstmt, rs, champion_name);
	// 검색한 챔피언 스킬 11 (순서)
	ArrayList<ChampionSummary11Dto> csylist = statisticsDao.championSummary11(conn, pstmt, rs, champion_name, champion_line, champion_rate);
	
	// 요약
	
	
	//statistics
	
	//상대하기 쉬움, 어려움
	ChampMatchListDao champMatchListDao = new ChampMatchListDao();
	ArrayList<ChampMatchListDto> matchHard = champMatchListDao.getChampMatchListHard(conn, pstmt, rs, champion_name, champion_line);
	ArrayList<ChampMatchListDto> matchEasy = champMatchListDao.getChampMatchListEasy(conn, pstmt, rs, champion_name, champion_line);
	
	//스펠, 스타트아이템, 신발
	ChampStartItemDao champStartItemDao = new ChampStartItemDao();
	ArrayList<ChampStartItemDto> selectSpell = champStartItemDao.getSpell(conn, pstmt, rs, champion_name, champion_line);
	ArrayList<ChampStartItemDto> selectStartItem = champStartItemDao.getStartItem(conn, pstmt, rs, champion_name, champion_line);
	ArrayList<ChampStartItemDto> selectShoes = champStartItemDao.getShoes(conn, pstmt, rs, champion_name, champion_line);
	
	//1,2,3 코어
	CoreEachDao coreEachDao = new CoreEachDao();
	ArrayList<CoreEachDto> core1 = coreEachDao.getCore1(conn, pstmt, rs, champion_name, champion_line);
	ArrayList<CoreEachDto> core2 = coreEachDao.getCore2(conn, pstmt, rs, champion_name, champion_line);
	ArrayList<CoreEachDto> core3 = coreEachDao.getCore3(conn, pstmt, rs, champion_name, champion_line);
	
	//2,3,4 코어조합
	CoreCombineDao CoreCombineDao = new CoreCombineDao();
	ArrayList<CoreCombineDto> coreCombine2 = CoreCombineDao.get2CoreCombine(conn, pstmt, rs, champion_name, champion_line);
	ArrayList<CoreCombineDto> coreCombine3 = CoreCombineDao.get3CoreCombine(conn, pstmt, rs, champion_name, champion_line);
	ArrayList<CoreCombineDto> coreCombine4 = CoreCombineDao.get4CoreCombine(conn, pstmt, rs, champion_name, champion_line);
	
	//스킬 마스터 순서
	SkillMasterDao SkillMasterDao = new SkillMasterDao();
	ArrayList<SkillMasterDto> skillMaster = SkillMasterDao.getSkillMaster(conn, pstmt, rs, champion_name, champion_line);
	
	//스킬 순서
	SkillSeqDao SkillSeqDao = new SkillSeqDao();
	ArrayList<SkillSeqDto> skillSeq3 = SkillSeqDao.getSkillSeq3(conn, pstmt, rs, champion_name, champion_line);
	ArrayList<SkillSeqDto> skillSeq6 = SkillSeqDao.getSkillSeq6(conn, pstmt, rs, champion_name, champion_line);
	ArrayList<SkillSeqDto> skillSeq11 = SkillSeqDao.getSkillSeq11(conn, pstmt, rs, champion_name, champion_line);
	
	//룬조합
	RuneCombineDao RuneCombineDao = new RuneCombineDao();
	ArrayList<RuneCombineDto> runeCombine = RuneCombineDao.getRuneCombine(conn, pstmt, rs, champion_name, champion_line);
	
	//룬파편조합
	RuneShardDao RuneShardDao = new RuneShardDao();
	ArrayList<RuneShardDto> runeShard = RuneShardDao.getRuneShard(conn, pstmt, rs, champion_name, champion_line);
	
	//statistics
	
%>
<html class="statistics-main-html" lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>statistics</title>
    <link rel="stylesheet" href="Css/all.css">
    <style>
		*{box-sizing: border-box;}
    </style>
    <script src="Js/jquery-3.6.0.min.js"></script>
    <script>
   		 /* load() 전체 ajax숙지후 수정필요 */
   		 /* 3레벨, 6레벨 11레벨 */
   		 $(document).ready(function(){
		   	$(document).on("click","#seq3",function(){
		   		$("#skill-seq").load('statisticsAll.jsp #skill-seq3-load');
		   		$('.statistics-what-level-container').find('.statistics-what-level-active').removeClass('statistics-what-level-active');
				$('#seq3').addClass('statistics-what-level-active'); 
		   	});
		    $(document).on("click","#seq6",function(){
		   		$("#skill-seq").load('statisticsAll.jsp #skill-seq6-load'); 
		   		$('.statistics-what-level-container').find('.statistics-what-level-active').removeClass('statistics-what-level-active');
				$('#seq6').addClass('statistics-what-level-active');
		   	});
		    $(document).on("click","#seq11",function(){
		   		$("#skill-seq").load('statisticsAll.jsp #skill-seq11-load'); 
		   		$('.statistics-what-level-container').find('.statistics-what-level-active').removeClass('statistics-what-level-active');
				$('#seq11').addClass('statistics-what-level-active'); 
		   	});
   		 });
    	/* 통계, 기본정보,패치히스토리, 커뮤니티 선택이벤트 핸들러 */
    	$(function(){
    		//통계
		   	$("#champ-nav1").on("click", function() {
			   //$('#loadContents').load('statisticsAll.jsp #statistics');
			   $('.champ-nav').find('.champ-nav-active').removeClass('champ-nav-active');
			   $('#champ-nav1').addClass('champ-nav-active');
			   
			});
    		
		   	//기본정보
		   	$("#champ-nav2").on("click", function() {
		   		var champName = "<%=champion_name%>";
		   		var code = "<div class = 'basic-info-container' id='basic-info'><h3 style='margin :0 0 8px'>기본정보</h3></div>";
        	   $("#loadContents").html(code);
			   
			   $('.champ-nav').find('.champ-nav-active').removeClass('champ-nav-active');
			   $('#champ-nav2').addClass('champ-nav-active');
			   $.ajax({
					type:"get",
					url:"../BasicInfoServlet",
					data:{"name":champName},
					datatype:"json",
					async: false,
					success:function(data){
						var bottom = "";
		            	var color = "";
		            	var write = `<div class = "basic-info-basic-stat-box">
				                        <h4 style="margin: 24px 0 12px;">기본 능력치</h4>
				                        <div class = "basic-info-stat-div-top">
				                            <span class="basic-info-stat-name" style = "background-color:transparent;"></span>
				                            <span class = "basic-info-stat-basic">기본능력치 (+레벨 당 상승)</span>
				                            <span class = "basic-info-stat-final">최종수치</span>
				                            <span class = "basic-info-stat-rank">챔피언 순위</span>
				                        </div>
				                        <div id="loadstat">
				                        </div>
									</div>`;
						$("#basic-info").html(write);
		            	for(var i = 0; i < data.length; i++) {
		            		if(i%2==1){
		            			color = "color";
		            		}else{
		            			color = "";
		            		}
		            		if(i==data.length-1){
		            			bottom = "-bottom";
		            		}
			            write = `<div class = 'basic-info-stat-div\${bottom}' id='\${color}'>
			           				<span class='basic-info-stat-name' >\${data[i].stat}</span>
			            			<span class = 'basic-info-stat-basic'>\${data[i].start}</span>
			            			<span class = 'basic-info-stat-final'>\${data[i].finalstat}</span>
			            			<span class = 'basic-info-stat-rank'>\${data[i].rank}</span>
			            		</div>`;
		            	$("#loadstat").append(write);
		            	}
					},
					error:function(r,s,e){
						alert("에러 \n code:"+r.s+"; \n"+"message:"+r.responseText+"; \n"+"error:"+e);
					}
			   });
			   $.ajax({
				   	type:"get",
					url:"../BasicSkillServlet",
					data:{"name":champName},
					datatype:"json",
					async: false,
					success: function(data){
						var write = `<div class = "basic-info-skill-detail-box">
				            <h4 style="margin: 24px 0 12px;">스킬</h4>            
				            <p class = "basic-info-explanation">클릭하여 상세 설명을 볼 수 있습니다.</p>
				            
				                <h4 style="margin:24px 0 12px;">상세정보</h4>
					            <a href="#skill-p" class = "basic-info-skill-detail-info">
					                <img class = "basic-info-champ-img" src="Images/skill/\${data[1].image}"/>
					                <span class = "basic-info-champ-skill">\${data[1].skillkey}</span>
					                <p class = "basic-info-skill-name">\${data[1].skillname}</p>
					            </a>
					            <a href="#skill-q" class = "basic-info-skill-detail-info">
					                <img class = "basic-info-champ-img" src="Images/skill/\${data[2].image}"/>
					                <span class = "basic-info-champ-skill">\${data[2].skillkey}</span>
					                <p class = "basic-info-skill-name">\${data[2].skillname}</p>
					            </a>
					            <a href="#skill-w" class = "basic-info-skill-detail-info">
					                <img class = "basic-info-champ-img" src="Images/skill/\${data[4].image}"/>
					                <span class = "basic-info-champ-skill">\${data[4].skillkey}</span>
					                <p class = "basic-info-skill-name">\${data[4].skillname}</p>
					            </a>
					            <a href="#skill-e" class = "basic-info-skill-detail-info">
					                <img class = "basic-info-champ-img" src="Images/skill/\${data[0].image}"/>
					                <span class = "basic-info-champ-skill">\${data[0].skillkey}</span>
					                <p class = "basic-info-skill-name">\${data[0].skillname}</p>
					            </a>
					            <a href="#skill-r" class = "basic-info-skill-detail-info">
					                <img class = "basic-info-champ-img" src="Images/skill/\${data[3].image}"/>
					                <span class = "basic-info-champ-skill">\${data[3].skillkey}</span>
					                <p class = "basic-info-skill-name">\${data[3].skillname}</p>
					            </a>
				            
				            <div id="champrole">
				            	
				            </div>
				            
				        </div>

				        <div style="clear: both; height:100px;" id="skill-p"></div>

				        <div class = "basic-info-skill-container">
					            <h4>스킬 상세설명</h4>
					            
					            <div class = "basic-info-skill-info-box" style="border-top: 1px solid rgba(126, 155, 255, .5);">
					                <div class = "basic-info-skill-info-name">
					                    <span class = "basic-info-skill-kind" id = "skill-q">\${data[1].skillkey}</span>
					                    <h5 class = "basic-info-skill-kor-name">\${data[1].skillname}</h5>                   
					                </div>
					                <div class = "basic-info-skill-info">
					                    <img src="Images/skill/\${data[1].image}" style="display: block;" />
					                  
					                    <p class="basic-info-skill-text-style">\${data[1].skillfunction}</p>
					                </div>
					            </div>
					            
					            <div class = "basic-info-skill-info-box" style="border-top: 1px solid rgba(126, 155, 255, .5);">
					                <div class = "basic-info-skill-info-name">
					                    <span class = "basic-info-skill-kind" id = "skill-w">\${data[2].skillkey}</span>
					                    <h5 class = "basic-info-skill-kor-name">\${data[2].skillname}</h5>                   
					                </div>
					                <div class = "basic-info-skill-info">
					                    <img src="Images/skill/\${data[2].image}" style="display: block;" />
					                  
					                    <p class="basic-info-skill-text-style">\${data[2].skillfunction}</p>
					                </div>
					            </div>
					            
					            <div class = "basic-info-skill-info-box" style="border-top: 1px solid rgba(126, 155, 255, .5);">
					                <div class = "basic-info-skill-info-name">
					                    <span class = "basic-info-skill-kind" id = "skill-e">\${data[4].skillkey}</span>
					                    <h5 class = "basic-info-skill-kor-name">\${data[4].skillname}</h5>                   
					                </div>
					                <div class = "basic-info-skill-info">
					                    <img src="Images/skill/\${data[4].image}" style="display: block;" />
					                  
					                    <p class="basic-info-skill-text-style">\${data[4].skillfunction}</p>
					                </div>
					            </div>
					            
					            <div class = "basic-info-skill-info-box" style="border-top: 1px solid rgba(126, 155, 255, .5);">
					                <div class = "basic-info-skill-info-name">
					                    <span class = "basic-info-skill-kind" id = "skill-r">\${data[0].skillkey}</span>
					                    <h5 class = "basic-info-skill-kor-name">\${data[0].skillname}</h5>                   
					                </div>
					                <div class = "basic-info-skill-info">
					                    <img src="Images/skill/\${data[0].image}" style="display: block;" />
					                  
					                    <p class="basic-info-skill-text-style">\${data[0].skillfunction}</p>
					                </div>
					            </div>
					            
					            <div class = "basic-info-skill-info-box" style="border-top: 1px solid rgba(126, 155, 255, .5);">
					                <div class = "basic-info-skill-info-name">
					                    <span class = "basic-info-skill-kind" >\${data[3].skillkey}</span>
					                    <h5 class = "basic-info-skill-kor-name">\${data[3].skillname}</h5>                   
					                </div>
					                <div class = "basic-info-skill-info">
					                    <img src="Images/skill/\${data[3].image}" style="display: block;" />
					                  
					                    <p class="basic-info-skill-text-style">\${data[3].skillfunction}</p>
					                </div>
					            </div>
				        </div>`;
				    $("#basic-info").append(write);
					},
					error: function(r,s,e){
						alert("에러 \n code:"+r.s+"; \n"+"message:"+r.responseText+"; \n"+"error:"+e);
					}
			   });
			   $.ajax({
				   type:"get",
					url:"../ChampRoleServlet",
					data:{"name":champName},
					datatype:"json",
					success: function(data){
						var write = `<span style="color: rgba(47,62,78 , .7); font-size: 12px;">역할군</span>
			                <span style="font-size: 14px; font-weight : 700; color: #353945;">\${data[0].role1}</span>
			            	<br/>`;
			            if(data[0].role2==="없음"){
			            	
			            }else{
		                    write += `<span style="color: rgba(47,62,78 , .7); font-size: 12px;">역할군</span>
		                    <span style="font-size: 14px; font-weight : 700; color: #353945;">\${data[0].role2}</span>`;
		                }
			            $("#champrole").html(write);
					},
					error: function(r,s,e){
						alert("에러 \n code:"+r.s+"; \n"+"message:"+r.responseText+"; \n"+"error:"+e);
					}
			   });
			});
		   	
		   	//패치 히스토리
		   	$("#champ-nav3").on("click", function() {
		   		var champName = "<%=champion_name%>";
				$('.champ-nav').find('.champ-nav-active').removeClass('champ-nav-active');
				$('#champ-nav3').addClass('champ-nav-active');
				$.ajax({
				   	type:"get",
					url:"../PatchHistoryServlet",
					data:{"name":champName},
					datatype:"json",
					success:function(data){
						var write = `<div id="patch-history">
							<section style="padding-bottom:400px;" id="patch_history_section">
							<h3>\${data[0].name} 패치 히스토리</h3>
							</section>
							</div>`;
						$("#loadContents").html(write);
						for(var i = 0;i < data.length;i++){
							write = `<div class="patch-history-patch">
										<div class="patch-history-ver">
										<h4 class="patch-history-h4">\${data[i].version}</h4>
											<div class="patch-history-skill-imgbox">
												<span><img class="patch-history-img" src="Images/skill/\${data[i].image}"/></span>
											</div>
											<div class="patch-history-content">
												<ul class="patch-history-ul">
													<li class="patch-history-li">\${data[i].content}</li>
												</ul>
											</div>
										</div>
									</div>`;
							$("#patch_history_section").append(write);
						}
					},
					error: function(r,s,e){
						alert("에러 \n code:"+r.s+"; \n"+"message:"+r.responseText+"; \n"+"error:"+e);
					}
				});
			});
		   	
		   	//커뮤니티
		   	$("#champ-nav4").on("click", function() {
			   //$('#loadContents').load('statisticsAll.jsp #champ-community');
			   $('.champ-nav').find('.champ-nav-active').removeClass('champ-nav-active');
			   $('#champ-nav4').addClass('champ-nav-active');
			});
	 		
		   	const csmrSize = <%=champion.championSummaryMainRune(conn, pstmt, rs, champion_name, champion_line, champion_rate).size()%>;
    		if(csmrSize==36) {
    			const csmr361 = "<div class='tooltip'><img src='Images/rune/<%=championSummaryMainRune[1]%>' alt='img'><span class='tooltiptext tooltip-right'><b style='color:#ffc107;'><%=championSummaryMainRune[0]%></b></br></br><%=championSummaryMainRune[2]%></span></div><div class='tooltip'><img src='Images/rune/<%=championSummaryMainRune[4]%>' alt='img'><span class='tooltiptext tooltip-right'><b style='color:#ffc107;'><%=championSummaryMainRune[3]%></b></br></br><%=championSummaryMainRune[5]%></span></div><div class='tooltip'><img src='Images/rune/<%=championSummaryMainRune[7]%>' alt='img'><span class='tooltiptext tooltip-right'><b style='color:#ffc107;'><%=championSummaryMainRune[6]%></b></br></br><%=championSummaryMainRune[8]%></span></div>";
        		const csmr362 = "<div class='tooltip'><img src='Images/rune/<%=championSummaryMainRune[10]%>' alt='img'><span class='tooltiptext tooltip-right'><b style='color:#ffc107;'><%=championSummaryMainRune[9]%></b></br></br><%=championSummaryMainRune[11]%></span></div><div class='tooltip'><img src='Images/rune/<%=championSummaryMainRune[13]%>' alt='img'><span class='tooltiptext tooltip-right'><b style='color:#ffc107;'><%=championSummaryMainRune[12]%></b></br></br><%=championSummaryMainRune[14]%></span></div><div class='tooltip'><img src='Images/rune/<%=championSummaryMainRune[16]%>' alt='img'><span class='tooltiptext tooltip-right'><b style='color:#ffc107;'><%=championSummaryMainRune[15]%></b></br></br><%=championSummaryMainRune[17]%></span></div>";
        		const csmr363 = "<div class='tooltip'><img src='Images/rune/<%=championSummaryMainRune[19]%>' alt='img'><span class='tooltiptext tooltip-right'><b style='color:#ffc107;'><%=championSummaryMainRune[18]%></b></br></br><%=championSummaryMainRune[20]%></span></div><div class='tooltip'><img src='Images/rune/<%=championSummaryMainRune[22]%>' alt='img'><span class='tooltiptext tooltip-right'><b style='color:#ffc107;'><%=championSummaryMainRune[21]%></b></br></br><%=championSummaryMainRune[23]%></span></div><div class='tooltip'><img src='Images/rune/<%=championSummaryMainRune[25]%>' alt='img'><span class='tooltiptext tooltip-right'><b style='color:#ffc107;'><%=championSummaryMainRune[24]%></b></br></br><%=championSummaryMainRune[26]%></span></div>";
        		const csmr364 = "<div class='tooltip'><img src='Images/rune/<%=championSummaryMainRune[28]%>' alt='img'><span class='tooltiptext tooltip-right'><b style='color:#ffc107;'><%=championSummaryMainRune[27]%></b></br></br><%=championSummaryMainRune[29]%></span></div><div class='tooltip'><img src='Images/rune/<%=championSummaryMainRune[31]%>' alt='img'><span class='tooltiptext tooltip-right'><b style='color:#ffc107;'><%=championSummaryMainRune[30]%></b></br></br><%=championSummaryMainRune[32]%></span></div><div class='tooltip'><img src='Images/rune/<%=championSummaryMainRune[34]%>' alt='img'><span class='tooltiptext tooltip-right'><b style='color:#ffc107;'><%=championSummaryMainRune[33]%></b></br></br><%=championSummaryMainRune[35]%></span></div>";
        		$('#main-rune-1').html(csmr361);
        		$('#main-rune-2').html(csmr362);
        		$('#main-rune-3').html(csmr363);
        		$('#main-rune-4').html(csmr364);
        	}else if(csmrSize==39) {
        		const csmr391 = "<div class='tooltip'><img src='Images/rune/<%=championSummaryMainRune[1]%>' alt='img'><span class='tooltiptext tooltip-right'><b style='color:#ffc107;'><%=championSummaryMainRune[0]%></b></br></br><%=championSummaryMainRune[2]%></span></div><div class='tooltip'><img src='Images/rune/<%=championSummaryMainRune[4]%>' alt='img'><span class='tooltiptext tooltip-right'><b style='color:#ffc107;'><%=championSummaryMainRune[3]%></b></br></br><%=championSummaryMainRune[5]%></span></div><div class='tooltip'><img src='Images/rune/<%=championSummaryMainRune[7]%>' alt='img'><span class='tooltiptext tooltip-right'><b style='color:#ffc107;'><%=championSummaryMainRune[6]%></b></br></br><%=championSummaryMainRune[8]%></span></div><div class='tooltip'><img src='Images/rune/<%=championSummaryMainRune[10]%>' alt='img'><span class='tooltiptext tooltip-right'><b style='color:#ffc107;'><%=championSummaryMainRune[9]%></b></br></br><%=championSummaryMainRune[11]%></span></div>";
        		const csmr392 = "<div class='tooltip'><img src='Images/rune/<%=championSummaryMainRune[13]%>' alt='img'><span class='tooltiptext tooltip-right'><b style='color:#ffc107;'><%=championSummaryMainRune[12]%></b></br></br><%=championSummaryMainRune[14]%></span></div><div class='tooltip'><img src='Images/rune/<%=championSummaryMainRune[16]%>' alt='img'><span class='tooltiptext tooltip-right'><b style='color:#ffc107;'><%=championSummaryMainRune[15]%></b></br></br><%=championSummaryMainRune[17]%></span></div><div class='tooltip'><img src='Images/rune/<%=championSummaryMainRune[19]%>' alt='img'><span class='tooltiptext tooltip-right'><b style='color:#ffc107;'><%=championSummaryMainRune[18]%></b></br></br><%=championSummaryMainRune[20]%></span></div>";
        		const csmr393 = "<div class='tooltip'><img src='Images/rune/<%=championSummaryMainRune[22]%>' alt='img'><span class='tooltiptext tooltip-right'><b style='color:#ffc107;'><%=championSummaryMainRune[21]%></b></br></br><%=championSummaryMainRune[23]%></span></div><div class='tooltip'><img src='Images/rune/<%=championSummaryMainRune[25]%>' alt='img'><span class='tooltiptext tooltip-right'><b style='color:#ffc107;'><%=championSummaryMainRune[24]%></b></br></br><%=championSummaryMainRune[26]%></span></div><div class='tooltip'><img src='Images/rune/<%=championSummaryMainRune[28]%>' alt='img'><span class='tooltiptext tooltip-right'><b style='color:#ffc107;'><%=championSummaryMainRune[27]%></b></br></br><%=championSummaryMainRune[29]%></span></div>";
        		const csmr394 = "<div class='tooltip'><img src='Images/rune/<%=championSummaryMainRune[31]%>' alt='img'><span class='tooltiptext tooltip-right'><b style='color:#ffc107;'><%=championSummaryMainRune[30]%></b></br></br><%=championSummaryMainRune[32]%></span></div><div class='tooltip'><img src='Images/rune/<%=championSummaryMainRune[34]%>' alt='img'><span class='tooltiptext tooltip-right'><b style='color:#ffc107;'><%=championSummaryMainRune[33]%></b></br></br><%=championSummaryMainRune[35]%></span></div><div class='tooltip'><img src='Images/rune/<%=championSummaryMainRune[37]%>' alt='img'><span class='tooltiptext tooltip-right'><b style='color:#ffc107;'><%=championSummaryMainRune[36]%></b></br></br><%=championSummaryMainRune[38]%></span></div>";
        		$('#main-rune-1').html(csmr391);
        		$('#main-rune-2').html(csmr392);
        		$('#main-rune-3').html(csmr393);
        		$('#main-rune-4').html(csmr394);
        	}else if(csmrSize==42){
        		const csmr421 = "<div class='tooltip'><img src='Images/rune/<%=championSummaryMainRune[1]%>' alt='img'><span class='tooltiptext tooltip-right'><b style='color:#ffc107;'><%=championSummaryMainRune[0]%></b></br></br><%=championSummaryMainRune[2]%></span></div><div class='tooltip'><img src='Images/rune/<%=championSummaryMainRune[4]%>' alt='img'><span class='tooltiptext tooltip-right'><b style='color:#ffc107;'><%=championSummaryMainRune[3]%></b></br></br><%=championSummaryMainRune[5]%></span></div><div class='tooltip'><img src='Images/rune/<%=championSummaryMainRune[7]%>' alt='img'><span class='tooltiptext tooltip-right'><b style='color:#ffc107;'><%=championSummaryMainRune[6]%></b></br></br><%=championSummaryMainRune[8]%></span></div><div class='tooltip'><img src='Images/rune/<%=championSummaryMainRune[10]%>' alt='img'><span class='tooltiptext tooltip-right'><b style='color:#ffc107;'><%=championSummaryMainRune[9]%></b></br></br><%=championSummaryMainRune[11]%></span></div>";
        		const csmr422 = "<div class='tooltip'><img src='Images/rune/<%=championSummaryMainRune[13]%>' alt='img'><span class='tooltiptext tooltip-right'><b style='color:#ffc107;'><%=championSummaryMainRune[12]%></b></br></br><%=championSummaryMainRune[14]%></span></div><div class='tooltip'><img src='Images/rune/<%=championSummaryMainRune[16]%>' alt='img'><span class='tooltiptext tooltip-right'><b style='color:#ffc107;'><%=championSummaryMainRune[15]%></b></br></br><%=championSummaryMainRune[17]%></span></div><div class='tooltip'><img src='Images/rune/<%=championSummaryMainRune[19]%>' alt='img'><span class='tooltiptext tooltip-right'><b style='color:#ffc107;'><%=championSummaryMainRune[18]%></b></br></br><%=championSummaryMainRune[20]%></span></div>";
        		const csmr423 = "<div class='tooltip'><img src='Images/rune/<%=championSummaryMainRune[22]%>' alt='img'><span class='tooltiptext tooltip-right'><b style='color:#ffc107;'><%=championSummaryMainRune[21]%></b></br></br><%=championSummaryMainRune[23]%></span></div><div class='tooltip'><img src='Images/rune/<%=championSummaryMainRune[25]%>' alt='img'><span class='tooltiptext tooltip-right'><b style='color:#ffc107;'><%=championSummaryMainRune[24]%></b></br></br><%=championSummaryMainRune[26]%></span></div><div class='tooltip'><img src='Images/rune/<%=championSummaryMainRune[28]%>' alt='img'><span class='tooltiptext tooltip-right'><b style='color:#ffc107;'><%=championSummaryMainRune[27]%></b></br></br><%=championSummaryMainRune[29]%></span></div>";
        		const csmr424 = "<div class='tooltip'><img src='Images/rune/<%=championSummaryMainRune[31]%>' alt='img'><span class='tooltiptext tooltip-right'><b style='color:#ffc107;'><%=championSummaryMainRune[30]%></b></br></br><%=championSummaryMainRune[32]%></span></div><div class='tooltip'><img src='Images/rune/<%=championSummaryMainRune[34]%>' alt='img'><span class='tooltiptext tooltip-right'><b style='color:#ffc107;'><%=championSummaryMainRune[33]%></b></br></br><%=championSummaryMainRune[35]%></span></div><div class='tooltip'><img src='Images/rune/<%=championSummaryMainRune[37]%>' alt='img'><span class='tooltiptext tooltip-right'><b style='color:#ffc107;'><%=championSummaryMainRune[36]%></b></br></br><%=championSummaryMainRune[38]%></span></div><div class='tooltip'><img src='Images/rune/<%=championSummaryMainRune[40]%>' alt='img'><span class='tooltiptext tooltip-right'><b style='color:#ffc107;'><%=championSummaryMainRune[39]%></b></br></br><%=championSummaryMainRune[41]%></span></div>";
        		$('#main-rune-1').html(csmr421);
        		$('#main-rune-2').html(csmr422);
        		$('#main-rune-3').html(csmr423);
        		$('#main-rune-4').html(csmr424);
        	}
    		
    		const csieSize1 = <%=champion.championSummaryItemEach1(conn, pstmt, rs, champion_name, champion_line, champion_rate).size()%>;
    		const csieSize2 = <%=champion.championSummaryItemEach2(conn, pstmt, rs, champion_name, champion_line, champion_rate).size()%>;
    		const csieSize3 = <%=champion.championSummaryItemEach3(conn, pstmt, rs, champion_name, champion_line, champion_rate).size()%>;
    		if(csieSize1==3){
    			const csie11 = "1코어 <span class='tooltip'><img src='Images/item/<%=championSummaryItemEach1[1]%>' alt='img'><span class='tooltiptext tooltip-right'><b style='color:#ffc107;'><%=championSummaryItemEach1[0]%></b></br></br><%=championSummaryItemEach1[2]%></span></span>";
    			$('#item-core-summary1').html(csie11);
    		}else if(csieSize1==6) {
    			const csie12 = "1코어 <span class='tooltip'><img src='Images/item/<%=championSummaryItemEach1[1]%>' alt='img'><span class='tooltiptext tooltip-right'><b style='color:#ffc107;'><%=championSummaryItemEach1[0]%></b></br></br><%=championSummaryItemEach1[2]%></span></span> or <span class='tooltip'><img src='Images/item/<%=championSummaryItemEach1[4]%>' alt='img'><span class='tooltiptext tooltip-right'><b style='color:#ffc107;'><%=championSummaryItemEach1[3]%></b></br></br><%=championSummaryItemEach1[5]%></span></span>";
    			$('#itme-core-summary1').html(csie12);
    		}else if(csieSize1==9) {
    			const csie13 = "1코어 <span class='tooltip'><img src='Images/item/<%=championSummaryItemEach1[1]%>' alt='img'><span class='tooltiptext tooltip-right'><b style='color:#ffc107;'><%=championSummaryItemEach1[0]%></b></br></br><%=championSummaryItemEach1[2]%></span></span> or <span class='tooltip'><img src='Images/item/<%=championSummaryItemEach1[4]%>' alt='img'><span class='tooltiptext tooltip-right'><b style='color:#ffc107;'><%=championSummaryItemEach1[3]%></b></br></br><%=championSummaryItemEach1[5]%></span></span> or <span class='tooltip'><img src='Images/item/<%=championSummaryItemEach1[7]%>' alt='img'><span class='tooltiptext tooltip-right'><b style='color:#ffc107;'><%=championSummaryItemEach1[6]%></b></br></br><%=championSummaryItemEach1[8]%></span></span>";
    			$('#itme-core-summary1').html(csie13);
    		}
    		if(csieSize2==3){
    			const csie21 = "2코어 <span class='tooltip'><img src='Images/item/<%=championSummaryItemEach2[1]%>' alt='img'><span class='tooltiptext tooltip-right'><b style='color:#ffc107;'><%=championSummaryItemEach2[0]%></b></br></br><%=championSummaryItemEach2[2]%></span></span>";
    			$('#item-core-summary2').html(csie21);
    		}else if(csieSize2==6) {
    			const csie22 = "2코어 <span class='tooltip'><img src='Images/item/<%=championSummaryItemEach2[1]%>' alt='img'><span class='tooltiptext tooltip-right'><b style='color:#ffc107;'><%=championSummaryItemEach2[0]%></b></br></br><%=championSummaryItemEach2[2]%></span></span> or <span class='tooltip'><img src='Images/item/<%=championSummaryItemEach2[4]%>' alt='img'><span class='tooltiptext tooltip-right'><b style='color:#ffc107;'><%=championSummaryItemEach2[3]%></b></br></br><%=championSummaryItemEach2[5]%></span></span>";
    			$('#itme-core-summary2').html(csie22);
    		}else if(csieSize2==9) {
    			const csie23 = "2코어 <span class='tooltip'><img src='Images/item/<%=championSummaryItemEach2[1]%>' alt='img'><span class='tooltiptext tooltip-right'><b style='color:#ffc107;'><%=championSummaryItemEach2[0]%></b></br></br><%=championSummaryItemEach2[2]%></span></span> or <span class='tooltip'><img src='Images/item/<%=championSummaryItemEach2[4]%>' alt='img'><span class='tooltiptext tooltip-right'><b style='color:#ffc107;'><%=championSummaryItemEach2[3]%></b></br></br><%=championSummaryItemEach2[5]%></span></span> or <span class='tooltip'><img src='Images/item/<%=championSummaryItemEach2[7]%>' alt='img'><span class='tooltiptext tooltip-right'><b style='color:#ffc107;'><%=championSummaryItemEach2[6]%></b></br></br><%=championSummaryItemEach2[8]%></span></span>";
    			$('#itme-core-summary2').html(csie23);
    		}
    		if(csieSize3==3){
    			const csie31 = "3코어 <span class='tooltip'><img src='Images/item/<%=championSummaryItemEach3[1]%>' alt='img'><span class='tooltiptext tooltip-right'><b style='color:#ffc107;'><%=championSummaryItemEach3[0]%></b></br></br><%=championSummaryItemEach3[2]%></span></span>";
    			$('#item-core-summary3').html(csie31);
    		}else if(csieSize3==6) {
    			const csie32 = "3코어 <span class='tooltip'><img src='Images/item/<%=championSummaryItemEach3[1]%>' alt='img'><span class='tooltiptext tooltip-right'><b style='color:#ffc107;'><%=championSummaryItemEach3[0]%></b></br></br><%=championSummaryItemEach3[2]%></span></span> or <span class='tooltip'><img src='Images/item/<%=championSummaryItemEach3[4]%>' alt='img'><span class='tooltiptext tooltip-right'><b style='color:#ffc107;'><%=championSummaryItemEach3[3]%></b></br></br><%=championSummaryItemEach3[5]%></span></span>";
    			$('#itme-core-summary3').html(csie32);
    		}else if(csieSize3==9) {
    			const csie33 = "3코어 <span class='tooltip'><img src='Images/item/<%=championSummaryItemEach3[1]%>' alt='img'><span class='tooltiptext tooltip-right'><b style='color:#ffc107;'><%=championSummaryItemEach3[0]%></b></br></br><%=championSummaryItemEach3[2]%></span></span> or <span class='tooltip'><img src='Images/item/<%=championSummaryItemEach3[4]%>' alt='img'><span class='tooltiptext tooltip-right'><b style='color:#ffc107;'><%=championSummaryItemEach3[3]%></b></br></br><%=championSummaryItemEach3[5]%></span></span> or <span class='tooltip'><img src='Images/item/<%=championSummaryItemEach3[7]%>' alt='img'><span class='tooltiptext tooltip-right'><b style='color:#ffc107;'><%=championSummaryItemEach3[6]%></b></br></br><%=championSummaryItemEach3[8]%></span></span>";
    			$('#itme-core-summary3').html(csie33);
    		}
    		<%
            for(int i=0; i<csylist.size(); i++) {
                	if(csylist.get(i).getSkill().equals("Q")) {
                		%>
               				$('#csylistQ').append("<div class='skill-box' style='background-color: #ffc030;'><%=i+1%></div>");
               				$('#csylistW').append("<div class='skill-box'><%=i+1%></div>");
               				$('#csylistE').append("<div class='skill-box'><%=i+1%></div>");
               				$('#csylistR').append("<div class='skill-box'><%=i+1%></div>");
               			<%
                	} else if(csylist.get(i).getSkill().equals("W")) {
                		%>
               				$('#csylistQ').append("<div class='skill-box'><%=i+1%></div>");
               				$('#csylistW').append("<div class='skill-box' style='background-color: #ffc030;'><%=i+1%></div>");
               				$('#csylistE').append("<div class='skill-box'><%=i+1%></div>");
               				$('#csylistR').append("<div class='skill-box'><%=i+1%></div>");
                		<%
                	} else if(csylist.get(i).getSkill().equals("E")) {
                		%>
               				$('#csylistQ').append("<div class='skill-box'><%=i+1%></div>");
               				$('#csylistW').append("<div class='skill-box'><%=i+1%></div>");
               				$('#csylistE').append("<div class='skill-box' style='background-color: #ffc030;'><%=i+1%></div>");
               				$('#csylistR').append("<div class='skill-box'><%=i+1%></div>");
                		<%
                	} else if(csylist.get(i).getSkill().equals("R")) {
                		%>
               				$('#csylistQ').append("<div class='skill-box'><%=i+1%></div>");
               				$('#csylistW').append("<div class='skill-box'><%=i+1%></div>");
               				$('#csylistE').append("<div class='skill-box'><%=i+1%></div>");
               				$('#csylistR').append("<div class='skill-box' style='background-color: #ffc030;'><%=i+1%></div>");
           				<% 
       				}
            	}
			%>
    	});
	</script>
</head>

<body class="statistics-main-body" style="height: auto;">
	<header class="header-mainnav">
		<div class="header-container">
			<a href="main/main.html"> <img src="Images/header-logo.webp"
				alt="LOL.PS">
			</a>
			<div class="nav-item-container">
				<a class="nav-items" href="notice/notice.html">공지사항</a> <a
					class="nav-items" href="rank/rank.html">챔피언 랭킹</a> <a
					class="nav-items" href="community/build.html">빌드게시판</a> <a
					class="nav-items" href="community/free.html">자유게시판</a>
			</div>
			<div class="sign-login">
				<a class="signin" href="member/signin.html">회원가입</a> <a
					class="login" href="member/login.html">로그인</a>
			</div>
		</div>
	</header>

	<div class="main"></div>

	<div class="main-content-container">
		<div class="menu-scroll">
			<div class="category">
				<div class="category-item">
					<a href="#yoyack" title="이건요약">요약</a> <a href="#counter">카운터</a> <a
						href="#spell-startitem">스펠,아이템</a> <a href="#coreitem">코어템</a> <a
						href="#skills">스킬</a> <a href="#runes">룬</a>
				</div>
			</div>
			<div class="container">
				<div class="line-and-input">
					<div class="select-line">
						<button class="line-button button-active"
							style="border-radius: 6px 0px 0px 6px;">
							<img src="Images/icon/line-top.png" alt="img" /> <span>탑</span> <span><%=championLineSelectPer[0]%>%</span>
						</button>
						<button class="line-button">
							<img src="Images/icon/line-jun.png" alt="img" /> <span>정글</span>
							<span><%=championLineSelectPer[1]%>%</span>
						</button>
						<button class="line-button">
							<img src="Images/icon/line-mid.png" alt="img" /> <span>미드</span>
							<span><%=championLineSelectPer[2]%>%</span>
						</button>
						<button class="line-button">
							<img src="Images/icon/line-bot.png" alt="img" /> <span>원딜</span>
							<span><%=championLineSelectPer[3]%>%</span>
						</button>
						<button class="line-button"
							style="border-radius: 0px 6px 6px 0px; border-right: none;">
							<img src="Images/icon/line-sup.png" alt="img" /> <span>서폿</span>
							<span><%=championLineSelectPer[4]%>%</span>
						</button>
					</div>
					<div class="input-box">
						<input class="main-input" type="text" placeholder="챔피언 이름을 입력하세요">
					</div>
					<div style="clear: both;"></div>
				</div>
			</div>
		</div>
		
		<div class="statistics-continer">
			<div class="champ-summary-header">
				<div class="champ-head">
					<div class="head">
						<img src="Images/champion/head/<%=championImg%>" alt="img" />
					</div>
					<h1 style="font-weight: 400; font-size: 38px; margin: 0; width: 100%; margin-top: 15px; margin-left: 190px;"><%=championName%></h1>
				</div>
				<div class="counter-champ">
                    <div class="counter-text">카운터</div>
                    <%
                    	for(int i=0; i<5; i++) {
                    %>
                    <div>
                        <img class="counter-img" src="Images/champion/head/<%=matchHard.get(i).getImage()%>" />
                        <span class="counter-rate"><%=matchHard.get(i).getWinRate()%>%</span>
                    </div>
                    <%
                    	}
                    %>
                </div>
				<button class="statistics-summary-button statistics-summary-button-active" >대중적인 빌드</button>
				<button class="statistics-summary-button" style="left: 33%;">고승률 빌드</button>
			</div>

			<div class="champ-summary" id="yoyack">
				<div class="rate-content">

					<div class="number-box">
						<div style="padding-top: 10px; width: 80px;">
							<div class="rate yellow">승률</div>
							<div class="rate"><%=championSummaryWin_rate%>%
							</div>
						</div>

						<div style="padding-top: 10px; width: 80px;">
							<div class="rate yellow">픽률</div>
							<div class="rate"><%=championSummaryPick_rate%>%
							</div>
						</div>

						<div style="padding-top: 10px; width: 80px;">
							<div class="rate yellow">벤율</div>
							<div class="rate"><%=championSummaryBan_rate%>%
							</div>
						</div>

						<div style="padding-top: 10px; width: 165px;">
							<div class="rate yellow">PS스코어</div>
							<div class="rate" style="color: #FFFFFFA6;">
								12.9 패치
								<%=championSummaryPsRankBefore%></div>
							<div class="rate">
								12.10 패치
								<%=championSummaryPsRankNow%></div>
						</div>
						<div style="padding-top: 10px; width: 140px;">
							<div class="rate yellow">챔피언순위</div>
							<div class="rate" style="color: #FFFFFFA6;">
								12.9
								<%=championSummaryRankingBefore%></div>
							<div class="rate">
								12.10
								<%=championSummaryRankingNow%></div>
						</div>
						<div
							style="padding-top: 10px; width: 230px; display: flex; flex-wrap: wrap;">
							<div class="rate yellow">주로 선택하는 포지션</div>
							<div class="rate" style="width: 33.3%;">
								<p><%=championLineHighNamePer[0]%></p>
								<span style="color: #FFFFFFA6;"><%=championLineHighNamePer[1]%>%</span>
							</div>
							<div class="rate" style="width: 33.3%;">
								<p><%=championLineHighNamePer[2]%></p>
								<span style="color: #FFFFFFA6;"><%=championLineHighNamePer[3]%>%</span>
							</div>
							<div class="rate" style="width: 33.3%;">
								<p><%=championLineHighNamePer[4]%></p>
								<span style="color: #FFFFFFA6;"><%=championLineHighNamePer[5]%>%</span>
							</div>
						</div>

					</div>
				</div>

				<div class="rune-item-skill-container">
					<div class="main-rune">
						<div class="rune-summary">
							<h4 style="margin: 0; color: #ae9056">메인룬</h4>
							<div class="rune-select" id="main-rune-1"
								style="margin-top: 5px;"></div>
							<div class="rune-select" id="main-rune-2"></div>
							<div class="rune-select" id="main-rune-3"></div>
							<div class="rune-select" id="main-rune-4"></div>
							<div class="rune-select" style="margin-top: 30px;">
								<span style="color: #FFFFFFA6; font-size: 12px;">승률 <span
									class="yellow"><%=championSummaryWin_rate%>%</span></span>
							</div>
							<div class="rune-select">
								<span style="color: #FFFFFFA6; font-size: 12px;">게임 수 <span
									class="yellow"><%=championSummaryCount%></span></span>
							</div>
						</div>
					</div>

					<div class="sub-rune">
						<div class="rune-summary">
							<h4 style="margin: 0; color: #ae9056">보조 룬</h4>
							
							<div class="rune-select" style="margin-top: 5px;">
								<div class='tooltip'>
									<img src="Images/rune/<%=championSummaryAssisRune[1]%>"
										alt="img" /> <span class='tooltiptext tooltip-right'><b
										style='color: #ffc107;'> <%=championSummaryAssisRune[0]%></b><br />
									<br /><%=championSummaryAssisRune[2]%> </span>
								</div>
								<div class='tooltip'>
									<img src="Images/rune/<%=championSummaryAssisRune[4]%>"
										alt="img" /> <span class='tooltiptext tooltip-right'><b
										style='color: #ffc107;'> <%=championSummaryAssisRune[3]%></b><br />
									<br /><%=championSummaryAssisRune[5]%> </span>
								</div>
								<div class='tooltip'>
									<img src="Images/rune/<%=championSummaryAssisRune[7]%>"
										alt="img" /> <span class='tooltiptext tooltip-right'><b
										style='color: #ffc107;'> <%=championSummaryAssisRune[6]%></b><br />
									<br /><%=championSummaryAssisRune[8]%> </span>
								</div>
							</div>
							
							<div class="rune-select">
								<div class='tooltip'>
									<img src="Images/rune/<%=championSummaryAssisRune[10]%>"
										alt="img" /> <span class='tooltiptext tooltip-right'><b
										style='color: #ffc107;'> <%=championSummaryAssisRune[9]%></b><br />
									<br /><%=championSummaryAssisRune[11]%> </span>
								</div>
								<div class='tooltip'>
									<img src="Images/rune/<%=championSummaryAssisRune[13]%>"
										alt="img" /> <span class='tooltiptext tooltip-right'><b
										style='color: #ffc107;'> <%=championSummaryAssisRune[12]%></b><br />
									<br /><%=championSummaryAssisRune[14]%> </span>
								</div>
								<div class='tooltip'>
									<img src="Images/rune/<%=championSummaryAssisRune[16]%>"
										alt="img" /> <span class='tooltiptext tooltip-right'><b
										style='color: #ffc107;'> <%=championSummaryAssisRune[15]%></b><br />
									<br /><%=championSummaryAssisRune[17]%> </span>
								</div>
							</div>
							
							<div class="rune-select">
								<div class='tooltip'>
									<img src="Images/rune/<%=championSummaryAssisRune[19]%>"
										alt="img" /> <span class='tooltiptext tooltip-right'><b
										style='color: #ffc107;'> <%=championSummaryAssisRune[18]%></b><br />
									<br /><%=championSummaryAssisRune[20]%> </span>
								</div>
								<div class='tooltip'>
									<img src="Images/rune/<%=championSummaryAssisRune[22]%>"
										alt="img" /> <span class='tooltiptext tooltip-right'><b
										style='color: #ffc107;'> <%=championSummaryAssisRune[21]%></b><br />
									<br /><%=championSummaryAssisRune[23]%> </span>
								</div>
								<div class='tooltip'>
									<img src="Images/rune/<%=championSummaryAssisRune[25]%>"
										alt="img" /> <span class='tooltiptext tooltip-right'><b
										style='color: #ffc107;'> <%=championSummaryAssisRune[24]%></b><br />
									<br /><%=championSummaryAssisRune[26]%> </span>
								</div>
							</div>

							<div style="padding-top: 30px;">
								<div class="rune-select">
									<img style="width: 25px; height: 25px"
										src="Images/rune/<%=championSummarySubRune[1]%>" alt="img" />
									<img style="width: 25px; height: 25px"
										src="Images/rune/<%=championSummarySubRune[3]%>" alt="img" />
									<img style="width: 25px; height: 25px"
										src="Images/rune/<%=championSummarySubRune[5]%>" alt="img" />
								</div>
								<div class="rune-select">
									<img style="width: 25px; height: 25px"
										src="Images/rune/<%=championSummarySubRune[7]%>" alt="img" />
									<img style="width: 25px; height: 25px"
										src="Images/rune/<%=championSummarySubRune[9]%>" alt="img" />
									<img style="width: 25px; height: 25px"
										src="Images/rune/<%=championSummarySubRune[11]%>" alt="img" />
								</div>
								<div class="rune-select">
									<img style="width: 25px; height: 25px"
										src="Images/rune/<%=championSummarySubRune[13]%>" alt="img" />
									<img style="width: 25px; height: 25px"
										src="Images/rune/<%=championSummarySubRune[15]%>" alt="img" />
									<img style="width: 25px; height: 25px"
										src="Images/rune/<%=championSummarySubRune[17]%>" alt="img" />
								</div>
							</div>
							
						</div>
					</div>

					<div class="item-skill-summary">
						<div class="item-core-summary">
							<div id="itme-core-summary1" class="item-core-summary-items">
								1코어</div>
							<div id="itme-core-summary2" class="item-core-summary-items">
								2코어</div>
							<div id="itme-core-summary3" class="item-core-summary-items">
								3코어</div>
						</div>

						<div class="skill-summary-container">
							<div class="skill-summary">
								<div class="skill-seq-row">
									<div class="skill-title">Q</div>
									<img style="width: 60px; margin-right: 4px;"
										src="Images/skill/<%=csilist.get(0).getQ()%>" alt="img" />
									<div id="csylistQ" style="display: flex;"></div>
								</div>

								<div class="skill-seq-row">
									<div class="skill-title">W</div>
									<img style="width: 60px; margin-right: 4px;"
										src="Images/skill/<%=csilist.get(0).getW()%>" alt="img" />
									<div id="csylistW" style="display: flex;"></div>
								</div>

								<div class="skill-seq-row">
									<div class="skill-title">E</div>
									<img style="width: 60px; margin-right: 4px;"
										src="Images/skill/<%=csilist.get(0).getE()%>" alt="img" />
									<div id="csylistE" style="display: flex;"></div>
								</div>

								<div class="skill-seq-row">
									<div class="skill-title">R</div>
									<img style="width: 60px; margin-right: 4px;"
										src="Images/skill/<%=csilist.get(0).getR()%>" alt="img" />
									<div id="csylistR" style="display: flex;"></div>
								</div>
							</div>
						</div>

						<div class="skill-mastar-summary">
							<div class="good-skill-master">
								<p>스킬 마스터 순서</p>
								<%
									for (int i = 0; i < 3; i++) {
								%>
								<span class='tooltip'> <img
									src='Images/skill/<%=gsmlist.get(i).getImage()%>' alt='img' />
									<span class='tooltiptext tooltip-right'> <b
										style='color: #ffc107;'><%=gsmlist.get(i).getName()%></b><br />
									<br /><%=gsmlist.get(i).getFunction()%>
								</span>
								</span>
								<%
									}
								%>
							</div>
							<div class="good-spell">
								<p>추천 스펠</p>
								<%
									for (int i = 0; i < reslist.size(); i++) {
								%>
								<span class='tooltip'> <img
									src='Images/spell/<%=reslist.get(i).getImage()%>' alt='img' />
									<span class='tooltiptext tooltip-right'> <b
										style='color: #ffc107;'><%=reslist.get(i).getName()%></b><br />
									<br /><%=reslist.get(i).getFunction()%>
								</span>
								</span>
								<%
									}
								%>
							</div>
							<div class="good-start-item">
								<p>시작아이템</p>
								<%
									for (int i = 0; i < stilist.size(); i++) {
										
								%>
								<span class='tooltip'> 
								<img src='Images/item/<%=stilist.get(i).getImage()%>' alt='img' /> <span
									class='tooltiptext tooltip-right'> <b
										style='color: #ffc107;'><%=stilist.get(i).getName()%></b><br />
									<br /><%=stilist.get(i).getFunction()%>
								</span>
								</span>
								<%
									}
								%>
							</div>
							<div class="good-shoes">
								<p>신발</p>
								<%
									for (int i = 0; i < shoeslist.size(); i++) {
								%>
								<span class='tooltip'> <img
									src='Images/item/<%=shoeslist.get(i).getImage()%>' alt='img' />
									<span class='tooltiptext tooltip-right'> <b
										style='color: #ffc107;'><%=shoeslist.get(i).getName()%></b><br />
									<br /><%=shoeslist.get(i).getFunction()%>
								</span>
								</span>
								<%
									}
								%>
							</div>
							<div class="good-core">
								<p>코어템</p>
								<%
									for (int i = 0; i < 1; i++) {
										if(coreCombine4.size()==0) {
											%>
												<span></span>
											<%
										} else {
								%>
								<span class='tooltip'> <img
									src='Images/item/<%=coreCombine4.get(i).getImage1()%>' alt='img' /> <span
									class='tooltiptext tooltip-right'> <b
										style='color: #ffc107;'><%=coreCombine4.get(i).getPick1()%></b><br />
									<br /><%=coreCombine4.get(i).getFunction1()%>
								</span>
								</span>
								<span class='tooltip'> <img
									src='Images/item/<%=coreCombine4.get(i).getImage2()%>' alt='img' /> <span
									class='tooltiptext tooltip-right'> <b
										style='color: #ffc107;'><%=coreCombine4.get(i).getPick2()%></b><br />
									<br /><%=coreCombine4.get(i).getFunction2()%>
								</span>
								</span>
								<span class='tooltip'> <img
									src='Images/item/<%=coreCombine4.get(i).getImage3()%>' alt='img' /> <span
									class='tooltiptext tooltip-right'> <b
										style='color: #ffc107;'><%=coreCombine4.get(i).getPick3()%></b><br />
									<br /><%=coreCombine4.get(i).getFunction3()%>
								</span>
								</span>
								<span class='tooltip'> <img
									src='Images/item/<%=coreCombine4.get(i).getImage4()%>' alt='img' /> <span
									class='tooltiptext tooltip-right'> <b
										style='color: #ffc107;'><%=coreCombine4.get(i).getPick4()%></b><br />
									<br /><%=coreCombine4.get(i).getFunction4()%>
								</span>
								</span>
								<%
										}
									}
								%>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>

		<div style="width: 100%; height: 400px;"></div>

		<div class="champ-nav">
			<a id="champ-nav1" class="champ-nav-items champ-nav-active">챔피언
				통계</a> <a id="champ-nav2" class="champ-nav-items">기본 정보</a> <a
				id="champ-nav3" class="champ-nav-items">패치 히스토리</a> <a
				id="champ-nav4" class="champ-nav-items">커뮤니티</a>
		</div>






		<!-- 기본정보 스킬 container -->
		<div id="loadContents">

			<div id="statistics">
				<div class="statistics-champ-match-container" id="counter">
					<div class="statistics-title">가렌 상대 챔피언</div>
					<div class="statistics-champ-match">
						<div id="match-hard" class="statistics-match-list">
							<h4>상대하기 어려움</h4>
							<%
								String isGray = "";
								for (int i = 0; i < matchHard.size(); i++) {
									if (i % 2 == 0) {
										isGray = "statistics-gray";
									} else {
										isGray = "";
									}
							%>
							<a class="statistics-hard-list <%=isGray%>" href="#"> <span
								style="width: 10%;"> <img
									src="Images/champion/head/<%=matchHard.get(i).getImage()%>"
									alt="img">
							</span> <span
								style="width: 60%; padding: 10px 0px 0px 20px; text-align: left;">
									<span><%=matchHard.get(i).getName()%></span>
							</span> <span style="width: 30%; padding-top: 10px;"> <span><%=matchHard.get(i).getCount()%>
										</span> <span class="statistics-hard"><%=matchHard.get(i).getWinRate()%>%</span>
							</span>
							</a>
							<%
								}
							%>

						</div>

						<div class="statistics-match-list">
							<h4>상대하기 쉬움</h4>
							<%
								isGray = "";
								for (int i = 0; i < matchEasy.size(); i++) {
									if (i % 2 == 0) {
										isGray = "statistics-gray";
									} else {
										isGray = "";
									}
							%>
							<a class="statistics-hard-list <%=isGray%>" href="#"> <span
								style="width: 10%;"> <img
									src="Images/champion/head/<%=matchEasy.get(i).getImage()%>"
									alt="img">
							</span> <span
								style="width: 60%; padding: 10px 0px 0px 20px; text-align: left;">
									<span><%=matchEasy.get(i).getName()%></span>
							</span> <span style="width: 30%; padding-top: 10px;"> <span><%=matchEasy.get(i).getCount()%>
										</span> <span class="statistics-easy"><%=matchEasy.get(i).getWinRate()%>%</span>
							</span>
							</a>
							<%
								}
							%>
						</div>
					</div>
				</div>

				<div class="statistics-content-container" id="spell-startitem">
					<div class="statistics-spell-items" id="spell-startitem">
						<div class="statistics-title">스펠, 아이템 선택</div>
						<div class="statistics-spell-item-content">
							<div class="statistics-spell-box">
								<h4 style="padding: 5px">스펠</h4>
								<div class="statistics-number">
									<span class="statistics-number-items">승률</span> <span
										class="statistics-number-items">선택률</span> <span
										class="statistics-number-items">카운트수</span>
								</div>
								<ul class="statistics-spell-list">
									<%
										isGray = "";
										for (int i = 0; i < selectSpell.size(); i++) {
											if (i % 2 == 0) {
												isGray = "statistics-gray";
											} else {
												isGray = "";
											}
									%>
									<li class="statistics-list-items <%=isGray%>">
										<div class="statistics-spell">
											<span class='tooltip'> <img
												src="Images/spell/<%=selectSpell.get(i).getPick1()%> "
												alt="img" /> <span class='tooltiptext tooltip-right'>
													<b style='color: #ffc107;'><%=selectSpell.get(i).getName1()%></b><br />
												<br /><%=selectSpell.get(i).getFunction1()%>
											</span>
											</span> <span class='tooltip'> <img
												src="Images/spell/<%=selectSpell.get(i).getPick2()%> "
												alt="img" /> <span class='tooltiptext tooltip-right'>
													<b style='color: #ffc107;'><%=selectSpell.get(i).getName2()%></b><br />
												<br /><%=selectSpell.get(i).getFunction2()%>
											</span>
											</span>
										</div>
										<div class="statistics-spell-percent">
											<span style="width: 23.3%;"><%=selectSpell.get(i).getWinRate()%></span>
											<span style="width: 23.3%;"><%=selectSpell.get(i).getPickRate()%></span>
											<span style="width: 23.3%;"><%=selectSpell.get(i).getCount()%></span>
										</div>
									</li>
									<%
										}
									%>
								</ul>
							</div>
							<div class="statistics-spell-box">
								<h4 style="padding: 5px">스타트 아이템</h4>
								<div class="statistics-number">
									<span class="statistics-number-items">승률</span> <span
										class="statistics-number-items">선택률</span> <span
										class="statistics-number-items">카운트수</span>
								</div>
								<ul class="statistics-spell-list">
									<%
                        	isGray = "";
                        	for(int i=0;i<selectStartItem.size();i++){
                        		if(i%2==0){
                            		isGray = "statistics-gray";
                            	}else{
                            		isGray = "";
                            	}
                        		
                        	%>
									<li class="statistics-list-items <%=isGray %>">
										<div class="statistics-spell">
											<span class='tooltip'> 
												<img src="Images/item/<%=selectStartItem.get(i).getPick1()%>"
												alt="img" /> <span class='tooltiptext tooltip-right'>
													<b style='color: #ffc107;'><%=selectStartItem.get(i).getName1()%></b><br />
												<br /><%=selectStartItem.get(i).getFunction1()%>
												</span>
											</span> 
											<%
											if(selectStartItem.get(i).getFunction2()==null){
												%>
												<span></span>
												<%
											}else{
											%>
											<span class='tooltip'> 
											<img src="Images/item/<%=selectStartItem.get(i).getPick2()%>"
												alt="img" /> 
												<span class='tooltiptext tooltip-right'>
													<b style='color: #ffc107;'><%=selectStartItem.get(i).getName2()%></b><br />
												<br /><%=selectStartItem.get(i).getFunction2()%>
											</span>
											</span>
											<%
											}
											%>
										</div>
										<div class="statistics-spell-percent">
											<span style="width: 23.3%;"><%=selectStartItem.get(i).getWinRate() %></span>
											<span style="width: 23.3%;"><%=selectStartItem.get(i).getPickRate() %></span>
											<span style="width: 23.3%;"><%=selectStartItem.get(i).getCount() %></span>
										</div>
									</li>
									<%
                        	}
                            %>
								</ul>
							</div>
							<div class="statistics-spell-box" style="border-right: none;">
								<h4 style="padding: 5px">신발</h4>
								<div class="statistics-number">
									<span class="statistics-number-items">승률</span> <span
										class="statistics-number-items">선택률</span> <span
										class="statistics-number-items">카운트수</span>
								</div>
								<ul class="statistics-spell-list">
									<%
                        	isGray = "";
                        	for(int i=0;i<selectShoes.size();i++){
                        		if(i%2==0){
                            		isGray = "statistics-gray";
                            	}else{
                            		isGray = "";
                            	}
                        	%>
									<li class="statistics-list-items <%=isGray %>">
										<div class="statistics-spell">
											<span class='tooltip'> <img
												src="Images/item/<%=selectShoes.get(i).getPick1()%>"
												alt="img" /> <span class='tooltiptext tooltip-right'>
													<b style='color: #ffc107;'><%=selectShoes.get(i).getName1()%></b><br />
												<br /><%=selectShoes.get(i).getFunction1()%>
											</span>
											</span>
										</div>
										<div class="statistics-spell-percent">
											<span style="width: 23.3%;"><%=selectShoes.get(i).getWinRate() %></span>
											<span style="width: 23.3%;"><%=selectShoes.get(i).getPickRate() %></span>
											<span style="width: 23.3%;"><%=selectShoes.get(i).getCount() %></span>
										</div>
									</li>
									<%
                        	}
                            %>
								</ul>
							</div>
						</div>
					</div>
				</div>

				<div class="statistics-content-container statistics-core-each"
					id="coreitem">
					<div class="statistics-spell-items">
						<div class="statistics-title">코어템 통계</div>
						<div class="statistics-spell-item-content">
							<div class="statistics-spell-box">

								<h4 style="padding: 5px">1코어</h4>

								<div class="statistics-number">
									<span class="statistics-number-items">승률</span> <span
										class="statistics-number-items">선택률</span> <span
										class="statistics-number-items">카운트수</span>
								</div>
								<ul class="statistics-spell-list">
									<%
                        	isGray = "";
                        	for(int i=0;i<core1.size();i++){
                        		if(i%2==0){
                            		isGray = "statistics-gray";
                            	}else{
                            		isGray = "";
                            	}
                        	%>
									<li class="statistics-list-items <%=isGray%>">
										<div class="statistics-spell">
											<span class='tooltip'> <img
												src="Images/item/<%=core1.get(i).getImage()%>" alt="img" />
												<span class='tooltiptext tooltip-right'> <b
													style='color: #ffc107;'><%=core1.get(i).getPick()%></b><br />
												<br /><%=core1.get(i).getFunction()%>
											</span>
											</span>
										</div>
										<div class="statistics-spell-percent">
											<span style="width: 23.3%;"><%=core1.get(i).getWinRate()%></span>
											<span style="width: 23.3%;"><%=core1.get(i).getPickRate()%></span>
											<span style="width: 23.3%;"><%=core1.get(i).getCount()%></span>
										</div>
									</li>
									<%
                        	}
                            %>
								</ul>
							</div>
							<div class="statistics-spell-box">

								<h4 style="padding: 5px">2코어</h4>

								<div class="statistics-number">
									<span class="statistics-number-items">승률</span> <span
										class="statistics-number-items">선택률</span> <span
										class="statistics-number-items">카운트수</span>
								</div>
								<ul class="statistics-spell-list">
									<%
                        	isGray = "";
                        	for(int i=0;i<core2.size();i++){
                        		if(i%2==0){
                            		isGray = "statistics-gray";
                            	}else{
                            		isGray = "";
                            	}
                        	%>
									<li class="statistics-list-items <%=isGray%>">
										<div class="statistics-spell">
											<span class='tooltip'> <img
												src="Images/item/<%=core2.get(i).getImage()%>" alt="img" />
												<span class='tooltiptext tooltip-right'> <b
													style='color: #ffc107;'><%=core2.get(i).getPick()%></b><br />
												<br /><%=core2.get(i).getFunction()%>
											</span>
											</span>
										</div>
										<div class="statistics-spell-percent">
											<span style="width: 23.3%;"><%=core2.get(i).getWinRate()%></span>
											<span style="width: 23.3%;"><%=core2.get(i).getPickRate()%></span>
											<span style="width: 23.3%;"><%=core2.get(i).getCount()%></span>
										</div>
									</li>
									<%
                        	}
                            %>
								</ul>
							</div>
							<div class="statistics-spell-box" style="border-right: none;">

								<h4 style="padding: 5px;">3코어</h4>

								<div class="statistics-number">
									<span class="statistics-number-items">승률</span> <span
										class="statistics-number-items">선택률</span> <span
										class="statistics-number-items">카운트수</span>
								</div>
								<ul class="statistics-spell-list">
							<%
                        	isGray = "";
                        	for(int i=0;i<core3.size();i++){
                        		if(i%2==0){
                            		isGray = "statistics-gray";
                            	}else{
                            		isGray = "";
                            	}
                        	%>
									<li class="statistics-list-items <%=isGray%>">
										<div class="statistics-spell">
											<span class='tooltip'> 
												<img src="Images/item/<%=core3.get(i).getImage()%>" alt="img" />
												<span class='tooltiptext tooltip-right'> 
													<b style='color: #ffc107;'><%=core3.get(i).getPick()%></b><br />
													<br /><%=core3.get(i).getFunction()%>
												</span>
											</span>
										</div>
										<div class="statistics-spell-percent">
											<span style="width: 23.3%;"><%=core3.get(i).getWinRate()%></span>
											<span style="width: 23.3%;"><%=core3.get(i).getPickRate()%></span>
											<span style="width: 23.3%;"><%=core3.get(i).getCount()%></span>
										</div>
									</li>
									<%
                            }
                            %>
								</ul>
							</div>
						</div>
					</div>
				</div>

				<div class="statistics-content-container statistics-core-combine">
					<div class="statistics-spell-items">
						<div class="statistics-title">코어템 조합 통계</div>
						<div class="statistics-spell-item-content">
							<div class="statistics-spell-box">
								<h4 style="padding: 5px">2코어 조합</h4>
								<div class="statistics-number">
									<span class="statistics-number-items">승률</span> <span
										class="statistics-number-items">선택률</span> <span
										class="statistics-number-items">카운트수</span>
								</div>

								<ul class="statistics-spell-list">
							<%
                        	isGray = "";
                        	for(int i=0;i<coreCombine2.size();i++){
                        		if(i%2==0){
                            		isGray = "statistics-gray";
                            	}else{
                            		isGray = "";
                            	}
                        	%>
									<li class="statistics-list-items <%=isGray%>">
										<div class="statistics-spell">
											<span class='tooltip'> 
												<img src="Images/item/<%=coreCombine2.get(i).getImage1()%>" alt="img" />
												<span class='tooltiptext tooltip-right'> 
													<b style='color: #ffc107;'><%=coreCombine2.get(i).getPick1()%></b><br />
													<br /><%=coreCombine2.get(i).getFunction1()%>
												</span>
											</span>
											<span class='tooltip'> 
												<img src="Images/item/<%=coreCombine2.get(i).getImage2()%>" alt="img" />
												<span class='tooltiptext tooltip-right'> 
													<b style='color: #ffc107;'><%=coreCombine2.get(i).getPick2()%></b><br />
													<br /><%=coreCombine2.get(i).getFunction2()%>
												</span>
											</span>
										</div>
										<div class="statistics-spell-percent">
											<span style="width: 23.3%;"><%=coreCombine2.get(i).getWinRate()%></span> 
											<span style="width: 23.3%;"><%=coreCombine2.get(i).getPickRate()%></span> 
											<span style="width: 23.3%;"><%=coreCombine2.get(i).getCount()%></span>
										</div>
									</li>
							<%
                        	}
							%>
								</ul>

							</div>
							<div class="statistics-spell-box">
								<h4 style="padding: 5px">3코어 조합</h4>
								<div class="statistics-number">
									<span class="statistics-number-items">승률</span> <span
										class="statistics-number-items">선택률</span> <span
										class="statistics-number-items">카운트수</span>
								</div>
								<ul class="statistics-spell-list">
								<%
	                        	isGray = "";
	                        	for(int i=0;i<coreCombine3.size();i++){
	                        		if(i%2==0){
	                            		isGray = "statistics-gray";
	                            	}else{
	                            		isGray = "";
	                            	}
	                        	%>
									<li class="statistics-list-items <%=isGray%>">
										<div class="statistics-spell">
											<span class='tooltip'> 
												<img src="Images/item/<%=coreCombine3.get(i).getImage1()%>" alt="img" />
												<span class='tooltiptext tooltip-right'> 
													<b style='color: #ffc107;'><%=coreCombine3.get(i).getPick1()%></b><br />
													<br /><%=coreCombine3.get(i).getFunction1()%>
												</span>
											</span>
											<span class='tooltip'> 
												<img src="Images/item/<%=coreCombine3.get(i).getImage2()%>" alt="img" />
												<span class='tooltiptext tooltip-right'> 
													<b style='color: #ffc107;'><%=coreCombine3.get(i).getPick2()%></b><br />
													<br /><%=coreCombine3.get(i).getFunction2()%>
												</span>
											</span>
											<span class='tooltip'> 
												<img src="Images/item/<%=coreCombine3.get(i).getImage3()%>" alt="img" />
												<span class='tooltiptext tooltip-right'> 
													<b style='color: #ffc107;'><%=coreCombine3.get(i).getPick3()%></b><br />
													<br /><%=coreCombine3.get(i).getFunction3()%>
												</span>
											</span>
										</div>
										<div class="statistics-spell-percent">
											<span style="width: 23.3%;"><%=coreCombine3.get(i).getWinRate()%></span> 
											<span style="width: 23.3%;"><%=coreCombine3.get(i).getPickRate()%></span> 
											<span style="width: 23.3%;"><%=coreCombine3.get(i).getCount()%></span>
										</div>
									</li>
								<%
	                        	}
								%>
								</ul>
							</div>
							<div class="statistics-spell-box" style="border-right: none;">
								<h4 style="padding: 5px;">4코어 조합</h4>
								<div class="statistics-number">
									<span class="statistics-number-items">승률</span> <span
										class="statistics-number-items">선택률</span> <span
										class="statistics-number-items">카운트수</span>
								</div>
								<ul class="statistics-spell-list">
								<%
	                        	isGray = "";
	                        	for(int i=0;i<coreCombine4.size();i++){
	                        		if(i%2==0){
	                            		isGray = "statistics-gray";
	                            	}else{
	                            		isGray = "";
	                            	}
	                        	%>
									<li class="statistics-list-items <%=isGray%>">
										<div class="statistics-spell">
											<span class='tooltip'> 
												<img src="Images/item/<%=coreCombine4.get(i).getImage1()%>" alt="img" />
												<span class='tooltiptext tooltip-right'> 
													<b style='color: #ffc107;'><%=coreCombine4.get(i).getPick1()%></b><br />
													<br /><%=coreCombine4.get(i).getFunction1()%>
												</span>
											</span>
											<span class='tooltip'> 
												<img src="Images/item/<%=coreCombine4.get(i).getImage2()%>" alt="img" />
												<span class='tooltiptext tooltip-right'> 
													<b style='color: #ffc107;'><%=coreCombine4.get(i).getPick2()%></b><br/>
													<br /><%=coreCombine4.get(i).getFunction2()%>
												</span>
											</span>
											<span class='tooltip'> 
												<img src="Images/item/<%=coreCombine4.get(i).getImage3()%>" alt="img" />
												<span class='tooltiptext tooltip-right'> 
													<b style='color: #ffc107;'><%=coreCombine4.get(i).getPick3()%></b><br/>
													<br /><%=coreCombine4.get(i).getFunction3()%>
												</span>
											</span>
											<span class='tooltip'> 
												<img src="Images/item/<%=coreCombine4.get(i).getImage4()%>" alt="img" />
												<span class='tooltiptext tooltip-right'> 
													<b style='color: #ffc107;'><%=coreCombine4.get(i).getPick4()%></b><br/>
													<br /><%=coreCombine4.get(i).getFunction4()%>
												</span>
											</span>
										</div>
										<div class="statistics-spell-percent">
											<span style="width: 23.3%;"><%=coreCombine4.get(i).getWinRate()%></span> 
											<span style="width: 23.3%;"><%=coreCombine4.get(i).getPickRate()%></span> 
											<span style="width: 23.3%;"><%=coreCombine4.get(i).getCount()%></span>
										</div>
									</li>
								<%
	                        	}
								%>
								</ul>
							</div>
						</div>
					</div>
				</div>

				<div class="statistics-content-container statistics-skill"
					id="skills">
					<div class="statistics-spell-items">
						<div class="statistics-title">스킬</div>
						<div class="statistics-spell-item-content">
							<div class="statistics-spell-box"
								style="border-right: none; width: 35%;">
								<h4 style="padding: 5px">마스터 순서</h4>
								<div class="statistics-number">
									<span class="statistics-number-items">승률</span> <span
										class="statistics-number-items">선택률</span> <span
										class="statistics-number-items">카운트수</span>
								</div>
								<ul class="statistics-spell-list">
								<%
								for(int i=0;i<skillMaster.size();i++){
									
								%>
									<li class="statistics-list-items statistics-border-bottom">
										<div class="statistics-spell">
											<span class='tooltip'> 
												<img src="Images/skill/<%=skillMaster.get(i).getImage1() %>" alt="img"/>
												<span class='tooltiptext tooltip-right'> 
													<b style='color: #ffc107;'><%=skillMaster.get(i).getPick1() %></b><br/>
													<br /><%=skillMaster.get(i).getFunction1()%>
												</span>
											</span>
											<span class='tooltip'> 
												<img src="Images/skill/<%=skillMaster.get(i).getImage2() %>" alt="img"/>
												<span class='tooltiptext tooltip-right'> 
													<b style='color: #ffc107;'><%=skillMaster.get(i).getPick2() %></b><br/>
													<br /><%=skillMaster.get(i).getFunction2()%>
												</span>
											</span>
											<span class='tooltip'> 
												<img src="Images/skill/<%=skillMaster.get(i).getImage3() %>" alt="img"/>
												<span class='tooltiptext tooltip-right'> 
													<b style='color: #ffc107;'><%=skillMaster.get(i).getPick3() %></b><br/>
													<br /><%=skillMaster.get(i).getFunction3()%>
												</span>
											</span>
										</div>
										<div class="statistics-spell-percent">
											<span style="width: 23.3%;"><%=skillMaster.get(i).getWinRate() %></span> 
											<span style="width: 23.3%;"><%=skillMaster.get(i).getPickRate() %></span> 
											<span style="width: 23.3%;"><%=skillMaster.get(i).getCount() %></span>
										</div>
									</li>
								<%
								}
								%>
								</ul>
							</div>
							<div class="statistics-spell-box"
								style="border-right: none; width: 65%; padding: 12px 12px;">

								<div class="statistics-what-level-container">
									<span class="statistics-what-level statistics-what-level-active" id="seq3">3레벨까지</span> 
									<span class="statistics-what-level" id="seq6">6레벨 까지</span> 
									<span class="statistics-what-level" id="seq11">11레벨 까지</span>
								</div>
								
								<div class="statistics-number">
									<span class="statistics-number-items">승률</span> <span
										class="statistics-number-items">선택률</span> <span
										class="statistics-number-items">카운트수</span>
								</div>
								<!--  3레벨 -->
								<div id="skill-seq">
									<ul class="statistics-spell-list2 statistics-display-block" id="skill-seq3">
										<%
										for(int i=0;i<skillSeq3.size();i++){
										%>
										<li class="statistics-list-items statistics-border-bottom">
											<div class="statistics-spell">
												<span class='tooltip'> 
													<img src="Images/skill/<%=skillSeq3.get(i).getImage1() %>" alt="img"/>
													<span class='tooltiptext tooltip-right'> 
														<b style='color: #ffc107;'><%=skillSeq3.get(i).getPick1() %></b><br/>
														<br /><%=skillSeq3.get(i).getFunction1() %>
													</span>
												</span> 
												<span class='tooltip'> 
													<img src="Images/skill/<%=skillSeq3.get(i).getImage2() %>" alt="img"/>
													<span class='tooltiptext tooltip-right'> 
														<b style='color: #ffc107;'><%=skillSeq3.get(i).getPick2() %></b><br/>
														<br /><%=skillSeq3.get(i).getFunction2() %>
													</span>
												</span> 
												<span class='tooltip'> 
													<img src="Images/skill/<%=skillSeq3.get(i).getImage3() %>" alt="img"/>
													<span class='tooltiptext tooltip-right'> 
														<b style='color: #ffc107;'><%=skillSeq3.get(i).getPick3() %></b><br/>
														<br /><%=skillSeq3.get(i).getFunction3() %>
													</span>
												</span> 
											</div>
											<div class="statistics-spell-percent" style="width: 40%;">
												<span style="width: 23.3%;"><%=skillSeq3.get(i).getWinRate() %></span> 
												<span style="width: 23.3%;"><%=skillSeq3.get(i).getPickRate() %></span> 
												<span style="width: 23.3%;"><%=skillSeq3.get(i).getCount() %></span>
											</div>
										</li>
										<%
										}
										%>
									</ul>
									</div>
									
							</div>
						</div>
					</div>
				</div>

				<div class="statistics-content-container statistics-rune" id="runes">
					<div class="statistics-spell-items">
						<div class="statistics-title">룬</div>
						<div class="statistics-spell-item-content">
							<div class="statistics-spell-box"
								style="width: 60%; padding: 15px;">
								<h4 style="padding: 5px">조합별 통계</h4>
								<div class="statistics-number">
									<span class="statistics-number-items">승률</span> 
									<span class="statistics-number-items">선택률</span> 
								</div>
								<ul class="statistics-spell-list">
									<%
		                        	isGray = "";
		                        	for(int i=0;i<runeCombine.size();i++){
		                        		if(i%2==0){
		                            		isGray = "statistics-gray";
		                            	}else{
		                            		isGray = "";
		                            	}
	                        		%>
									<li class="statistics-list-items <%=isGray%>">
										<div class="statistics-spell">
											<span class='tooltip'> 
												<img src="Images/rune/<%=runeCombine.get(i).getImage1() %>" alt="img"> 
												<span class='tooltiptext tooltip-right'> 
													<b style='color: #ffc107;'><%=runeCombine.get(i).getPick1() %></b><br/>
													<br /><%=runeCombine.get(i).getFunction1() %>
												</span>
											</span>
											<span class='tooltip'> 
												<img src="Images/rune/<%=runeCombine.get(i).getImage2() %>" alt="img"> 
												<span class='tooltiptext tooltip-right'> 
													<b style='color: #ffc107;'><%=runeCombine.get(i).getPick2() %></b><br/>
													<br /><%=runeCombine.get(i).getFunction2() %>
												</span>
											</span>
											<span class='tooltip'> 
												<img src="Images/rune/<%=runeCombine.get(i).getImage3() %>" alt="img"> 
												<span class='tooltiptext tooltip-right'> 
													<b style='color: #ffc107;'><%=runeCombine.get(i).getPick3() %></b><br/>
													<br /><%=runeCombine.get(i).getFunction3() %>
												</span>
											</span>
											<span class='tooltip'> 
												<img src="Images/rune/<%=runeCombine.get(i).getImage4() %>" alt="img"> 
												<span class='tooltiptext tooltip-right'> 
													<b style='color: #ffc107;'><%=runeCombine.get(i).getPick4() %></b><br/>
													<br /><%=runeCombine.get(i).getFunction4() %>
												</span>
											</span>
											<span class='tooltip'> 
												<img src="Images/rune/<%=runeCombine.get(i).getImage5() %>" alt="img"> 
												<span class='tooltiptext tooltip-right'> 
													<b style='color: #ffc107;'><%=runeCombine.get(i).getPick5() %></b><br/>
													<br /><%=runeCombine.get(i).getFunction5() %>
												</span>
											</span>
											<span class='tooltip'> 
												<img src="Images/rune/<%=runeCombine.get(i).getImage6() %>" alt="img"> 
												<span class='tooltiptext tooltip-right'> 
													<b style='color: #ffc107;'><%=runeCombine.get(i).getPick6() %></b><br/>
													<br /><%=runeCombine.get(i).getFunction6() %>
												</span>
											</span>
										</div>
										<div class="statistics-spell-percent" style="width: 45%;">
											<span style="width: 23.3%;"><%=runeCombine.get(i).getWinRate() %></span> 
											<span style="width: 23.3%;"><%=runeCombine.get(i).getPickRate() %></span> 
										</div>
									</li>
									<%
		                        	}
									%>
								</ul>
							</div>
							<div class="statistics-spell-box"
								style="border-right: none; width: 40%; padding: 15px;">
								<h4 style="padding: 5px">파편 조합 통계</h4>
								<div class="statistics-number">
									<span class="statistics-number-items">승률</span> 
									<span class="statistics-number-items">선택률</span> 
								</div>
								<ul class="statistics-spell-list">
									<%
		                        	isGray = "";
		                        	for(int i=0;i<runeShard.size();i++){
		                        		if(i%2==0){
		                            		isGray = "statistics-gray";
		                            	}else{
		                            		isGray = "";
		                            	}
	                        		%>
									<li class="statistics-list-items <%=isGray%>">
										<div class="statistics-spell">
											<span class='tooltip'> 
												<img src="Images/rune/<%=runeShard.get(i).getImage1() %>" alt="img"> 
												<span class='tooltiptext tooltip-right'> 
													<b style='color: #ffc107;'>공격</b><br/>
													<br /><%=runeShard.get(i).getPick1() %>
												</span>
											</span>
											<span class='tooltip'> 
												<img src="Images/rune/<%=runeShard.get(i).getImage2() %>" alt="img"> 
												<span class='tooltiptext tooltip-right'> 
													<b style='color: #ffc107;'>유연</b><br/>
													<br /><%=runeShard.get(i).getPick2() %>
												</span>
											</span>
											<span class='tooltip'> 
												<img src="Images/rune/<%=runeShard.get(i).getImage3() %>" alt="img"> 
												<span class='tooltiptext tooltip-right'> 
													<b style='color: #ffc107;'>방어</b><br/>
													<br /><%=runeShard.get(i).getPick3() %>
												</span>
											</span>
										</div>
										<div class="statistics-spell-percent">
											<span style="width: 23.3%;"><%=runeShard.get(i).getWinRate() %></span> 
											<span style="width: 23.3%;"><%=runeShard.get(i).getPickRate() %></span> 
										</div>
									</li>
									<%
		                        	}
									%>
								</ul>
							</div>
						</div>
					</div>
				</div>
				
			</div>
			
		</div>

	</div>
	<!--  이거 지우면 깨지니까 지우지 말자 -->





	<div class="top-button">
		<span style="color: #6c757d;">UP</span>
	</div>


	<footer class="footer">

		<div class="footer-left">
			<span class="footer-left-item">공지사항</span> <span
				class="footer-left-item">버그리포팅</span> <span class="footer-left-item">파트너
				신청</span></br>
			<div style="margin-bottom: 10px;"></div>
			<span class="footer-left-item">이용약관</span> <span
				class="footer-left-item">개인정보처리방침</span>
		</div>
	
		<div class="footer-right">
			<h5>PS Analytics, Inc. © 2020</h5>
			<p>lol.ps is hosted by PS Analytics, Inc. lol.ps isn’t endorsed
				by Riot Games and doesn’t reflect the views or opinions of Riot
				Games or anyone officially involved in producing or managing League
				of Legends. League of Legends and Riot Games are trademarks or
				registered trademarks of Riot Games, Inc. League of Legends © Riot
				Games, Inc.</p>
		</div>

	</footer>
	<script src="https://unpkg.com/swiper@8/swiper-bundle.min.js"></script>
	<script src="Js/all.js"></script>
</body>
</html>