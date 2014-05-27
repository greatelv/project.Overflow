$(function User_CRUD_Handler() {
	//회원가입
	$('#join').click(function(){
		$postid 	= document.getElementById("input-register-id").value;
		$postpw		= document.getElementById("input-register-password").value;
		$postname	= document.getElementById("input-register-name").value;
		$postemail	= document.getElementById("input-register-email").value;
		$post		= "post";
		var json = {"type":$post,"id":$postid,"password":$postpw,"name":$postname,"email":$postemail};
		console.log(json);
		$.ajax({
			url		:	"jsp/user.jsp",
			type	:	"POST",
			data	:	json,
			datatype:	"json",
			
			success	: function(datapost){
				alert(datapost);
				$('#register').modal('hide');
			},
			error	: function(){
				console.log('error from post');
			},
			complete: function(){
				console.log('complete from post');
			}
		});
	});
	
	
	/*$('#login').click(function(){

		$loginid	= document.getElementById("login_id").value;
		$loginpw	= document.getElementById("login_password").value;
		$login		= "login";
		
		var json = {"type":$login,"id":$loginid,"password":$loginpw};
		console.log(json);
		
		$.ajax({
			url		:	"jsp/login.jsp",
			type	:	"POST",
			data	:	json,
			datatype:	"json",
			success	: function(res){
				var jsonr = JSON.parse(res);
				alert(res);
				if(jsonr.result == 1){
					alert(jsonr.name+'님 환영합니다.');
					
				}else{
					alert('로그인에 실패하였습니다.');
				}
			},
			error	: function(){
				console.log('error from get');
			}
		});
	});*/
});