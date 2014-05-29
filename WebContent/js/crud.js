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
				
				//회원가입 후 받은 데이터를 이용하여 바로 로그인을 시도합니다.
				var autologin = JSON.parse(datapost);
				$.ajax({
					url : "jsp/login.jsp",
					type: "POST",
					data: autologin,
					datatype: "json",
					success : function(data){
							document.location.href = "/o/";
						},error : function(){
							console.log('error from post');
						},complete : function()
						{
							console.log('complete from post');
						}
					
				});
				
			},
			error	: function(){
				console.log('error from post');
			},
			complete: function(){
				console.log('complete from post');
			}
		});
	});
	
	//deck 검색기록 저장
	$('#create_deck').click(function(){
		/*var login_check = $('#input_deck_user_id').val();
		alert(login_check);
		if( login_check == "null"){
			alert('login please~');
			//deck 검색 중지
		}
		else{
			$user_id	= '';
			$deck_name	= $('#input_deck_title').val();
			$deck_id	= $('#input_deck_user_id').val();
			var json = {"type":"post","name":$deck_name,"id":$deck_id};
			$.ajax({
				url		 :	"jsp/deck.jsp",
				type	 :	"POST",
				data	 :	json,
				datatype :	"json",
			
				success	 :	function(data){
					alert(data);
				},error	: function(){
					console.log('error from deck');
				},
				complete: function(){
					console.log('complete from deck');
				}
			});
		}*/
	});
});