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
			},
			error	: function(){
				console.log('error from post');
			},
			complete: function(){
				console.log('complete from post');
			}
		});
	});
	
	//로그인
	$('#login').click(function(){
		$loginid	= document.getElementById("login_id");
		$loginpw	= document.getElementById("login_password");
		$login		= "login";
		
		var json = {"type":$login, "id":$loginid, "password":$loginpw};
		
		console.log(json);
		$.ajax({
			url		:	"jsp/user.jsp",
			type	:	"POST",
			data	:	json,
			datatype:	"json",
			
			success	: function(datalogin){
				alert(datalogin);
			},
			error	: function(){
				console.log('error from login');
			},
			complete: function(){
				console.log('complete from login');
			}
		});
	});
});