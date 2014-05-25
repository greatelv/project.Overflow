var $req = {};

//관련 API 키 옹브젝트
var $key = {
	bearer : '',
	apiKey : 'Basic bWNTc1NqY0Y3M2tzVWtzaWd3eXoxd1N4ajpDb0V2ZFZpNjRjRzduZDk0MmVyZDZZNUdIOTd6OHVjTWxqcm1BSXNhdjZNMVB0REpZdw=='
};

var $url = {
	bearer : 'https://api.twitter.com/oauth2/token',
	search : 'http://localhost:8080/o/api/search/'
};

//키워드로부터 API 데이터 조회
$req.getDataFromKeyword = function(keyword, callback){

	jQuery.ajax($url.search+keyword, {
		type: 'GET',
		dataType : "json",
		cache : false,
		success: function(oRes, sStatus, oXHR){
			LOG(JSON.stringify(oRes));
			callback && callback(oRes);
		},
		error : function(xhr, status, error){
		}
	});

};

$req.getBearerKey = function(){

	jQuery.ajax($url.bearer, {
		type : 'POST',
		beforeSend : function(request){
			request.setRequestHeader("Authorization", "Basic bWNTc1NqY0Y3M2tzVWtzaWd3eXoxd1N4ajpDb0V2ZFZpNjRjRzduZDk0MmVyZDZZNUdIOTd6OHVjTWxqcm1BSXNhdjZNMVB0REpZdw==");
		},
		dataType : "json",
		contentType : 'application/x-www-form-urlencoded;charset=UTF-8',
		cache : false,
		data : {grant_type : 'client_credentials'},
		success: function(oRes, sStatus, oXHR){
			LOG('success! : [Featured] post request apiUrl : ' + $url.bearer + 'oRes : '+oRes);
		    //callback && callback(oRes);
		},
		error : function(xhr, status, error){
			LOG('error! : [Featured] post request apiUrl : ' + $url.bearer);
		}
	});
};