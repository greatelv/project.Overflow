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

//키워드로부터 API 데이터 조회
$req.getDataFromKeyword = function(){

	//var keyword = keywrod;

	jQuery.ajax($url.search+'?q=생명&callback=?', {
		type : 'get',
		dataType : "jsonp",
		contentType : 'application/json; charset=utf-8',
		cache : false,
		headers: {
			"Authorization": "Bearer AAAAAAAAAAAAAAAAAAAAACO1XQAAAAAAGOCuiOmSA1f0G91jyti4MSgiVCU%3D2dT3lUmQpRUhjNHt84ToblIKTB1CgQpSf6WoeghFUyNTbXXTXG"
		},
		success: function(oRes, sStatus, oXHR){
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