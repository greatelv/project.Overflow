/**
*전체삭제, 데크추가, 설정 메뉴에 대해 비활성화/활성화 시키는 토글 함수
*/
var plusMenuToggle = function(flag){
	if(flag){	//활성화
		$('#menubar .config').removeClass('disable')
							 .find('a')
							 .attr('data-toggle', 'modal');

		$('#menubar .add-deck').removeClass('disable')
							 .find('a')
							 .attr('data-toggle', 'modal');

		$('#menubar .del-deck').removeClass('disable');


		$('#drop_deck_table').show();
		$('#drop_deck_table_disable').hide();
		

	}else{	//비활성화
		$('#menubar .config').addClass('disable')
							 .find('a')
							 .attr('data-toggle', 'dsable');

		$('#menubar .add-deck').addClass('disable')
							 .find('a')
							 .attr('data-toggle', 'dsable');

		$('#menubar .del-deck').addClass('disable');							 

		$('#drop_deck_table').hide();
		$('#drop_deck_table_disable').css('display', 'block');
	}
}


//홈과 통게 메뉴 핸들링
$('#menubar li.home, #menubar li.stats').click(function(){
    $('.context').hide();
    var menu = jQuery(this);

    if(menu.attr('class') == 'home'){
        $('#deck_table').show();

        if(window.sessionId=='null'){
        	plusMenuToggle(false);
        }else{
        	plusMenuToggle(true);	
        }
		
    }else if(menu.attr('class') == 'stats'){
        $('#stats_page').show();
        plusMenuToggle(false);
    }
})

$('#logout_btn').click(function(){
	location.href = "/jsp/logout.jsp";
});