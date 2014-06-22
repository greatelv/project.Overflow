var config = function(){

	var _this = $('#config_modal');

	var elem = {
		theme : _this.find('.theme'),
		size :  _this.find('.size'),
		auto : 	_this.find('.auto')
	};

	var load_user_config = function(){
		$.ajax({
			url		 : "jsp/user.jsp?type=getOne&id="+window.sessionId,
			type	 : "GET",
			datatype : "json",
			success	 : function(data){
				var result = JSON.parse(data)[0];

				$USER['font'] = result.config_font_size;
				$USER['theme'] = result.config_thema;
				$USER['auto'] = result.config_auto_stream;

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

		//테마 설정
		if($USER.theme == 0){
			elem.theme.find('> label[key="dark"]').addClass('active');
		}else{
			elem.theme.find('> label[key="light"]').addClass('active');
		}

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
		//테마 설정
		if($USER.theme == 0){
			$('body').removeClass().addClass('dark');
		}else{
			$('body').removeClass().addClass('light');
		}
	}

	return {
		init : function(){
			load_user_config();
			syncModal();
		},
		syncModal : function(){

		},
		update : function(){

		}
	};

	var syncModal = function(){
		
	};

}();


