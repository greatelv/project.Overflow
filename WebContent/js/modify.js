$(function modify_Handler() {
	$('#update').click(function(){
		$thema 		= $("input[name='theme']:checked").val();
		$auto 		= $("input[name='auto_update']:checked").val();
		$font		= $(".form-control option:selected").text();
		$id			= document.getElementById("id").value;
		$update		= "update";
		var json = {"type":$update,"thema":$thema,"font":$font,"auto":$auto,"id":$id};
		alert(json);
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