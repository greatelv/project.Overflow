$(function User_CRUD_Handler() {
	$('#post').click(function(){
		$postid 	= document.getElementById("postid").value;
		$postpw		= document.getElementById("postpw").value;
		$post		= "post";
		var json = {"type":$post,"password":$postpw,"id":$postid};
		console.log(json);
		$.ajax({
			url		:	"user.jsp",
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