var $req = {};

//관련 API 키 옹브젝트
var $key = {
	bearer : '',
	apiKey : 'Basic bWNTc1NqY0Y3M2tzVWtzaWd3eXoxd1N4ajpDb0V2ZFZpNjRjRzduZDk0MmVyZDZZNUdIOTd6OHVjTWxqcm1BSXNhdjZNMVB0REpZdw=='
}

var $url = {
	bearer : 'https://api.twitter.com/oauth2/token',
	search : 'https://api.twitter.com/1.1/search/tweets.json'
}

$req.getApi = function(keyword){};



//키워드로부터 API 데이터 조회
/*$req.getDataFromKeyword = function(keyword){

	var keyword = keywrod;

	jQuery.ajax($url.search, {
		type : method,
		dataType : "json",
		contentType : 'application/json; charset=utf-8',
		cache : false,
		headers: {
			'apiKey': token,
			'Accept' : "application/json",
        	"Content-Type": "application/json"
		},
		data : JSON.stringify(Param),
		//timeout: 5000,
		success: function(oRes, sStatus, oXHR){
			LOG('success! : [Featured] post request apiUrl : ' + url+'?apiKey='+token);
		    callback && callback(oRes);
		},
		error : function(xhr, status, error){
			LOG('error! : [Featured] post request apiUrl : ' + url+'?apiKey='+token);
			errorCallback && errorCallback();
		},
		complete : function(){
			LOG('JSON.stringify(Param) : '+JSON.stringify(Param)); 
		}
	});
};*/


$req.getBearerKey = function(){

	jQuery.ajax($url.bearer, {
		type : 'POST',
		dataType : "json",
		contentType : 'application/x-www-form-urlencoded;charset=UTF-8',
		cache : false,
		headers: {
			'Authorization' : $key.apiKey
		},
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