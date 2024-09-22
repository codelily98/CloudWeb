<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>구름: 홈</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.7.3/dist/sweetalert2.min.css">
<link rel="stylesheet" type="text/css" href="./css/index.css">
</head>
<body>
<c:set var="context" value="${pageContext.request.contextPath}"/>
	<div id="headerwrap">
		<div id="header">
			<div id="topnav">
				<div id="topawrap">
					<c:if test="${sessionScope.memId != null}">
						<a href="${context}/community/communityWriteForm.do">글쓰기</a> |
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
				<img src="./image/logo.png" alt="logo">
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
	                    <img id="slide" src="./image/rich1.jpg" alt="slideimg">
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
								<a href="#">여행지 정보</a>|
								<a href="${context}/community/communityMain.do">커뮤니티</a>|
								<a href="#">일정관리</a>|
								<a href="${context}/member/infoForm.do">회원정보</a>
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
				<div id="hotboard">
					인기글
				</div>
				<div id="currentboard">
					최신글
				</div>
			</div>
		</div>
    </div>
	    
    <div id="footer">
        <div id="copyligth">
            &copy; 구름 2024
        </div>
    </div>
	</div>
<script type="text/javascript" src="http://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script src="./js/index.js"></script>
</body>
</html>
