<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
 <%@  taglib  prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="${pageContext.request.contextPath }/css/style2.css"
	rel="stylesheet" type="text/css" />
<script type="text/javascript"
	src="${pageContext.request.contextPath }/js/jquery2.js"></script>
<script type="text/javascript">
function addAdver() {
	location.href="${pageContext.request.contextPath }/AdverController/toAdver.action";
	              
}
function deletethis(aid) {
	$.ajax({//加载车次编号下拉框
		url : "${pageContext.request.contextPath}/AdverController/deleteadvert.action",
		type : "POST",
		data : {"aid" : aid},
		success : function(returnData) {
			if (returnData != null) {
				var msg = returnData.msg;
				alert(msg);
				window.location.href = 
					"${pageContext.request.contextPath}/AdverController/findAllAdvert.action";
			}
		}
	});
}
</script>
</head>

<body>
	<div class="place">
		<span>位置：</span>
		<ul class="placeul">
			<li><a href="${pageContext.request.contextPath}/userController/toIndex1.action" 
				title="rightFrame">首页</a></li>
			<li><a href="">广告管理</a></li>
			<li><a href="">广告管理</a></li>
		</ul>
	</div>
	<div class="rightinfo">
		<div class="tools">
			<ul class="toolbar">
				<li class="click"><span><img src="${pageContext.request.contextPath }/images/t01.png" /></span><span onclick="addAdver();">发布广告</span></li>
			</ul>
		</div>
		<table class="tablelist">
			<thead>
				<tr>
					<th><input name="" type="checkbox" value="" checked="checked" /></th>
					<th>标题</th>
					<th>管理员</th>
					<th>发布时间</th>
					<th colspan="2">操作</th>
				</tr>
			</thead>
			<tbody>
				
				<c:forEach items="${requestScope.advertList}" var="advertList">
				<tr id=${advertList.aid }>
					<td><input name="" type="checkbox" value="" /></td>
					<td>${advertList.title}</td>
					<td>admin</td>
					<td><p>${advertList.sendtime}</p></td>
					<td><a href="${pageContext.request.contextPath}/AdverController/toAdvertInfo.action?aid=${advertList.aid }" 
						class="tablelink">查看</a> </td>
					<td><a href="javascript:void(0);" onclick="deletethis(${advertList.aid});" class="tablelink">删除</a> </td>
					</tr>
				</c:forEach>
				
			</tbody>
		</table>
		<div class="pagin">
			<div class="message">
				共<i class="blue">1256</i>条记录，当前显示第&nbsp;<i class="blue">2&nbsp;</i>页
			</div>
			<ul class="paginList">
				<li class="paginItem"><a href="javascript:;"><span
						class="pagepre"></span></a></li>
				<li class="paginItem"><a href="javascript:;">1</a></li>
				<li class="paginItem current"><a href="javascript:;">2</a></li>
				<li class="paginItem"><a href="javascript:;">3</a></li>
				<li class="paginItem"><a href="javascript:;">4</a></li>
				<li class="paginItem"><a href="javascript:;">5</a></li>
				<li class="paginItem more"><a href="javascript:;">...</a></li>
				<li class="paginItem"><a href="javascript:;">10</a></li>
				<li class="paginItem"><a href="javascript:;"><span
						class="pagenxt"></span></a></li>
			</ul>
		</div>
	</div>
</body>
</html>
