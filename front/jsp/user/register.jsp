<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>用户注册</title>
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
	var msg = "${msg}";
	if(msg != ""){
	 alert(msg);
	}
	function checkName() {
		var name = $("#username").val();
		if(name == null || "" == name){
			$("#name1").html("用户名不能为空!");
			$('#username').focus();
			return false;
		} else if(name.length <2 || name.length > 12){
			$("#name1").html("用户名长度要求2-12位!");
			$('#username').focus();
			return false;
		} else {
			$("#name1").html("");
			return true;
		}
	}
	function checkPwd() {
		var pwd = $("#password").val();
		if(pwd == null || "" == pwd){
			$("#pwd").html("密码不能为空!");
			$('#password').focus();
			return false;
		} else if(pwd.length <4 || pwd.length > 12){
			$("#pwd").html("密码长度要求4-12位!");
			$('#password').focus();
			return false;
		} else {
			$("#pwd").html("");
			return true;
		}
	}
	function checkPhone() {
		var phone = $("#phone").val();
		if(phone == null || "" == phone){
			$("#phone1").html("手机号码不能为空!");
			$('#phone').focus();
			return false;
		} else if(phone.length != 11){
			$("#phone1").html("请正确输入11位手机号码!");
			$('#phone').focus();
			return false;
		} else {
			$("#phone1").html("");
			return true;
		}
	}
	// $('#address').blur(function() {
	// 	var address = $("#address").val();
	// 	if(address == null || "" == pwd){
	// 		$("#address1").html("地址不能为空!");
	// 		$('#address').focus();
	// 	} else {
	// 		$("#address1").html("");
	// 	}
	// });
	$('#username').blur(function() {
		checkName();
	});
	$('#password').blur(function() {
		checkPwd();
	});
	$('#phone').blur(function() {
		checkPhone();
	});
	//提交表单
	$('#submit').click(function() {
		if (checkName() && checkPwd() && checkPhone()) {
			$.ajax({  
				type: "POST",
				url:"http://localhost:8081/user/register",
				data:$('#form1').serialize(),
				error: function(data) {
					alert(data.message);  
				},
				success: function(data) {
					alert(data.message);
					// window.location.href="跳转页面"  
				}
			});
		}
	});
})
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
		<h1>用&nbsp;&nbsp;户&nbsp;&nbsp;注&nbsp;&nbsp;册</h1>
		<form id="form1">
			<div>
				<input type="text" name="username"  id="username" placeholder="请输入用户名" />
			</div>
			<div><span id="name1" style="color: red;font: 12px;text-align: left;"></span></div>
			<div>
				<input type="password" name="password" placeholder="请输入密码" id="password" />
			</div><span id="pwd" style="color: red;font: 12px;text-align: left;"></span>
			<div>
    			<input type="text" name="phone" id="phone" placeholder="请输入联系电话"/>
			</div>
			<span id="phone1" style="color: red;font: 12px;text-align: left;"></span>
			<div>
    			<input type="text" name="address" id="address" placeholder="请输入收货地址"/>
			</div>
			<span id="address1" style="color: red;font: 12px;text-align: left;"></span>
			<button id="submit" type="button">注&nbsp;册</button>
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
