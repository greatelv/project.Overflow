$(function User_CRUD_Handler() {
	//회원가입
	$('#join').click(function(){
		$postid 	= document.getElementById("input-register-id").value;
		$postpw		= document.getElementById("input-register-password").value;
		$postname	= document.getElementById("input-register-name").value;
		$postemail	= document.getElementById("input-register-email").value;
		$postbirth	= document.getElementById("input-register-birth").value;
		
		$post		= "post";
		var json = {"type":$post,"id":$postid,"password":$postpw,"name":$postname,"email":$postemail,"birth":$postbirth};
		console.log(json);
		$.ajax({
			url		:	"jsp/user.jsp",
			type	:	"POST",
			data	:	json,
			datatype:	"json",
			
			success	: function(datapost){
				//alert(datapost);
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
	$('.stats').click(function(){
		var id = window.sessionId;
		var get = 'get';
		var json = {"type":get, "user_id":id};
		$.ajax({
			url		: "jsp/search.jsp",
			data	: json,
			datatype: "json",
			success : function(data){
				alert(data);
				var item = [];
				$.each(data,function(idx, val){
					item.push( "<li id='" + idx + "'>" 
							+ val.sequence + "|"
							+ val.search_word + "|" 
							+ val.time + "|"
							+ val.count + "|"
							+ "</li>");
				});
				
				
				$( "<ul/>", {
				    "class": "my-new-list",
				    html: item.join( "" )
				  }).appendTo( "#total_serach" );
			},error : function(){
				console.log('error from total_search');
			},complete : function()
			{
				console.log('complete from total_search');
			}
		});
	});
});