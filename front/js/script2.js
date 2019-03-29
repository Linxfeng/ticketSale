// http://www.35ui.cn @xiaoming
$(document).ready(function (){
   	
//autoID为false时说明定时函数未启动，启动后则为定时函数的ID
//主要用做保持唯一的定时函数运行
var autoID = false;
		//轮播图
var t=5000;
var m=0;
var n=$('.login_lunbo .l_big li').length

var runSetTimeout = function(){ 
					   autoID = setInterval(function(){
							var i = m++;
							show_n(i)
							m=m>(n-1)?0:m;
						},t);
				 }
				 
$(".login_lunbo .s_num li").hover(
		function(){
		    var homeid = $('.login_lunbo .s_num li').index(this);
			if(autoID !== false){
				clearInterval(autoID);
				autoID = false;		 
			}		   
			show_n(homeid);	 
			
		},function(){
			if(autoID == false){
				runSetTimeout();
			}
	});
	
//鼠标大图上停止	
$(".login_lunbo").hover(function(){
   clearInterval(autoID);			
		},function(){
   runSetTimeout();
	});
	
	
function show_n(i){
       $('.login_lunbo .s_num li').eq(i).addClass('on').siblings('.login_lunbo .s_num li').removeClass('on');	 
       $('.login_lunbo .l_big li').eq(i).fadeIn().siblings('.login_lunbo .l_big li').fadeOut(); 
	 
 }
	
 runSetTimeout();
 
 
 
 //tab切换

	$("#tab_box #tab_menu li").click(function(){
    $(this).addClass("on").siblings().removeClass("on"); 
    $("#tab_box #tab_con").hide().eq($(this).index()).show();
	 });
	//自助服务切换
	$(".uselist_tab .uselist_tabmenu li").click(function(){
    $(this).addClass("on").siblings().removeClass("on"); 
    $(".uselist_tab .uselist_tabcon").hide().eq($(this).index()).show();
	 });
	
	$(".uselist_tab .jilu_menu li").click(function(){
	$(this).addClass("y_cur").siblings() .removeClass("y_cur"); 
	$(".uselist_tab .jilu_con").hide().eq($(this).index()).show();
	 });
	
$(".uselist_box .scott_con").css("top","430px")	;
$(".xm .load_box,.xm .l_left").css("height","700px");	
$("#new").css("height","900px");
$("#new_con").css({"height":"750px"})
$("table.taocan td,table.taocan th").css({"padding":"2px"});


//焦点函数

$(".loginlinput .linput #textfield").focus(function(){ //地址框获得鼠标焦点
 	if($(this).val()==this.defaultValue){                  //得到当前文本框的值 如果符合条件，则清空文本框内容
		$(this).val("");                               //this.defauleValue 就是指当前文本框的默认值
	}
}).blur(function(){                                   //地址框失去鼠标焦点
	if($(this).val()==""){                                //如果符合条件，则设置内容
		$(this).val(this.defaultValue);
	}
});

});

function modify_passwd() {
	alert("尊敬的客户，如您忘记密码，请发送“CZEDUMM”到10086，重置后的密码将以短信形式下发到你的手机；或拨打当地10086客服重置密码");
	return false;
}

function apply_autopwd() {
	var username = $.trim($("#userName").val());

	if ("" == username || "输入手机号码" == username) {
		alert("请输入您的用户名");
		return false;
	}

	if (username.length != 11) {
		alert("请输入您的11位手机号码");
		return false;
	}
	if (isNaN(username)) {
		alert("请输入您的11位手机号码");
		return false;
	}

	$.ajax({
		type : "post",
		url : ctxPath + "/portalApplyPwd.wlan",
		data : "mobile=" + username + "&wlanAcName=" + $("#Wlan_Login input[name='wlanAcName']").val() + "&wlanUserIp=" + $("#Wlan_Login input[name='wlanUserIp']").val()
				+ "&wlanAcIp=" + $("#Wlan_Login input[name='wlanAcIp']").val() + "&ssid=" + $("#Wlan_Login input[name='ssid']").val(),
		beforeSend : function() {
			$("#userName").attr("disabled", true);
			$("#_userPwd").attr("disabled", true);
			$("#userPwd").attr("disabled", true);
			$("#forgetPasswd").attr("disabled", true);
			$("#applyPwd").attr("disabled", true);
			$("#autoLogin").attr("disabled", true);
			$("#loginBtn").attr("disabled", true);
		},
		complete : function() {
			$("#userName").attr("disabled", false);
			$("#_userPwd").attr("disabled", false);
			$("#userPwd").attr("disabled", false);
			$("#forgetPasswd").attr("disabled", false);
			$("#applyPwd").attr("disabled", false);
			$("#autoLogin").attr("disabled", false);
			$("#loginBtn").attr("disabled", false);
		},
		success : function(data) {
			alert(data.message);
		},
		error : function() {
			alert("系统正忙，请稍候再试");
		}
	});
}

