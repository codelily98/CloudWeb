<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>구름: 글 작성</title>
<link rel="stylesheet" type="text/css" href="../css/communityWriteForm.css">
</head>
<body>
<c:set var="context" value="${pageContext.request.contextPath}"/>
<div id="headerwrap">
    <div id="header">
        <div id="topnav">
            <div id="topawrap">
                <c:if test="${sessionScope.memId != null}">
                    <a href="${context}/community/writeForm.do">글작성</a> |
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
                <img src="../image/logo.png" alt="logo" onclick="location.href='${context}/index.do'">
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
                <div id="writeFormWrap">
                    <h2>글 작성</h2>
                    <form action="${context}/community/write.do" method="post">
					    <div class="form-group">
					        <label for="subject">제목:</label>
					        <input type="text" id="subject" name="subject" placeholder="제목 입력" required>
					    </div>
					    <div class="form-group">
					        <label for="content">내용:</label>
					        <textarea id="content" name="content" rows="10" placeholder="내용 입력" required></textarea>
					    </div>
					    <div class="form-group">
						    <label for="file">사진 첨부:</label>
						    <!-- onchange 이벤트 추가 -->
						    <input type="file" id="file" name="file" accept="image/*" onchange="previewImage(event)">
						</div>
					    <!-- 미리보기 영역 -->
					    <div id="imagePreview" style="margin-top: 10px;">
					        <img id="preview" src="#" alt="이미지 미리보기" style="display: none; max-width: 300px; max-height: 300px;">
					    </div>
					    <input type="submit" value="작성하기">
					    <a href="${context}/community/communityMain.do" class="cancel-button">취소</a>
					</form>
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
<!-- 이미지 미리보기 기능을 위한 JavaScript -->
<script>
function previewImage(event) {
    const reader = new FileReader();
    reader.onload = function() {
        const preview = document.getElementById('preview');
        preview.src = reader.result;
        preview.style.display = 'block'; // 이미지를 보이게 설정
    };
    reader.readAsDataURL(event.target.files[0]); // 선택한 파일을 읽어서 미리보기
}
</script>
</body>
</html>
