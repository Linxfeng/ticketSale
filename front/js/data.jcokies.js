(function ($) {
	jQuery.extend({
		//方便统一名字 各处调用
		jc_getFromStation:function(){
			return $.jc_getcookie("_jc_save_fromStation");
		},
		//text：站名  code:站码
        jc_setFromStation:function(text,code){
        	if("undefined" == typeof(text)||"undefined" == typeof(code)||
        			"" == text||"" == code){
				throw "参数错误";
			}
        	var _value=text+','+code;
        	$.jc_setcookie("_jc_save_fromStation",_value,365*24*60*60);
		},
		jc_getToStation:function(){
			return $.jc_getcookie("_jc_save_toStation");
		},
		//text：站名  code:站码
        jc_setToStation:function(text,code){
        	if("undefined" == typeof(text)||"undefined" == typeof(code)||
        			"" == text||"" == code){
				throw "参数错误";
			}
        	var _value=text+','+code;
        	$.jc_setcookie("_jc_save_toStation",_value,365*24*60*60);
		},
		jc_getFromDate:function(){
			return $.jc_getcookie("_jc_save_fromDate");
		},
        jc_setFromDate:function(text){
        	if("undefined" == typeof(text)){
        		text="";
			}
        	var _value=text;
        	$.jc_setcookie("_jc_save_fromDate",_value,365*24*60*60);
		},
		jc_getToDate:function(){
			return $.jc_getcookie("_jc_save_toDate");
		},
        jc_setToDate:function(text){
        	if("undefined" == typeof(text)){
        		text="";
			}
        	var _value=text;
        	$.jc_setcookie("_jc_save_toDate",_value,365*24*60*60);
		},
		//往返 
		jc_getWfOrDc:function(){
			return $.jc_getcookie("_jc_save_wfdc_flag");
		},
        jc_setWfOrDc:function(text){
        	if("undefined" == typeof(text)){
        		throw "参数错误";
			}
        	var _value=text;
        	$.jc_setcookie("_jc_save_wfdc_flag",_value,365*24*60*60);
		},
		jc_getcookie:function(name){
		   var cookie_start = document.cookie.indexOf(name);
		   var cookie_end = document.cookie.indexOf(";", cookie_start);
		   return cookie_start == -1 ? '' : unescape(document.cookie.substring(
					cookie_start + name.length + 1,
					(cookie_end > cookie_start ? cookie_end
							: document.cookie.length)));	
		   
		   
		},
		jc_setcookie:function(cookieName, cookieValue, seconds, path, domain,secure) {
		   var expires = new Date();
		   expires.setTime(expires.getTime() + seconds * 1000);
		   document.cookie = escape(cookieName) + '=' + escape(cookieValue)
				  + (expires ? '; expires=' + expires.toGMTString() : '')
				  + (path ? '; path=' + path : ';path=/')
				  + (domain ? '; domain=' + domain : '')
				  + (secure ? '; secure' : '');
		}
	});
})(jQuery);
