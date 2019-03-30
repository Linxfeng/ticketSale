<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>网络售票后台管理系统-管理员登陆</title>
	<link rel="shortcut icon" type="image/x-icon"
		  href="${pageContext.request.contextPath}/images/favicon2.ico" />
	<link rel="icon" type="image/x-icon"
		  href="${pageContext.request.contextPath}/images/favicon2.ico" />
	<link href="${pageContext.request.contextPath}/css/style2.css" rel="stylesheet" type="text/css" />
	<script src="${pageContext.request.contextPath}/js/jquery2.js"type="text/javascript"></script>
	<script src="${pageContext.request.contextPath}/js/cloud.js" type="text/javascript"></script>
	<style type="text/css">
		body {
			background-color: #1c77ac;
			background-image: url('${pageContext.request.contextPath}/images/light.png');
			background-repeat: no-repeat;
			background-position: center top;
			overflow: hidden;
		}
	</style>
	<script language="javascript">
		function check() { //提交非空校验
			var name = $("#username").val();
			var pwd = $("#password").val();
			if(name == null || "" == name){
				alert("用户名不能为空!");
				$('#username').focus();
				return false;
			} else if(pwd == null || "" == pwd){
				alert("密码不能为空!");
				$('#password').focus();
				return false;
			} else {
				return true;
			}
		}
		$(function() {
			//提交表单
			$('#submit').click(function() {
				if (check()) {
					$.ajax({
						type: "POST",
						url:"http://localhost:8081/admin/login",
						data:$('#form1').serialize(),
						error: function(data) {
							alert(data.message);
							$('#username').focus();
						},
						success: function(data) {
							window.location.href="../admin/main.jsp"
						}
					});
				}
			});
			$('.loginbox').css({
				'position' : 'absolute',
				'left' : ($(window).width() - 692) / 2
			});
		});
	</script>
</head>

<body>
<div id="mainBody">
	<div id="cloud1" class="cloud"></div>
	<div id="cloud2" class="cloud"></div>
</div>
<div class="logintop">
	<span>欢迎登陆网络售票后台管理系统</span>
</div>
<div class="loginbody">
	<span class="systemlogo"></span>
	<form id="form1">
		<div class="loginbox">
			<ul>
				<li><input name="userName" id="username" type="text" class="loginuser" placeholder="admin"/></li>
				<li><input name="password" id="password" type="password" class="loginpwd" placeholder="密码"/></li>
				<li><input id="submit" type="button" class="loginbtn" value="登录"/><label>
					<input type="checkbox" checked="checked" />记住密码</label>
					<label><a href="">忘记密码？</a></label>
				</li>
			</ul>
		</div>
	</form>
</div>
<div class="loginbm">版权所有 2019 github.com/Linxfeng/，仅供学习交流</div>
</body>
</html>
