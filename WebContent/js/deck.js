$(document).ready(function(){
	//덱 생성 버튼을 누르면 실행 됩니다.
  $("#creat_deck").click(function(){
	  //덱의 내용을 미리 설정합니다.
	  var deck_order = "0";
	  var deck_icon = "glyphicon glyphicon-search"; // 아이콘 css 입력
	  var deck_title = "새검색단어"; // 덱의 식별자로 사용됩니다.
	  var deck_id = "새검색단어"; // 덱의 식별자로 사용됩니다.
	  var deck_body_id = "새검색단어"; // 덱의 식별자로 사용됩니다.
	  
	  //미리 설정된 내용으로 덱을 구성합니다.
	  var deck = 
		  "<div id='" +
		  deck_id +
		  "' class='deck'>" +
	  		"<div class='deck-header'>" +
	  		"<div class='deck-order'>" +
	  		deck_order +
	  		"</div>" +
	  		"<div class='deck-icon " +
	  		deck_icon +
	  		"'></div>" +
	  		"<div class='deck-title'>" +
	  		deck_title +
	  		"</div>" +
	  		"</div>" +
	  		"<div id='" +
	  		deck_body_id +
	  		"' class='deck-body'>" +
	  		
	  		"</div>" +
	  		"</div>";
	  //덱을 실제로 추가합니다.
    $("#deck_table").append(deck);
    //내용이 추가되면 기존의 내용 아래 부분에 추가되기 때문에 제대로 나오도록 레이아웃을 새로고침합니다.
    var nodes = $("#deck_table").children(); //덱 테이블의 현재 덱의 갯수를 구한다.
    $("body").css({"width":nodes.length*255}); //하나의 덱은 255의 width를 가진다.
  });
  
  
  //덱 삭제 버튼을 누르면 실행 됩니다.
  $("#delete_deck").click(function(){
	  var deck_id = "#새검색단어";
	  $(deck_id).remove();
  });
  
  
  //덱 전체 삭제 버튼을 누르면 실행 됩니다.
  $("#drop_deck_table").click(function(){
	  $("#deck_table").empty();
  });
  
  //[테스트용]덱에 내용추가 버튼을 누르면 실행 됩니다.
  $("#add_contents").click(function(){
	  var deck_profile_picture = "사진";
	  var deck_profile_nickname = "아이디";
	  var deck_contents = "검색내용검색내용검색내용검색내용검색내용검색내용검색내용검색내용검색내용검색내용검색내용검색내용검색내용검색내용검색내용검색내용검색내용검색내용검색내용검색내용검색내용검색내용검색내용검색내용검색내용검색내용검색내용검색내용검색내용검색내용검색내용검색내용검색내용검색내용검색내용검색내용검색내용";
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
	  var deck_body_id = "#새검색단어";
	  $(deck_body_id).append(article);
  });
});