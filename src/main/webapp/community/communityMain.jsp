<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>구름: 홈</title>
<link rel="stylesheet" type="text/css" href="../css/communityMain.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.7.3/dist/sweetalert2.min.css">
</head>
<body>
<c:set var="context" value="${pageContext.request.contextPath}"/>
	<div id="headerwrap">
		<div id="header">
			<div id="topnav">
				<div id="topawrap">
					<c:if test="${sessionScope.memId != null}">
						<a href="${context}/community/writeForm.do">글쓰기</a> |
						<a href="${context}/member/logout.do">로그아웃</a> |
						<a href="${context}/member/infoForm.do">회원정보</a> |
						<a href="${context}/index.do">홈</a>
					</c:if>
					<c:if test="${sessionScope.memId == null}">
					    <a id="login-link" href="#">로그인</a> |
						<a href="${context}/index.do">홈</a>
					</c:if>
				</div>
			</div>
			<div id="logowrap">
				<div id="logo">
					<img src="../image/logo.png" alt="logo">
					<br/><span>구름</span>
				</div>
			</div>
			<div id="menunav">
				<ul>
					<li><a href="#">여행지정보</a></li>
					<li><a href="${context}/community/communityMain.do">커뮤니티</a></li>
					<li><a href="#">일정관리</a></li>
				</ul> 
			</div>
		</div>
		
	<div id="wrap">
	    <div id="container">
	        <div id="topcontent">
	            <div id="dogIM">
	                <div id="slideimg">
	                    <img id="slide" src="../image/rich1.jpg" alt="slideimg">
	                </div>
	            </div>
	            <div id="loginwrap">
					<div id="userinfo">
						<div id="insertinfo">
							<c:if test="${sessionScope.memId != null}">
                                    <span id="inserid"><c:forEach var="memberDTO" items="${list}">${memberDTO.id} (${memberDTO.name})님</c:forEach></span>
                                    </div>
                                    <div id="userbtn">
                            			<div id="loginwrapmenu">
                            				<a href="${context}/community/communityWriteForm.do">&nbsp;글쓰기&nbsp;</a>|
		                            		<a href="#">&nbsp;글목록&nbsp;</a>|
		                            		<a href="#">&nbsp;내게시글&nbsp;</a>|
		                            		<a href="${context}/member/infoForm.do">&nbsp;회원정보&nbsp;</a>
                            			</div>
	                                	<input type="button" id="logoutbtn" value="로그아웃" onclick="location.href='${context}/member/logout.do'">
									</div>  
							</c:if>
							<c:if test="${sessionScope.memId == null}">
								<span id="inserid">로그인이 필요합니다.</span>
                                </div>
								<div id="userbtn">
									<input type="button" id="loginbtn1" value="로그인">
									<div id="loginawrap">
										<a class="seachId">아이디 찾기</a>|<a class="seachPwd">비밀번호 찾기</a>|<a href="${context}/member/joinForm.do">회원가입</a>
									</div>
								</div>
							</c:if>
					</div>
				</div>
			</div>
			<div id="maincontent">
				<div id="boardselect">
					<div id="listheader">
						<span id="listtitle" class="title">게시판</span>
					</div>
					<div id="list">
						<ul>
							<li>전체글</li>
							<li>인기글</li>
							<li>최신글</li>
						</ul>
					</div>
				</div>
				<div id="boardlist">
					<div id="postlistheader">
						<div id="posttitle" class="title">게시글</div>
						<div id="write_link">&lt; <a href="./communityWriteForm.do">글쓰기</a> &gt;</div>
					</div>					
					<div id="postlist">
						<table width="100%">
							<tr>
								<td width="10%"><span>번호</span></td>
								<td width="42%"><span>제목</span></td>
								<td width="13%"><span>작성자</span></td>
								<td width="20%"><span>작성일</span></td>
								<td width="10%"><span>조회수</span></td>
							</tr>
							<tr>
								<td width="10%"><span>1</span></td>
								<td width="42%"><span>리치 귀여워</span></td>
								<td width="13%"><span>codelily</span></td>
								<td width="20%"><span>2024.09.14 14:32:12</span></td>
								<td width="10%"><span>132</span></td>
							</tr>
							<tr>
								<td width="10%"><span>2</span></td>
								<td width="42%"><span>리치 사진</span></td>
								<td width="13%"><span>user</span></td>
								<td width="20%"><span>2024.09.12 11:23:41</span></td>
								<td width="10%"><span>222</span></td>
							</tr>
						</table>
					</div>
				</div>
			</div>
		</div>
    </div>
	    
	    <div id="footer">
	        <div id="copyligth">
	            나는 카피라이트
	        </div>
	    </div>
	</div>
<script type="text/javascript" src="http://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script src="../js/communityMain.js"></script>
</body>
</html>
