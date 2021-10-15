<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<div class="d-flex justify-content-center">
	<div class="w-25">
		<div>
			이름
			<input type="text" id="userName" class="form-control w-100 mt-1" placeholder="이름을 입력해주세요">
		</div>
		<div class="pt-3">
			아이디
			<input type="text" id="loginId" class="form-control w-100 mt-1" placeholder="ID를 입력해주세요">
			<div class="d-flex justify-content-between">
				<div>
					<div id="idCheckLength" class="small text-danger d-none">ID를 4자 이상 입력해주세요.</div>
					<div id="idCheckDuplicated" class="small text-danger d-none">이미 사용중인 ID입니다.</div>
					<div id="idCheckOk" class="small text-success d-none">사용 가능한 ID 입니다.</div>
				</div>
				<div>
					<button type="button" id="loginIdCheckBtn" class="btn btn-sm btn-success">중복확인</button>
				</div>
			</div>
		</div>
		<div>
			비밀번호
			<input type="password" id="password" class="form-control w-100 mt-1" placeholder="비밀번호를 입력해주세요">
		</div>
		<div class="pt-3">
			비밀번호 확인
			<input type="password" id="passwordCheck" class="form-control w-100 mt-1" placeholder="비밀번호를 입력해주세요">
		</div>
		
		<div class="w-100 pt-3 d-flex justify-content-end">
			<button type="button"  id="signUpBtn" class="btn btn-secondary">회원가입</button>
		</div>
	</div>
</div>

<script>
$(document).ready(function() {
	var idData = "";
	$('#loginIdCheckBtn').on('click', function(e) {
		
		var loginId = $('#loginId').val().trim();
		
		if (loginId.length < 4) {
			$('#idCheckLength').removeClass('d-none');
			$('#idCheckDuplicated').addClass('d-none');
			$('#idCheckOk').addClass('d-none');
			return;
		}
		
		$.ajax({
			url: "/user/is_duplicated_id",
			data: {"loginId": loginId},
			success: function(data) {
				if (data.result == true) {
					$('#idCheckDuplicated').removeClass('d-none');
					$('#idCheckLength').addClass('d-none');
					$('#idCheckOk').addClass('d-none');
					
					id = loginId;
				} else {
					$('#idCheckOk').removeClass('d-none');
					$('#idCheckLength').addClass('d-none');
					$('#idCheckDuplicated').addClass('d-none');
				}
			},
			error: function(error) {
				alert("아이디 중복확인에 실패했습니다. 관리자에게 문의해주세요.");
			}
		});
		
		idData = loginId;
	});
	
	$('#signUpBtn').on('click', function() {
		
		var name = $('#userName').val().trim();
		if (name == '') {
			alert("이름을 입력하세요.");
			return;
		}
		
		var loginId = $('#loginId').val().trim();
		if (loginId == '') {
			alert("아이디를 입력하세요.");
			return;
		}
		
		var password = $('#password').val().trim();
		var confirmPassword = $('#passwordCheck').val().trim();
		if (password == '' || confirmPassword == '') {
			alert("비밀번호를 입력하세요.");
			return;
		}
		
		if (password != confirmPassword) {
			alert("비밀번호가 일치하지 않습니다. 다시 입력하세요.");
			
			$('#password').val('');
			$('#passwordCheck').val('');
			return;
		}
		

		if ($('#idCheckOk').hasClass('d-none') == true || idData != loginId) {
			alert("아이디 확인을 다시 해주세요.");
			return;
		}
	
		var url = '/user/sign_up';    
		var data = {'name':name, 'loginId':loginId, 'password':password};
		
		$.post(url, data)
		.done(function(data) {
			if (data.result == "success") {
				alert("가입을 환영합니다!!! 로그인을 해주세요.");				
				location.href="/user/sign_in_view";
			} else {
				alert("가입에 실패했습니다. 다시 시도해주세요.");
			}
		}); 
	});
});
</script>