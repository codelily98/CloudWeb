<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>구름: 로그인</title>
<link rel="stylesheet" type="text/css" href="../css/loginForm.css">
</head>
<body>
<form id="loginForm">
	<div id="wrap">
		<div id="logo">
			<img src="../image/logo.png" alt="logo">
			<h2>구름</h2>
		</div>
		<div id="loginwrap">
			<div id="inputwrap">
				<div id="inwrap">
					<input type="text" id="id" name="id" placeholder="아이디" maxlength="15" required="required">
				</div>
				<div id="pwdwrap">
					<input type="password" id="pwd" name="pwd" placeholder="비밀번호" required="required">
				</div>
				<div id="checkinfo"></div>
				<div id="btnwrap">
					<input type="button" id="loginbtn" value="로그인">
				</div>
				<div id="locationa">
					<a href="#">아이디 찾기</a> |
					<a href="#">비밀번호 찾기</a> |
					<a href="./joinForm.jsp">회원가입</a>
				</div>
			</div>
		</div>
	</div>
</form>
<script type="text/javascript" src="http://code.jquery.com/jquery-3.7.1.min.js"></script>
<script type="text/javascript">
$(function(){
	// 홈페이지로 돌아가는 함수
	$("img[alt='logo']").click(function(){
		location.href="../index.jsp";
	});
	
	// 로그인 버튼 클릭 시 전체 폼을 검사
    $('#loginbtn').on('click', function(e) {
        e.preventDefault(); // 기본 폼 제출 동작 방지

        // 오류가 없는 경우 AJAX 요청으로 데이터 전송
        if ($("#pwd").val() != '' && $("#id").val() != '') {
            // 폼 데이터 수집
            const formData = $('#loginForm').serialize();
			
            console.log(formData);
            
            $.ajax({
                url: './login.jsp',  // 서버의 회원가입 처리 URL
                method: 'POST',
                data: formData,
                success: function(data) {
                	let result = data.trim();
                	console.log(result);
                	
                    if (result != 'err') {
						// 로그인 성공 시 id, name, email 값을 받아 처리
                        let resultArray = result.split("|");
                        let id = resultArray[0];
                        let name = resultArray[1];
                        let email = resultArray[2];
                        alert(id + '님 환영합니다.');
                        
                        window.location.href = '../index.jsp';
                    } else {
                        alert('로그인에 실패했습니다. 다시 시도해 주세요.');
                    }
                },
                error: function(e) {
                	console.log(e);
                    alert('서버와의 통신에 실패했습니다. 나중에 다시 시도해 주세요.');
                }
            });
        } else {
        	alert("아이디와 비밀번호를 입력하세요.");
        }
    });
});
</script>
</body>
</html>