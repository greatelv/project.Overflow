$(function modify_Handler() {
	$thema 		= $("input[name='theme']:checked").val();
	$auto 		= $("input[name='auto_update']:checked").val();
	$font		= $(".form-control option:selected").text();
	$id			= document.getElementById("id");
	
	alert($id);
});