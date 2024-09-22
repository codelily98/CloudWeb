$(document).ready(function() {
    // 홈페이지로 돌아가는 함수
    $("img[alt='logo']").click(function(){
        location.href="../index.do";
    });

    // 필드 순서 정의
    const fieldOrder = ['id', 'pwd', 'repwd', 'name', 'gender', 'email'];
	
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
                } else if (id === 'email1' || id === 'email2') {
                    const email1Value = $('#email1').val().trim();
                    const email2Value = $('#email2').val().trim();

                    if (email1Value === '' || email2Value === '') {
                        message = '이메일은 필수 입력란입니다.';
                        // 이미 이메일 관련 메시지가 추가되었는지 확인
                        if (!$('#checkinput li[data-field="email"]').length) {
                            // 메시지를 #checkinput에 추가
                            $('#checkinput').append(`<li data-field="email">이메일은 필수 입력란입니다.</li>`);
                            // 첫 번째 빈 필드에 포커스 이동
                            if (email1Value === '') {
                                $('#email1').focus();
                            } else {
                                $('#email2').focus();
                            }
                            // 필드에 오류가 있음을 기록
                            $('#email1, #email2').data('has-error', true);
                        }
                    } else {
                        const emailWarning = $('#checkinput li[data-field="email"]');
                        if (emailWarning.length) {
                            emailWarning.remove();
                        }
                        $('#email1, #email2').data('has-error', false);
                    }
                    return; // 이메일 검사 후 나머지 실행 중단
                }

                // 이미 메시지가 있는지 확인
                if (!$(field).data('has-error') && message !== '') {
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
                    $('#checkinput li[data-field="repwd"]').remove();
                    // 필드에서 오류가 없음을 기록
                    $(field).data('has-error', false);
                }
            } else {
                // 값이 있을 경우 해당 필드에 대한 메시지 제거
                $('#checkinput li[data-field="' + id + '"]').remove();
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
            $('#checkinput li[data-field="gender"]').remove();
        }
    }

    // 전체 폼을 검사하는 함수
    function validateForm() {
        $('#checkinput').empty();  // 기존 메시지 제거
        // 필수 입력 필드 검사
        $('#joinForm input[required]').each(function() {
            validateField(this);
        });
        // 성별 필드 검사
        validateGender();
        // #checkinput의 자식 요소를 순서대로 정렬
        sortErrorMessages();
    }

    // 아이디 중복체크
    $(document).on('blur', '#id', function() {
        const id = $('#id').val().trim();
        // 입력값이 비어있는 경우 처리
        if (id === '') {
            const message = '아이디는 필수 입력란입니다.';
            // 기존 메시지 제거
            $('#checkinput li[data-field="id"]').remove();
            // 메시지를 #checkinput에 추가
            $('#checkinput').append(`<li data-field="id">${message}</li>`);
            $('#id').focus();
            return;
        }

        // 기존 메시지 제거
        $('#checkinput li[data-field="id"]').remove();

        $.ajax({
            url: '../member/checkId.do',  // 서버의 중복 체크 URL
            method: 'POST',
            data: { id: id },
            dataType: 'text',
            success: function(data) {
                let result = data.trim();
                console.log("아이디 중복 체크 : " + result);
                // 기존 메시지 제거
                $('#checkinput li[data-field="id"]').remove();
                
                if(result == 'true') {
                    $('#checkinput').append(`<li data-field="id">이미 가입된 아이디입니다.</li>`);
                    $('#id').focus();
                } else {
                    $('#checkinput').append(`<li data-field="id">사용 가능한 아이디입니다.</li>`);
                    setTimeout(function() {
                        $('#checkinput li[data-field="id"]').remove();
                    }, 3000);
                } 
            },
            error: function(error) {
                console.error('AJAX 요청 오류:', error);
                $('#checkinput').append(`<li data-field="id">서버와의 통신에 실패했습니다. 나중에 다시 시도해 주세요.</li>`);
            }
        });
    });

    // 이메일 선택 필드 변화 시 #email2에 값 반영
    $(document).on('change', '#email3', function() {
        const selectedValue = $(this).val();
		if (selectedValue === '이메일 선택') {
            // '이메일 선택'인 경우 아무 작업도 하지 않음
            return;
        } else if (selectedValue === '직접입력') {
            $('#email2').val('');  // 직접 입력을 선택하면 #email2를 비움
            $('#email2').focus();  // #email2에 포커스 이동
        } else {
            $('#email2').val(selectedValue);  // 선택한 이메일 도메인을 #email2에 입력
        }
    });

    // 입력값 변경 시 개별 필드 검사
    $(document).on('input', '#email1, #email2', function() {
        validateField(this);
        validateGender();
    });

    // 포커스와 블러 이벤트 시 필드 검사
    $('#joinForm input').on('focus blur', function(event) {
        if (event.type === 'blur') { // 블러 이벤트에서만 검사
            validateField(this);
            
            // 이메일 필드의 경우 추가 처리
            if ($(this).attr('id') === 'email1' || $(this).attr('id') === 'email2' || $(this).attr('id') === 'email3') {
                const email1Value = $('#email1').val().trim();
                const email2Value = $('#email2').val().trim();
				const email3Value = $('#email3').val().trim();
            
                // 이메일 필드 둘 다 값이 있으면 메시지 제거
                if (email1Value !== '' && email2Value !== '') {
                    $('#checkinput li[data-field="email"]').remove();
                    $('#email1, #email2').data('has-error', false);
                }
            }
        }
    });

    // 주소 검색 버튼 클릭 시
    $(document).on('click', "#zipcodeSearch", function() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                let addr = '';
                // 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 도로명 주소
                    addr = data.roadAddress;
                } else { // 지번 주소
                    addr = data.jibunAddress;
                }
                // 주소 정보를 입력 필드에 설정
                $('#zipcode').val(data.zonecode); // 우편번호
                $('#addr1').val(addr); // 주소
                $('#addr2').focus(); // 상세 주소 입력 필드에 포커스 이동
            }
        }).open();
    });

	// 폼 제출 버튼 클릭 시
	$(document).on('click', '#writebtn', function() {
	    $('#joinForm').submit();  // 폼 제출
	});
	
    // 폼 제출 전 유효성 검사
    $(document).on('submit', '#joinForm', function(event) {
		event.preventDefault();  // 기본 제출 동작 방지
		validateForm();  // 폼 검증        

        // 에러가 있을 경우 제출 방지
		if ($('#checkinput li').length > 0) {
		    // 메시지의 데이터 필드에 따라 포커스를 이동
		    $('#checkinput li').each(function() {
		        const fieldId = $(this).data('field');
		        if ($('#' + fieldId).length) {
		            $('#' + fieldId).focus();
		        } else if (fieldId === 'email') {
		            $('#email1').focus(); // 이메일 필드가 문제인 경우 첫 번째 필드에 포커스 이동
		        }
		    });
	    return false;
		}
        // AJAX를 통한 폼 데이터 전송
        $.ajax({
            url: '../member/join.do',
            method: 'POST',
            data: $('#joinForm').serialize(),
            success: function(response) {
                // 성공 시 알림 메시지
                Swal.fire({
                    icon: 'success',
                    title: '가입 성공',
                    text: '회원가입이 완료되었습니다.',
                    confirmButtonText: '확인'
                }).then(function() {
                    location.href = "../index.do";
                });
            },
            error: function(xhr, status, error) {
                // 실패 시 알림 메시지
                Swal.fire({
                    icon: 'error',
                    title: '가입 실패',
                    text: '회원가입에 실패했습니다. 나중에 다시 시도해 주세요.',
                    confirmButtonText: '확인'
                });
            }
        });
    });

    // 리셋 버튼 클릭 시
    $('#reset').click(function() {
        $('#checkinput').empty(); // 오류 메시지 제거
    });
	
	// 오류 메시지 순서 정렬 함수
	function sortErrorMessages() {
	    const errorMessages = $('#checkinput li').get();
	    errorMessages.sort((a, b) => {
	        const idA = $(a).data('field');
	        const idB = $(b).data('field');
	        return fieldOrder.indexOf(idA) - fieldOrder.indexOf(idB);
	    });
	    $('#checkinput').empty().append(errorMessages);
	}    
});