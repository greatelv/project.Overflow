function load_deck(order, icon, title)
{
	 //덱의 내용을 미리 설정합니다.
	  var deck_order = order;
	  var deck_icon = icon; //"glyphicon glyphicon-search"; // 아이콘 css 입력
	  var deck_title = title; // 덱의 식별자로 사용됩니다.
	  var deck_body_id = title + "_body"; // 덱의 식별자로 사용됩니다.
	  
	  //미리 설정된 내용으로 덱을 구성합니다.
	  var deck = 
		  "<div id='" +
		  deck_title +
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
  //내용이 추가되면 기존의 내용 아래 부분에 추가되기 때문에 제대로 나오도록 레이아웃을 새로고침합니다.
  var nodes = $("#deck_table").children(); //덱 테이블의 현재 덱의 갯수를 구한다.
  //$(".deck").css({"width":nodes.length*255}); //하나의 덱은 255의 width를 가진다.
}

function load_deck_article(picture, nickname, contents, title)
{
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
		  //모달에서 덱 title을 가져옵니다.
		  var input_deck_title = $("#input_deck_title").val();
		  load_deck("0", "glyphicon glyphicon-search", input_deck_title);
		  console.log("D");
	    $('#create_deck_modal').modal('hide'); //모달을 닫습니다.
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


/* ready 이벤트를 사용하면 정적할당이 불가능 합니다.
	//덱 생성 버튼을 누르면 실행 됩니다.
$(document).ready(function(){
  $("#create_deck").click(function(){
	  //모달에서 덱 title을 가져옵니다.
	  var input_deck_title = $("#input_deck_title").val();
	  load_deck("0", "glyphicon glyphicon-search", input_deck_title);
	  console.log("D");
    
    $('#create_deck_modal').modal('hide'); //모달을 닫습니다.
  });
  
  //덱 삭제 버튼을 누르면 실행 됩니다.
  $("button.glyphicon").click(function(){
	  var deck_id = $(this).parent().parent().parent().attr('id');
	  $("#" + deck_id).remove();
  });

  
  //덱 전체 삭제 버튼을 누르면 실행 됩니다.
  $("#drop_deck_table").click(function(){
	  $("#deck_table").empty();
  });
  
  //[테스트용]덱에 내용추가 버튼을 누르면 실행 됩니다.
  $("#add_contents").click(function(){
	  load_deck_article("사진", "아이디", "여기에 본문내용이 표시됩니다.여기에 본문내용이 표시됩니다.여기에 본문내용이 표시됩니다.여기에 본문내용이 표시됩니다.여기에 본문내용이 표시됩니다.여기에 본문내용이 표시됩니다.", "검색단어");
  });
});*/