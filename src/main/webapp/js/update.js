$(document).ready(function() {
	// 페이지 새로 고침으로 입력 정보 초기화
	$("#resetbtn").click(function(){
		window.location.href = "./infoForm.do";
	});
	
	// 로고 클릭 시 홈으로 이동
	$("img[alt='logo']").click(function(){
		window.location.href = "../index.do";
	});
	
	// 로그인 링크 클릭 시 #loginbtn1 버튼 클릭 이벤트 트리거
    $("#login-link").click(function(e) {
        e.preventDefault(); // 기본 링크 동작 방지
		location.href="../index.do"
        $("#loginbtn1").click(); // #loginbtn1 클릭 이벤트 발생
    });
	
	// 특정 필드를 검사하고, 오류 메시지를 #checkinput에 추가하는 함수
    function validateField(field) {
        const id = $(field).attr('id');
        const value = $(field).val().trim();
        let message = '';

        // 필수 입력란만 검사
        if ($(field).prop('required')) {
            // 필드 값이 비어있는 경우 메시지 설정 및 포커스 이동
            if (value === '') {
                if (id === 'id') {
                    message = '아이디는 필수 입력란입니다.';
                } else if (id === 'pwd') {
                    message = '비밀번호는 필수 입력란입니다.';
                } else if (id === 'repwd') {
                    message = '비밀번호 확인은 필수 입력란입니다.';
                } else if (id === 'name') {
                    message = '이름은 필수 입력란입니다.';
                }
                // 이미 메시지가 있는지 확인
                if (!$(field).data('has-error')) {
                    // 메시지를 #checkinput에 추가
                    $('#checkinput').append(`<li data-field="${id}">${message}</li>`);
                    // 해당 필드에 포커스 이동
                    $(field).focus();
                    // 필드에 오류가 있음을 기록
                    $(field).data('has-error', true);
                }
            } else if (id === 'repwd') { // 비밀번호 재입력 검사
                const pwdValue = $('#pwd').val().trim();
                if (value !== pwdValue) {
                    message = '비밀번호가 일치하지 않습니다.';
                    // 이미 메시지가 있는지 확인
                    if (!$(field).data('has-error')) {
                        // 메시지를 #checkinput에 추가
                        $('#checkinput').append(`<li data-field="${id}">${message}</li>`);
                        // 비밀번호 입력 필드에 포커스 이동
                        $('#pwd').focus();
                        // 필드에 오류가 있음을 기록
                        $(field).data('has-error', true);
                    }
                } else {
                    // 비밀번호가 일치할 경우 메시지를 제거
                    $('#checkinput li').each(function() {
                        if ($(this).data('field') === id) {
                            $(this).remove();
                        }
                    });
                    // 필드에서 오류가 없음을 기록
                    $(field).data('has-error', false);
                }
            } else {
                // 값이 있을 경우 해당 필드에 대한 메시지 제거
                $('#checkinput li').each(function() {
                    if ($(this).data('field') === id) {
                        $(this).remove();
                    }
                });
                // 필드에서 오류가 없음을 기록
                $(field).data('has-error', false);
            }
        }
    }
	
	// 성별 필드 검사 함수
    function validateGender() {
        const genderChecked = $('input[name="gender"]:checked').length > 0;
        if (!genderChecked) {
            const message = '성별은 필수 입력입니다.';
            // 이미 메시지가 있는지 확인
            if (!$('#checkinput').find('li[data-field="gender"]').length) {
                // 메시지를 #checkinput에 추가
                $('#checkinput').append(`<li data-field="gender">${message}</li>`);
            }
        } else {
            // 성별이 선택된 경우 메시지 제거
            $('#checkinput li').each(function() {
                if ($(this).data('field') === 'gender') {
                    $(this).remove();
                }
            });
        }
    }
	
	// 전체 폼을 검사하는 함수
	function validateForm() {
	    $('#updateForm input[required]').each(function() {
	        validateField(this);
	    });
	    validateGender(); // 성별 검증 호출
	}

	
	// 폼 제출 시 전체 폼을 검사
    $('#updateForm').on('submit', function(e) {
        e.preventDefault(); // 기본 폼 제출 동작 방지
        validateForm();
    });

    // 입력값 변경 시 개별 필드 검사
    $('#updateForm input').on('change', function() {
        validateField(this);
        validateGender();
    });
	
	// 포커스와 블러 이벤트 시 필드 검사
    $('#updateForm input').on('focus blur', function(event) {
        if (event.type === 'blur') { // 블러 이벤트에서만 검사
            validateField(this);
        }
    });
	
	$('#pwd').on('blur', function() {
	    const id = $('#id').val().trim();
		const pwd = $('#pwd').val().trim();
	    // 입력값이 비어있는 경우 처리
	    if (pwd === '') {
	        const message = '비밀번호는 필수 입력란입니다.';
	        // 기존 메시지 제거
	        $('#checkinput li[data-field="pwd"]').remove();
	        // 메시지를 #checkinput에 추가
	        $('#checkinput').append(`<li data-field="pwd">${message}</li>`);
	        $('#pwd').focus();
	        return;
	    }

	    // 기존 메시지 제거
	    $('#checkinput li[data-field="pwd"]').remove();

	    $.ajax({
	        url: '../member/checkPwd.do',  // 서버의 중복 체크 URL
	        method: 'POST',
	        data: {
				id: id, 
				pwd: pwd 
			},
	        dataType: 'text',  // 응답 데이터 형식을 JSON으로 설정
			success: function(data) {
				let result = data.trim();
				console.log("나 비번 체크 : ");
				
			    if (result == 'true') {
			        $('#checkinput').append(`<li data-field="pwd">기존에 사용하던 비밀번호입니다.</li>`);
			        $('#pwd').focus();
			    } else {
			        $('#checkinput').append(`<li data-field="pwd">사용 가능한 비밀번호입니다.</li>`);
			        setTimeout(function() {
			            $('#checkinput li[data-field="pwd"]').remove();
			        }, 3000);
			    }
			},
	        error: function(error) {
	            console.error('AJAX 요청 오류:', error);
	            $('#checkinput').append(`<li data-field="pwd">서버와의 통신에 실패했습니다. 나중에 다시 시도해 주세요.</li>`);
	        }
	    });
	});
	
	// 회원정보 수정 클릭 시 전체 폼을 검사
	$('#updatebtn').on('click', function(e) {
	    e.preventDefault(); // 기본 폼 제출 동작 방지
	    validateForm();

	    // 오류가 없는 경우 AJAX 요청으로 데이터 전송
	    if ($('#checkinput li').length === 0) {
	        const formData = $('#updateForm').serialize();

	        $.ajax({
	            url: '../member/update.do',  // 서버의 회원가입 처리 URL
	            method: 'POST',
	            data: formData,
	            dataType: 'text',
	            success: function(data) {
	                let result = data.trim();
	                console.log(result);

	                if (result) {
	                    // SweetAlert2로 성공 메시지 출력
	                    Swal.fire({
	                        icon: 'success',
	                        title: '정보 수정 완료',
	                        text: '정보수정이 완료되었습니다.',
	                        confirmButtonText: '확인',
	                        customClass: {
	                            title: 'custom-swal-title',
	                            content: 'custom-swal-content',
	                            confirmButton: 'custom-confirm-button', // 확인 버튼 스타일 클래스
	                        },
	                        buttonsStyling: false  // 기본 버튼 스타일 비활성화
	                    }).then(() => {
	                        // SweetAlert2 확인 버튼 클릭 후 페이지 이동
	                        window.location.href = '../index.do';
	                    });
	                } else {
	                    // SweetAlert2로 실패 메시지 출력
	                    Swal.fire({
	                        icon: 'error',
	                        title: '정보 수정 실패',
	                        text: '정보수정에 실패했습니다. 다시 시도해 주세요.',
	                        confirmButtonText: '확인',
	                        customClass: {
	                            title: 'custom-swal-title',
	                            content: 'custom-swal-content',
	                            confirmButton: 'custom-confirm-button',
	                        },
	                        buttonsStyling: false  // 기본 버튼 스타일 비활성화
	                    });
	                }
	            },
	            error: function() {
	                // SweetAlert2로 서버 통신 실패 메시지 출력
	                Swal.fire({
	                    icon: 'error',
	                    title: '서버 통신 실패',
	                    text: '서버와의 통신에 실패했습니다. 나중에 다시 시도해 주세요.',
	                    confirmButtonText: '확인',
	                    customClass: {
	                        title: 'custom-swal-title',
	                        content: 'custom-swal-content',
	                        confirmButton: 'custom-confirm-button',
	                    },
	                    buttonsStyling: false  // 기본 버튼 스타일 비활성화
	                });
	            }
	        });
	    }
	});


    // 이메일 선택 필드 변화 시 #email2에 값 반영
    $('#email3').on('change', function() {
        const selectedValue = $(this).val();
        if (selectedValue === '직접입력') {
            $('#email2').val('');
            $('#email2').focus(); // 이메일 주소 필드에 포커스 이동
        } else {
            $('#email2').val(selectedValue);
            $('#email3').val(''); // 이메일 선택 필드 초기화
        }
    });

    // 이메일 직접 입력 필드 변화 시 #email2에 값 반영
    $('#email2').on('input', function() {
        const email3Value = $('#email3').val();
        if (email3Value === '직접입력') {
            $('#email2').val($(this).val());
        }
    });
    
	// 주소 검색 버튼 클릭 시
    $("button[type='button']").click(function() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                let addr = '';
				//사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
	            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
	                addr = data.roadAddress;
	            } else { // 사용자가 지번 주소를 선택했을 경우(J)
	                addr = data.jibunAddress;
	            }

				// 우편번호와 주소 정보를 해당 필드에 넣는다.
	            document.getElementById('zipcode').value = data.zonecode;
	            document.getElementById("addr1").value = addr;
	            // 커서를 상세주소 필드로 이동한다.
	            document.getElementById("addr2").focus();
            }
        }).open();
    });
	
	// 회원 정보 삭제
	$("#deletebtn").on('click', function(){
	    Swal.fire({
	        title: '회원정보 삭제',
	        content: '삭제할 계정정보를 입력하세요.',
	        html:
	            '<input type="text" id="swal-id" class="swal2-input" placeholder="아이디">' +
	            '<input type="password" id="swal-pwd" class="swal2-input" placeholder="비밀번호">',
	        focusConfirm: false,
	        showCancelButton: true,
	        confirmButtonText: '삭제',
	        cancelButtonText: '취소',
	        customClass: {
	            title: 'swal2-title-custom',
	            text: 'swal2-text-custom',
	            confirmButton: 'custom-confirm-button',  // 확인 버튼 클래스
	            cancelButton: 'custom-cancel-button'     // 취소 버튼 클래스
	        },
	        buttonsStyling: false,  // 기본 스타일링 비활성화
	        preConfirm: () => {
	            const id = document.getElementById('swal-id').value;
	            const pwd = document.getElementById('swal-pwd').value;
	            if (!id) {
	                Swal.showValidationMessage('아이디를 입력해 주세요.');
	                return false;
	            } else if(!pwd) {
	                Swal.showValidationMessage('비밀번호를 입력해 주세요.');
	                return false;
	            }
	            return { id: id, pwd: pwd };
	        }
	    }).then((result) => {
	        if (result.isConfirmed) {
	            const id = result.value.id;
	            const pwd = result.value.pwd;

	            // 추가 확인 창 띄우기
	            Swal.fire({
	                title: '정말 삭제하시겠습니까?',
	                text: id + "님의 계정 정보를 정말 삭제하시겠습니까?",
	                icon: 'warning',
	                showCancelButton: true,
	                confirmButtonText: '삭제',
	                cancelButtonText: '뒤로가기',
	                customClass: {
	                    title: 'swal2-title-custom',
	                    text: 'swal2-text-custom',
	                    confirmButton: 'custom-confirm-button',  // 확인 버튼 클래스
	                    cancelButton: 'custom-cancel-button'     // 취소 버튼 클래스
	                },
	                buttonsStyling: false  // 기본 스타일링 비활성화
	            }).then((confirmation) => {
	                if (confirmation.isConfirmed) {
	                    // 실제 삭제 AJAX 요청
	                    $.ajax({
	                        url: '../member/delete.do', // 실제 서버 경로로 수정
	                        type: 'POST',
	                        data: { id: id, pwd: pwd },
	                        dataType: 'text',
	                        success: function(response) {
	                            let result = response.trim();
	                            if(result == "true") {
	                                Swal.fire({
	                                    title: '회원정보 삭제',
	                                    text: id + "님의 회원정보가 삭제되었습니다.",
	                                    customClass: {
	                                        title: 'swal2-title-custom',
	                                        text: 'swal2-text-custom',
	                                        confirmButton: 'custom-confirm2-button',  // 확인 버튼 클래스
	                                    },
	                                    buttonsStyling: false,  // 기본 스타일링 비활성화
	                                }).then(() => {
	                                    window.location.href="../index.do";
	                                });
	                            } else {
	                                Swal.fire({
	                                    title: '회원정보 삭제 실패',
	                                    text: "회원정보 삭제에 실패했습니다.",
	                                    customClass: {
	                                        title: 'swal2-title-custom',
	                                        text: 'swal2-text-custom',
	                                        confirmButton: 'custom-confirm2-button',  // 확인 버튼 클래스
	                                    },
	                                    buttonsStyling: false,  // 기본 스타일링 비활성화
	                                });
	                            }
	                        },
	                        error: function() {
	                            Swal.fire({
	                                title: '서버와의 연결에 실패했습니다.',
	                                text: '나중에 다시 시도해주세요',
	                                icon: 'error',
	                                customClass: {
	                                    title: 'swal2-title-custom',
	                                    text: 'swal2-text-custom',
	                                    confirmButton: 'custom-confirm2-button',  // 확인 버튼 클래스
	                                },
	                                buttonsStyling: false,  // 기본 스타일링 비활성화
	                            });
	                        }
	                    });
	                }
	            });
	        }
	    });
	});
});