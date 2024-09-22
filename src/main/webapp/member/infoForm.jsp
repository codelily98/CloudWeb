<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.List" %>
<%@ page import="member.dto.MemberDTO" %>
<%@ page import="member.dao.MemberDAO" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>구름: 회원정보</title>
    <link rel="stylesheet" type="text/css" href="../css/infoForm.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.7.3/dist/sweetalert2.min.css">
</head>
<body>
<c:set var="context" value="${pageContext.request.contextPath}"/>
    <div id="headerwrap">
        <div id="header">
            <div id="topnav">
                <div id="topawrap">
                    <c:choose>
                        <c:when test="${sessionScope.memId != null}">
                            <a href="${context}/member/logout.do">로그아웃</a> |
                            <a href="${context}/member/infoForm.do">회원정보</a> |
                            <a href="${context}/index.do">홈</a>
                        </c:when>
                        <c:otherwise>
                            <a id="login-link" href="#">로그인</a> |
                            <a href="${context}/index.do">홈</a>
                        </c:otherwise>
                    </c:choose>
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
    </div>
    
    <div id="wrap">
        <div id="container">
            <div id="topcontent">
                <c:choose>
                    <c:when test="${sessionScope.memId != null}">
                        <div id="userinfo">
                            <form id="updateForm">
                                <c:set var="memberDTO" value="${list[0]}"/>
                                <div id="inputwrap">
                                    <div id="inputid">
                                        <input type="text" id="id" name="id" placeholder="아이디" required maxlength="15" readonly value="${memberDTO.id}">
                                    </div>
                                    <div id="inputpwd">
                                        <input type="password" id="pwd" name="pwd" placeholder="비밀번호" required>
                                    </div>
                                    <div id="inputrepwd">
                                        <input type="password" id="repwd" name="repwd" placeholder="비밀번호 재입력" required>
                                    </div>
                                    <div id="inputname">
                                        <input type="text" id="name" name="name" placeholder="이름" required value="${memberDTO.name}">
                                    </div>
                                    <div id="checkinput"></div>
                                    <div id="inputgender">
                                        <label>
                                            <input type="radio" name="gender" value="M" ${memberDTO.gender == 'M' ? 'checked' : ''}/>
                                            <div class="radio-btn">남자</div>
                                        </label>
                                        <label>
                                            <input type="radio" name="gender" value="F" ${memberDTO.gender == 'F' ? 'checked' : ''}/>
                                            <div class="radio-btn">여자</div>
                                        </label>
                                    </div>
                                    <div id="inputemail">
                                        <input type="email" id="email1" name="email1" placeholder="이메일 아이디" value="${memberDTO.email1}"/><span>@</span>
                                        <input type="email" id="email2" name="email2" placeholder="이메일 주소" value="${memberDTO.email2}"/>
                                        <input id="email3" type="email" name="email3" list="email3_list">
                                        <datalist id="email3_list">
                                            <option value="직접입력"/>
                                            <option value="naver.com"/>
                                            <option value="hanmail.net"/>               
                                            <option value="gmail.com"/>
                                        </datalist>
                                    </div>
                                    <div id="inputtel">
                                        <select id="tel1" name="tel1">
                                            <option value="010" ${memberDTO.tel1 == '010' ? 'selected' : ''}>010</option>
                                            <option value="011" ${memberDTO.tel1 == '011' ? 'selected' : ''}>011</option>
                                            <option value="016" ${memberDTO.tel1 == '016' ? 'selected' : ''}>016</option>
                                        </select><span>-</span> 
                                        <input id="tel2" type="text" name="tel2" maxlength="4" placeholder="0000" value="${memberDTO.tel2}"/><span>-</span> 
                                        <input id="tel3" type="text" name="tel3" maxlength="4" placeholder="0000" value="${memberDTO.tel3}"/>
                                    </div>
                                    <div id="inputaddr">
                                        <div id="zipcode-container">
                                            <input type="text" id="zipcode" name="zipcode" placeholder="우편번호" value="${memberDTO.zipcode}">
                                            <button type="button">우편번호 검색</button>
                                        </div>
                                        <input type="text" id="addr1" name="addr1" size="60" placeholder="주소" value="${memberDTO.addr1}"/><br/>
                                        <input type="text" id="addr2" name="addr2" size="60" placeholder="상세주소" value="${memberDTO.addr2}"/>
                                    </div>
                                </div>
                                <div id="btnwrap">
                                    <input type="button" id="updatebtn" value="회원정보수정">
                                    <input type="button" id="resetbtn" value="다시입력">
                                </div>
                                <div id="btnwrap">
                                    <input type="button" id="deletebtn" value="회원정보삭제">
                                </div>
                            </form>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div id="noid">
                            <a href="../index.jsp">로그인이 필요합니다.</a>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>  
        </div>
    </div>
    
    <div id="footer">
        <div id="copyligth">
            나는 카피라이트
        </div>
    </div>

    <script type="text/javascript" src="http://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script src="../js/update.js"></script>
</body>
</html>
