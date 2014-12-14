//로그 클래스
window.START_DATE = (new Date()).getTime();
window.LOG = function(sMsg, sKey, nLevel) {
	sMsg = " [" + jQuery.format.date(new Date(), 'EEE HH:mm:ss.SSS') + (sKey ? '] [' + sKey + '] ' : '] ') + sMsg;
	window.console && window.console.log(sMsg);
// 	jQuery('#debug').prepend('<p>' + sMsg + '</p>');
};

window.DEV = false;


var $USER = {
	id : '',
	theme : 0,
	auto : 0,
	size : 14
};