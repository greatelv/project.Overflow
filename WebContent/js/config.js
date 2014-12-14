var config = function(){

	var _this = $('#config_modal');

	var elem = {
		theme : _this.find('.theme'),
		size :  _this.find('.size'),
		auto : 	_this.find('.auto')
	};

	var timer = [];

	var load_user_config = function(){
		$.ajax({
			url		 : "jsp/user.jsp?type=getOne&id="+window.sessionId,
			type	 : "GET",
			datatype : "json",
			success	 : function(data){
				var result = $.extend({
					config_font_size : 0,
					config_thema : 0,
					config_auto_stream : 0
				}, JSON.parse(data)[0]);

				$USER['size'] = result.config_font_size || 0;
				$USER['theme'] = result.config_thema;
				$USER['auto'] = result.config_auto_stream;

				syncModal();
				applyConfig();
			},
			error	: function(){
				console.log('error from deck');
			},
			complete: function(){
				console.log('complete from deck');
				
			}
		});	
	};

	//모달을 현재상태로 동기화
	var syncModal = function(){
		elem.theme.find('> label').removeClass('active');
		elem.size.find('option').removeAttr("selected");
		elem.auto.find('> label').removeClass('active');

		
		//텍스트 폰트 설정
		elem.size.find('option[val="'+$USER.size+'"]').attr('selected','selected');

		//자동 업데이트
		if($USER.auto == 0){
			elem.auto.find('> label[key="off"]').addClass('active');
		}else{
			elem.auto.find('> label[key="on"]').addClass('active');
		}			
	};

	//실제 설정값 적용
	var applyConfig = function(){
		$('#deck_table').attr('type', $USER.size);
		if($USER.auto == '1'){
			activePolling();
		}
	};

	var activePolling = function(){
		$('#deck_table').find('.deck').each(function(idx, item){
			var keyword = $(this).attr('keyword');
			var deckBody = $(this).find('.deck-body');

			timer.push(setInterval(function(){
				reload_deck(keyword, deckBody);	
			}, 12000));
		});
	}
	
	var updateConfig = function(){
	
		var json = {
			"type":'update',
			"thema": 0,
			"font" : elem.size.find('> select').val(),
			"auto" : elem.auto.find('input[name="auto"]:checked').val(),
			"id": window.sessionId
		};
		
		$.ajax({
			url		:	"jsp/user.jsp",
			type	:	"POST",
			data	:	json,
			datatype:	"json",
			
			success	: function(datapost){
				location.reload();
				config.update();
			},
			error	: function(){
				console.log('error from post');
			},
			complete: function(){
				console.log('complete from post');
			}
		});
	};
	return {
		update : function(){
			load_user_config();
			//syncModal();
			//applyConfig();
		},
		submit : function(){
			updateConfig();
		}
		
	};
}();


