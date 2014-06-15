var deck_cnt = 0;

var load_user_deck = function(){


	$.ajax({
		url		 : "jsp/deck.jsp?type=get&user_id="+window.sessionId,
		type	 : "GET",
		datatype : "json",
		success	 : function(data){
			var user_decks = JSON.parse(data);
			
			for(var i=0; i<user_decks.length; i++){
				load_deck(user_decks[i].deck_title);
			}

		},error	: function(){
			console.log('error from deck');
		},
		complete: function(){
			console.log('complete from deck');
			
		}
	});
	
}
          
var load_deck = function(title){
	//덱의 내용을 미리 설정합니다.
	//alert(title);
	var deck_title = title; 			// 덱의 식별자로 사용됩니다.
	var deck_body_id = title + "_body"; // 덱의 식별자로 사용됩니다.

	var deck = 
	  "<div id='"+deck_title+"' class='deck' keyword='"+deck_title+"'>" +
		"<div class='deck-header'>" +
			"<div class='deck-icon glyphicon glyphicon-search'></div>" +
			"<div class='deck-title'>"+deck_title+"</div>" +
			"<div class='glyphicon glyphicon-trash deck_del'></div>" +
		"</div>" +
		"<div id='"+deck_body_id +"' class='deck-body'>" +"</div>" +
		"</div>";
	   "</div>"
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

			$('#'+deck_title).find('.deck-body').append(itemElem);
  		});
	});

	var json = {"type":"post","user_id":window.sessionId,"deck_title":deck_title};
	$.ajax({
		url		 : "jsp/search.jsp",
		type	 : "POST",
		data	 : json,
		datatype : "json",
		
		success	 : function(data){
			//alert(data);
		},error	: function(){
			console.log('error from search');
		},
		complete: function(){
			console.log('complete from search');
		}
	});

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

	var deck_size = $('#deck_table .deck').size();
	var input_deck_title = $('#input_deck_title').val();
		
	if(deck_size >= 5){
		alert('Deck는 총 5개 이상 생성이 불가능합니다.');
	}else{
		load_deck(input_deck_title);

	}

	$('#create_deck_modal').modal('hide');
});

//덱 삭제 버튼을 누르면 실행 됩니다.
$(document).on("click", "div.deck_del", function(){
	var delete_deck_title = $(this).parent().parent().attr("keyword");
	$delete		= "delete";
	var json = {"type" : $delete,"deck_title" : delete_deck_title, "user_id" : window.sessionId};
	
	$.ajax({
		url		 : "jsp/deck.jsp",
		type	 : "POST",
		data	 : json,
		datatype : "json",
		
		success	 : function(data){
			alert(data);
		},error	: function(){
			console.log('error from deck');
		},
		complete: function(){
			console.log('complete from deck');
			
		}
	});
	$(this).parent().parent().remove();
});

//덱 전체 삭제 버튼을 누르면 실행 됩니다.
$(document).on("click", "#drop_deck_table", function(){
	 $("#deck_table").empty();
});

//[테스트용]덱에 내용추가 버튼을 누르면 실행 됩니다.
$(document).on("click", "#add_contents", function(){
	load_deck_article("사진", "아이디", "여기에 본문내용이 표시됩니다.여기에 본문내용이 표시됩니다.여기에 본문내용이 표시됩니다.여기에 본문내용이 표시됩니다.여기에 본문내용이 표시됩니다.여기에 본문내용이 표시됩니다.", "검색단어");
});