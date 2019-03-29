<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html >
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>用户中心</title>
<link type="text/css"
	href="${pageContext.request.contextPath}/css/css.css" rel="stylesheet" />
<link rel="shortcut icon" type="image/x-icon"
	href="${pageContext.request.contextPath}/images/favicon.ico" />
<link rel="icon" type="image/x-icon"
	href="${pageContext.request.contextPath}/images/favicon.ico" />
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/jquery.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/js.js"></script>
<link href="${pageContext.request.contextPath}/css/headerlog.css" rel="stylesheet">
<style type="text/css">
.nav1 li a {
	display: block;
	height: 28px;
	line-height: 28px;
	color: #fff;
	font-size: 14px;
	text-align: center;
}
</style>
<script type="text/javascript">
$(function(){
	var msg = "${msg}";
	if(msg != ""){
	 alert(msg);
	}
})
function f1(){ //确认密码校验
	var newpass1 = $("#newpass1").val();
	var newpass2 = $("#newpass2").val();
	if(newpass1 != newpass2){
		$("#pwd2").html("两次密码输入不一致！");
		$("#newpass2").focus();
	} else {
    	$("#pwd2").html("");
    }
}
function f2(){ //新密码校验
	var oldpass = $("#newpass1").val();
	if(oldpass == ""){
		$("#pwd1").html("请输入新密码！");
		$("#newpass1").focus();
	} else if((oldpass.length < 4) || (oldpass.length > 12)){
		$("#pwd1").html("请输入4-12位的新密码！");
		$("#newpass1").focus();
    } else {
    	$("#pwd1").html("");
    } 
}
function f3(){ //原密码校验
	var oldpass = $("#oldpass").val();
	if(oldpass == ""){
		$("#pwd").html("请输入原始密码！");
		$("#oldpass").focus();
	} else if((oldpass.length < 4) || (oldpass.length > 12)){
		$("#pwd").html("请输入正确的原始密码！");
		$("#oldpass").focus();
    } else {
    	$("#pwd").html("");
    }
}
function submit() {
	var uid = ${sessionScope.loginUser.uid};
	var oldpass = $("#oldpass").val();
	var newpass1 = $("#newpass1").val();
	var newpass2 = $("#newpass2").val();
	if(oldpass == "" || newpass1 == "" || newpass2 == ""){
		$("#pwd1").html("请先输入密码！");
		return false;
	} else { //修改密码
	    var uid = "${sessionScope.loginUser.uid}";
		location.href = "${pageContext.request.contextPath}/userController/updatePass.action?uid="+uid+
		 "&oldpass="+oldpass+"&password="+newpass1;
	}
}
	 
</script>
</head>

