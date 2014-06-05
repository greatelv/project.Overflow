var deck_cnt = 0;

var load_deck = function(order, icon, title){
	//덱의 내용을 미리 설정합니다.
	var deck_order = order;
	var deck_icon = icon; //"glyphicon glyphicon-search"; // 아이콘 css 입력
	var deck_title = title; // 덱의 식별자로 사용됩니다.
	var deck_body_id = title + "_body"; // 덱의 식별자로 사용됩니다.



	//미리 설정된 내용으로 덱을 구성합니다.
	var deck = 
	  "<div id='"+deck_title+
	  "' class='deck' order='"+deck_order+"'>" +
			"<div class='deck-header'>" +
			"<div class='deck-order'>" +
			deck_order +
			"</div>" +
			"<div class='deck-icon " +
			deck_icon +
			"'></div>" +
			"<div class='deck-title'>" +
			deck_title +
			"<button class='glyphicon glyphicon-trash'></button>" +
			"</div>" +
			"</div>" +
			"<div id='" +
			deck_body_id +
			"' class='deck-body'>" +
			"</div>" +
			"</div>";
	//덱을 실제로 추가합니다.
  	$("#deck_table").append(deck);
	deck_cnt = deck_cnt + 1;

	//API 연동
 	$req.getDataFromKeyword(deck_title, function(res){
		var articlesELem = "";
		
		$.each(res, function(idx, item){
	  		var itemElem = 	'<div class="deck-article">'+
			    				'<div class="deck-profile">'+
			    					'<div class="deck-profile-picture" style="background:url('+item.user.profileImageUrl+')"></div>'+
			    					'<div class="deck-profile-nickname">'+item.user.screenName+'</div>'+
			    				'</div>'+
			    				'<div class="deck-contents">'+item.text+'</div>'+
			    			'</div>';

			$("#deck_table").find('.deck[order="'+deck_order+'"]')
							.find('.deck-body')
							.append(itemElem);
  		});

	})

  //내용이 추가되면 기존의 내용 아래 부분에 추가되기 때문에 제대로 나오도록 레이아웃을 새로고침합니다.
  //var nodes = $("#deck_table").children(); //덱 테이블의 현재 덱의 갯수를 구한다.
  //$(".deck").css({"width":nodes.length*255}); //하나의 덱은 255의 width를 가진다.
};

var load_deck_article = function(picture, nickname, contents, title){
	  var deck_profile_picture = picture;
	  var deck_profile_nickname = nickname;
	  var deck_contents = contents;
	  var article =
		  "<div class='deck-article'>" +
	  		"<div class='deck-profile'>" +
	  		"<div class='deck-profile-picture'>" +
	  		deck_profile_picture +
	  		"</div>" +
	  		"<div class='deck-profile-nickname'>" +
	  		deck_profile_nickname +
	  		"</div>" +
	  		"</div>" +
	  		"<div class='deck-contents'>" +
	  		deck_contents +
	  		"</div>" +
	  		"</div>";
	  var deck_body_id = "#" + title + "_body";
	  $(deck_body_id).append(article);
}



// 동적할당된 요소를 컨트롤 하려면 on메소드를 사용해야 합니다.
$(document).on("click", "#create_deck", function(){
		//덱 생성 버튼을 누르면 실행 됩니다.
		  //모달에서 덱 title과 사용자의 id를 가져옵니다.
		  var input_deck_title = $("#input_deck_title").val();
		  var input_deck_user_id = $('#input_deck_user_id').val();
		  	//이때 id값이 null 즉, login하지 않은 상태의 경우에는 로그인을 해달라는 경고문을 띄웁니다.
			if( input_deck_user_id == "null"){
				alert('login please~');
				//deck 검색 중지
				$('#create_deck_modal').modal('hide');
			}
			//login한 상태라면 입력한 값을 이용하여 load_deck을 하고 ajax를 이용하여서 검색한 값을 overflow_dev의 deck table에 저장합니다.
			else{
				load_deck(deck_cnt+1, "glyphicon glyphicon-search", input_deck_title);
				var json = {"type":"post","user_id":input_deck_user_id,"deck_title":input_deck_title};
				$.ajax({
					url		 :	"jsp/deck.jsp",
					type	 :	"POST",
					data	 :	json,
					datatype :	"json",
				
					success	 :	function(data){
						alert(data);
						$('#create_deck_modal').modal('hide'); //모달을 닫습니다.
					},error	: function(){
						console.log('error from deck');
					},
					complete: function(){
						console.log('complete from deck');
					}
				});
			}
});

//덱 삭제 버튼을 누르면 실행 됩니다.
$(document).on("click", "button.glyphicon", function(){
	var deck_id = $(this).parent().parent().parent().attr('id');
	  $("#" + deck_id).remove();
});

//덱 전체 삭제 버튼을 누르면 실행 됩니다.
$(document).on("click", "#drop_deck_table", function(){
	 $("#deck_table").empty();
});

//[테스트용]덱에 내용추가 버튼을 누르면 실행 됩니다.
$(document).on("click", "#add_contents", function(){
	load_deck_article("사진", "아이디", "여기에 본문내용이 표시됩니다.여기에 본문내용이 표시됩니다.여기에 본문내용이 표시됩니다.여기에 본문내용이 표시됩니다.여기에 본문내용이 표시됩니다.여기에 본문내용이 표시됩니다.", "검색단어");
});

//기본 데크 초기화
load_deck(1, "glyphicon glyphicon-search", '지방선거');
load_deck(2, "glyphicon glyphicon-search", '걸그룹');