<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="${pageContext.request.contextPath}/css/style2.css"
	rel="stylesheet" type="text/css" />
<style type="text/css">
.toolbar li {
	background: url('${pageContext.request.contextPath}/images/toolbg.gif')
		repeat-x;
}

.tablelist th {
	background: url('${pageContext.request.contextPath}/images/th.gif')
		repeat-x;
}
</style>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery2.js"></script>
</head>

<body>
	<div class="place" style="background:url('${pageContext.request.contextPath}/images/righttop.gif') repeat-x;">
		<span>位置：</span>
		<ul class="placeul">
			<li><a href="${pageContext.request.contextPath}/userController/toIndex1.action" 
				title="rightFrame">首页</a></li>
			<li><a href="">广告管理</a></li>
			<li><a href="">新增广告</a></li>
		</ul>
	</div>
	<div class="formbody">

		<div class="formtitle">
			<span>基本信息</span>
		</div>

		<form action="${pageContext.request.contextPath }/AdverController/addnewadvert.action">
		<ul class="forminfo">
			<li><label>广告标题</label>
				<input name="title" type="text" class="dfinput" /><i>标题不能超过25个字符</i></li>
			<li><label>广告内容</label> 
				<textarea name="context" cols="" rows="" class="textinput"></textarea></li>
			<li><label>&nbsp;</label>
			  <input type="submit" class="btn" value="确认发布" /></li>
		</ul>
		</form>
	</div>
</body>
</html>