<body>

	<!--header start-->
	<div class="header"
		style="background:url('${pageContext.request.contextPath }/images/bg1.png') repeat-x;">
		<div style="z-index: 2000" class="header-bd">
			<a href="http://www.12306.cn/"><span class="logo"
				style="background:url('${pageContext.request.contextPath }/images/logo1.png') 12px 8px no-repeat;">
					中国铁路客户服务中心-客运中心</span> </a>
			<div class="login-info">
				欢迎您： &nbsp;<span style="color:red;">${sessionScope.loginUser.userName}</span>  &nbsp;| &nbsp; 
				<a id="regist_out" href="${pageContext.request.contextPath }/userController/userExit.action">退出</a>
			</div>
			<div class="nav1"
				style="background:url('${pageContext.request.contextPath }/images/bg_nav1.png') right top no-repeat;">
				<ul>
					<li><span style="width: 30px;"></span></li>
					<li><a href="${pageContext.request.contextPath }/">网站首页</a></li>
					<li id="selectYuding"><a
						href="${pageContext.request.contextPath }/trainController/toSearchRout.action">车票预订</a></li>
					<li><a href="${pageContext.request.contextPath }/trainController/toSearchRout.action"
						target="_blank">路线查询</a></li>
					<li style="width: 71px;" id="js-xd" class="nav-guide"><a
						href="${pageContext.request.contextPath }/trainController/toSearchRout.action">余票查询</a></li>
					<li id="selectHelp"><a
						href="${pageContext.request.contextPath }/orderController/orderListUi.action">订单中心</a></li>
				</ul>
			</div>
		</div>
	</div>
	<!--header end-->
 <div class="mianCont">
	<div class="positions">
		当前位置：<a href="${pageContext.request.contextPath}/">首页</a> &gt; 
		<a href="${pageContext.request.contextPath}/userController/tousermessage.action">用户中心</a> &gt;
		<a href="">修改密码</a>
	</div>
	<!--positions/-->
  <div class="cont">
   <div class="contLeft" id="contLeft">
    <h3 class="leftTitle">用户中心</h3>
    <dl class="helpNav vipNav">
     <dt>账户设置</dt>
		<dd>
			<a href="${pageContext.request.contextPath}/userController/tousermessage.action">个人信息</a>
			<a href="${pageContext.request.contextPath}/userController/topassword.action">密码修改</a>
		</dd>
		<dt>信息管理</dt>
	<dd>
		<a href="${pageContext.request.contextPath}/orderController/orderListUi.action">我的订单</a>
		<a href="${pageContext.request.contextPath}/userController/topassenger.action">乘客信息中心</a>
	</dd>
	<dt>客户服务</dt>
	<dd>
		<a href="">网站使用条款</a> 
		<a href="">网站免责声明</a>
		<a href="">在线留言</a>
	</dd>
    </dl><!--helpNav/-->
   </div><!--contLeft/-->
   <div class="contRight">
   <h2 class="oredrName">
    修改密码
    </h2>
    <div class="address" style="display:block">
    <div class="addList">
     <label>原密码:</label>
     <input type="password" id="oldpass" onblur="f3();"/>
     <span id="pwd" style="color: red;font: 12px;text-align: left;"></span>
    </div><!--addList-->
    <div class="addList" >
     <label>新密码:</label>
     <input type="password" class="vipPwd1" id="newpass1" onblur="f2();"/>
     <span id="pwd1" style="color: red;font: 12px;text-align: left;"></span>
    </div><!--addList-->
    <div class="addList">
     <label>确认密码:</label>
     <input type="password" class="vipPwd2" id="newpass2" onblur="f1();" />
     <span id="pwd2" style="color: red;font: 12px;text-align: left;"></span>
    </div><!--addList-->
    <div class="addList2">
     <button style="height:30px;width: 79px; " onclick="submit();">修改</button>
    </div><!--addList2/--><!--addList2/-->
   </div><!--address/-->
   </div><!--contRight/-->
   <div class="clears"></div>
  </div><!--cont/-->
  <div class="inHelp">
   <div class="inHLeft">
    <h4>帮助中心</h4>
    <ul class="inHeList">
     <li><a href="help.html">购票指南</a></li>
     <li><a href="help.html">支付方式</a></li>
     <li><a href="help.html">售后服务</a></li>
     <li><a href="about.html">企业简介</a></li>
    </ul><!--inHeList/-->
   </div><!--inHLeft/-->
   <div class="inHLeft">
    <h4>会员服务</h4>
    <ul class="inHeList">
     <li><a href="reg.html">会员注册</a></li>
     <li><a href="login.html">会员登录</a></li>
     <li><a href="order.html">车票信息</a></li>
     <li><a href="order.html">我的订单</a></li>
    </ul><!--inHeList/-->
   </div><!--inHLeft/-->
   <div class="inHRight">
    <h4>全国统一免费服务热线</h4>
    <div class="telBox">400-0000-0000</div>
    <div class="weibo">
    </div>
   </div><!--inHRight/-->
   <div class="clears"></div>
  </div><!--inHelp/-->
  <div class="footer">
   <p>
   <a href="#">进入铁路官网</a>&nbsp;|&nbsp;
   <a href="index.html">铁路首页</a>&nbsp;|&nbsp;
   <a href="order.html">我的订单</a>&nbsp;|&nbsp;
   <a href="new.html">新闻动态</a>&nbsp;|&nbsp;
   <a href="login.html">会员中心</a>&nbsp;|&nbsp;
   <a href="help.htmll">帮助中心</a>
   </p>
   <div class="foot">浙ICP备 201709 .com  鸿程定制班 版权所有</div>
  </div><!--footer/-->
 </div><!--mianCont/-->
 <a href="#" class="backTop">&nbsp;</a>
</body>
</html>