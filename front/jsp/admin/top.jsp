<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="${pageContext.request.contextPath }/css/style2.css"
	rel="stylesheet" type="text/css" />
<script language="JavaScript"
	src="${pageContext.request.contextPath }/js/jquery2.js"></script>
<script type="text/javascript">
$(function() {
	//顶部导航切换
	$(".nav li a").click(function() {
		$(".nav li a.selected").removeClass("selected")
		$(this).addClass("selected");
	})
})
</script>
</head>

<body
	style="background: url(${pageContext.request.contextPath }/images/topbg.gif) repeat-x;">
	<div class="topleft">
		<a href="${pageContext.request.contextPath }/main.jsp"
			target="_parent"> <img
			src="${pageContext.request.contextPath }/images/logo.png"
			title="系统首页" /></a>
	</div>

	<ul class="nav">
		<li><a class="selected"><img
				src="${pageContext.request.contextPath }/images/icon01.png"
				title="工作台" />
				<h2>工作台</h2></a></li>
		<li><a ><img
				src="${pageContext.request.contextPath }/images/icon02.png"
				title="模型管理" />
				<h2>模型管理</h2></a></li>
		<li><a ><img
				src="${pageContext.request.contextPath }/images/icon03.png"
				title="模块设计" />
				<h2>模块设计</h2></a></li>
		<li><a ><img
				src="${pageContext.request.contextPath }/images/icon04.png"
				title="常用工具" />
				<h2>常用工具</h2></a></li>
		<li><a ><img
				src="${pageContext.request.contextPath }/images/icon05.png"
				title="文件管理" />
				<h2>文件管理</h2></a></li>
		<li><a ><img
				src="${pageContext.request.contextPath }/images/icon06.png"
				title="系统设置" />
				<h2>系统设置</h2></a></li>
	</ul>
	<div class="topright">
		<ul>
			<li><span>管理员：</span>
			<li><span style="color: orange;">admin</span>
			<li><span></span><a href="${pageContext.request.contextPath }/" 
				target="_parent">网站主页</a></li>
			<li><a href="${pageContext.request.contextPath }/userController/adminExit.action" 
				target="_parent">退出</a></li>
		</ul>
	</div>
</body>
</html>