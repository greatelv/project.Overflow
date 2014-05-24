$(function User_CRUD_Handler() {
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
});