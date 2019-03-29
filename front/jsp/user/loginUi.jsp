<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en" class="no-js">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>用户登录</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/reset.css">
<link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/supersized.css">
<link href="${pageContext.request.contextPath}/css/corptravel.css" rel="stylesheet">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/style.css">
<link rel="shortcut icon" type="image/x-icon"
	href="${pageContext.request.contextPath}/images/favicon.ico" />
<link rel="icon" type="image/x-icon"
	href="${pageContext.request.contextPath}/images/favicon.ico" />
<!-- Javascript -->
<script src="${pageContext.request.contextPath}/js/jquery-1.9.1.min.js"
	type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/js/supersized.3.2.7.min.js"></script>
<script src="${pageContext.request.contextPath}/js/supersized-init.js"></script>
<script type="text/javascript">
$(document).ready(function() { //页面加载执行
	var msg = "${msgpass}";
	if(msg != ""){
	 alert(msg);
	}
	var msg2 = "${msg}";
	if(msg2 != ""){
	 alert(msg2);
	}
	
	$('#username').blur(function() {
		var name = $("#username").val();
		if(name == null || "" == name){
			$("#name1").html("用户名不能为空!");
			$('#username').focus();
		} else if(name.length <2 || name.length > 12){
			$("#name1").html("用户名长度要求2-12位!");
			$('#username').focus();
		} else {
			$("#name1").html("");
		}
	});
	$('#password').blur(function() {
		var pwd = $("#password").val();
		if(pwd == null || "" == pwd){
			$("#pwd").html("密码不能为空!");
			$('#password').focus();
		} else if(pwd.length <4 || pwd.length > 12){
			$("#pwd").html("密码长度要求4-12位!");
			$('#password').focus();
		} else {
			$("#pwd").html("");
		}
	});
})
function checkLogin() {
	var name = $("#username").val();
	var pwd = $("#password").val();
	if(name == null || "" == name){
		$("#name1").html("用户名不能为空!");
		return false;
	} else if(pwd == null || "" == pwd){
		$("#pwd").html("密码不能为空!");
		return false;
	} else {
		return true;
	}
}
window.onload = function() {
	$(".connect p").eq(0).animate({"left":"0%"}, 600);
	$(".connect p").eq(1).animate({"left":"0%"}, 400);
}
function is_hide(){ $(".alert").animate({"top":"-40%"}, 300) }
function is_show(){ $(".alert").show().animate({"top":"45%"}, 300) }
</script>
</head>

<body>
	<div class="page-container">
		<h1>欢&nbsp;迎&nbsp;登&nbsp;录</h1>
		<form action="${pageContext.request.contextPath }/userController/logIn.action" method="post">
			<div>
				<input type="text" name="userName" class="username" id="username"
					placeholder="用户名" value="${userName}"/>
			</div>
			<div><span id="name1" style="color: red;font: 12px;text-align: left;">${msg}</span>
			</div>
			<div>
				<input type="password" name="password" class="password" id="password" 
					placeholder="密码" value="${password}"/>
			</div><span id="pwd" style="color: red;font: 12px;text-align: left;"></span>
			<button id="submit" type="submit" onclick="return checkLogin();">登&nbsp;录</button>
		</form>
		<div class="connect">
			<p style="color:#ef4300;font:16px;">one man ,&nbsp;&nbsp;one bag
				,&nbsp;&nbsp;one ticket , &nbsp;&nbsp;take you home &nbsp;</p>
			<p style="margin-top: 20px; color: #ef4300;">一个人，一个包，一张火车票，带你回家。</p>
		</div>
	</div>
	<div class="alert" style="display: none">
		<h2>消息</h2>
		<div class="alert_con">
			<p id="ts"></p>
			<p style="line-height: 70px">
				<a class="btn">确定</a>
			</p>
		</div>
	</div>
</body>
</html>