function checkField() {
	var myusername = $.trim($("#userName").val());
	var mypassword = $.trim($("#userPwd").val());

	if (myusername == "" || myusername == "输入手机号码") {
		alert("请输入您的用户名");
		return false;
	}

	if (!warnCharsNotInBag(myusername, "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ")) {
		alert("对不起，用户名只能含有数字和英文字符");
		return false;
	}

	if (mypassword == "" || mypassword == "输入固定密码/临时密码") {
		alert("请输入您的密码");
		return false;
	}

	if (!warnCharsInBag(mypassword, "~'!$%^*()+<>=|\\;:,?/#@&`\"[]{}. ")) {
		alert("您输入的静态密码中含有非法字符，空格或（~'!$%^*()+<>=|\\;:,?/#@&`\"[]{}.）");
		return false;
	}

	var vy = readCookie("ALVERIFY");
	if (vy >= vys) {
		var validate = $.trim($("#verifyCode").val());
		if ("" == validate || "输入验证码" == validate) {
			alert("请输入您的验证码");
			return false;
		}
		
		if (!warnCharsNotInBag(validate, "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ")) {
			alert("对不起，验证码只能包含数字和英文字符");
			document.getElementById("verifyCode").value = '';
			return false;
		}
	} else {
		$("#verifyCode").val(""); //如果未显示验证码输入框，需要把输入框清空，否则“输入验证码”字符串会传入后台action中
	}

	if (document.getElementById("autoLogin").checked) {
		document.getElementById("idissaveinfo").value = "1";
	}

	document.getElementById("Wlan_Login").submit();
	document.getElementById("loginBtn").disabled = true;
	document.getElementById("applyPwd").disabled = true;

	var submitInterval = 10;
	setTimeout('submit_disabled_false()', submitInterval * 1000);

	return true;
}

function submit_disabled_false() {
	document.getElementById("loginBtn").disabled = false;
	document.getElementById("applyPwd").disabled = false;
}

function logoutLeave() {
	var timestamp = new Date().getTime();
	$('#formLogout').attr("action", httpBase + ctxPath + "/portalLogout.wlan?isCloseWindow=Y&" + timestamp);
	$('#formLogout').submit();
	alert("下线成功");
}

function logoutBefore() {
	beforeLeave(false);
	logout();
}

function logout() {
	if (window.confirm("请确认下线！")) {
		$("body").attr("onunload", "");
		var timestamp = new Date().getTime();
		$('#formLogout').attr("action", httpBase + ctxPath + "/portalLogout.wlan?isCloseWindow=N&" + timestamp);
		$('#formLogout').submit();
	} else {
		beforeLeave(true);
	}
}

function KeyDown() {
	if ((event.keyCode == 8)||      //屏蔽退格删除键
			(event.keyCode == 114)||
			(event.keyCode == 116)||			//屏蔽 F5 刷新键
			(event.keyCode == 122)) { 			//屏蔽 F12 刷新键
		event.keyCode = 0;
		event.returnValue = false;
	}

	if ((window.event.altKey) && ((window.event.keyCode == 37) || (window.event.keyCode == 39))) { // 屏蔽 Alt + -> 和 Alt+ <-
		event.returnValue = false;
	}

	if (window.event.ctrlKey || (event.shiftKey) && (event.keyCode == 121)) { //屏蔽 Ctrl 键 和 shift+F10
		event.returnValue = false;
	}
}

function warnCharsNotInBag(s, bag) {
	var i;
	var returnString = true;

	for (i = 0; i < s.length; i++) {
		var c = s.charAt(i);

		if (bag.indexOf(c) == -1) {
			returnString = false;
		}
	}

	return returnString;
}

function warnCharsInBag(s, bag) {
	var i;
	var returnString = true;

	for (i = 0; i < s.length; i++) {
		var c = s.charAt(i);

		if (bag.indexOf(c) != -1)
			returnString = false;
	}

	return returnString;
}