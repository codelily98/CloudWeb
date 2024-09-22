<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>구름: 회원가입</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.7.3/dist/sweetalert2.min.css">
<link rel="stylesheet" type="text/css" href="../css/joinForm.css">
</head>
<body>
<form id="joinForm">
<c:set var="context" value="${pageContext.request.contextPath}"/>
	<div id="wrap">
		<div id="logo">
			<img src="../image/logo.png" alt="logo">
			<h2>구름</h2>
		</div>
		<div id="inputwrap">
			<div id="inputid">
				<input type="text" id="id" name="id" placeholder="아이디" required="required" maxlength="15">
			</div>
			<div id="inputpwd">
				<input type="password" id="pwd" name="pwd" placeholder="비밀번호" required="required">
			</div>
			<div id="inputrepwd">
				<input type="password" id="repwd" name="repwd" placeholder="비밀번호 재입력" required="required">
			</div>
			<div id="inputname">
				<input type="text" id="name" name="name" placeholder="이름" required="required">
			</div>
			<div id="checkinput"></div>
			<div id="inputgender">
				<label>
				    <input type="radio" name="gender" value="M"/>
				    <div class="radio-btn">남자</div>
				</label>
				<label>
				    <input type="radio" name="gender" value="F"/>
				    <div class="radio-btn">여자</div>
				</label>
			</div>
			<div id="inputemail">
				<input type="email" id="email1" name="email1" placeholder="이메일 아이디" required="required"><span>@</span>
				<input type="email" id="email2" name="email2" placeholder="이메일 주소" required="required">
	            <select id="email3" name="email3">
					<option value="">이메일 선택</option> <!-- 기본값으로 '이메일 선택' 추가 -->
					<option value="직접입력">직접입력</option>
					<option value="naver.com">naver.com</option>
					<option value="hanmail.net">hanmail.net</option>
					<option value="gmail.com">gmail.com</option>
				</select>
			</div>
			<div id="inputtel">
				<select id="tel1" name="tel1">
		            <option value="010">010</option>
		            <option value="011">011</option>
		            <option value="016">016</option>
		         </select><span>-</span> 
		         <input id="tel2" type="text" name="tel2" maxlength="4" placeholder="0000"/><span>-</span> 
		         <input id="tel3" type="text" name="tel3" maxlength="4" placeholder="0000"/>
			</div>
			<div id="inputaddr">
				<div id="zipcode-container">
			        <input type="text" id="zipcode" name="zipcode" placeholder="우편번호">
			        <button type="button" id="zipcodeSearch">우편번호 검색</button>
			    </div>
	            <input type="text" id="addr1" name="addr1" size="60" placeholder="주소"/><br/>
	            <input type="text" id="addr2" name="addr2" size="60" placeholder="상세주소"/>
			</div>
			<div id="btnwrap">
				<input type="button" value="회원가입" id="writebtn"/>
	            <input type="reset" value="다시입력" />
			</div>
		</div>
	</div>
</form>
<script type="text/javascript" src="http://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script src="../js/join.js"></script>
</body>
</html>