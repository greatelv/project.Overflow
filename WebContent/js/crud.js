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
		$("#total_search_list").remove();
		var id = window.sessionId;
		var get = 'get';
		var json = {"type":get, "user_id":id};
		var total_search_count = 0;
		var user_search_count = 0;
		$.ajax({
			url		: "jsp/search.jsp",
			data	: json,
			datatype: "json",
			success : function(data){
				var dataget = [];
				var res = JSON.parse(data);
				
				$.each(res,function(idx, val){
					dataget.push(
							"<tr><td id=" + val.sequence +">" + val.sequence + ">"
							+ "<td>" + val.search_word + "</td>"
							+ "<td>" + val.count + "</td>"
							+ "<td>" + val.time + "</td></tr>"
					);
					total_search_count = total_search_count + val.count;
				});
				$("<tbody>",{
					"id": "total_search_list",
					html : dataget.join("")
				}).appendTo("#total_search");
				var total = "<span>" + total_search_count + "</span>"
				$(total).appendTo("#total_count");
				if(id == 'null'){
					//alert('no login! id = ' + id);
				}else{
					//alert('login! id = ' + id);
					var json = {"type":"get_user","user_id":id};
					$.ajax({
						url		: "jsp/search.jsp",
						data	: json,
						datatype: "json",
						success : function(data){
							//alert(data);
							var dataget = [];
							var res = JSON.parse(data);
							
							$.each(res,function(idx, val){
								dataget.push(
										"<tr><td id=" + val.sequence +">" + val.sequence + ">"
										+ "<td>" + val.search_word + "</td>"
										+ "<td>" + val.time + "</td></tr>"
								);
								user_search_count = user_search_count + val.count
							});
							var user_total = "<span>" + user_search_count + "</span>"
							$(user_total).appendTo("#user_count");
							$("<tbody>",{
								"id": "user_search_list",
								html : dataget.join("")
							}).appendTo("#user_search");
						},error : function(){
							console.log('error from id_search');
						},complete : function()
						{
							console.log('complete from id_search');
						}
					});
				}
				
			},error : function(){
				console.log('error from total_search');
			},complete : function()
			{
				console.log('complete from total_search');
			}
		});
	});
});