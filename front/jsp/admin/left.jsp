<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="${pageContext.request.contextPath }/css/style2.css"
	rel="stylesheet" type="text/css" />
<script type="text/javascript"
	src="${pageContext.request.contextPath }/js/jquery2.js"></script>
<style type="text/css">
.leftmenu dd {
	background:
		url('${pageContext.request.contextPath }/images/leftmenubg.gif')
		repeat-x;
}

.lefttop span {
	background:
		url('${pageContext.request.contextPath }/images/leftico.png')
		no-repeat;
}

.menuson li.active {
	background: url('${pageContext.request.contextPath }/images/libg.png')
		repeat-x;
}

.menuson li.active i {
	background: url('${pageContext.request.contextPath }/images/sj.png')
		no-repeat;
}
</style>
<script type="text/javascript">
	$(function() {
		//导航切换
		$(".menuson li").click(function() {
			$(".menuson li.active").removeClass("active")
			$(this).addClass("active");
		});

		$('.title').click(function() {
			var $ul = $(this).next('ul');
			$('dd').find('ul').slideUp();
			if ($ul.is(':visible')) {
				$(this).next('ul').slideUp();
			} else {
				$(this).next('ul').slideDown();
			}
		});
	})
</script>
</head>

<body style="background: #f0f9fd;">
	<div class="lefttop"
		style="background:url('${pageContext.request.contextPath}/images/lefttop.gif') repeat-x;">
		<span></span><a href="${pageContext.request.contextPath}/userController/toIndex1.action" 
			target="rightFrame">首页</a>
	</div>

	<dl class="leftmenu"
		style="background:url('${pageContext.request.contextPath}/images/leftline.gif') repeat-y right;">
		<dd>
			<div class="title">
				<span><img
					src="${pageContext.request.contextPath }/images/leftico01.png" /></span>车辆管理
			</div>
			<ul class="menuson">
				<li><cite></cite><a 
					href="${pageContext.request.contextPath }/trainController/toTrainInfo.action" 
						target="rightFrame">查看车辆信息</a><i></i></li>
				<li><cite></cite><a 
					href="${pageContext.request.contextPath }/trainController/toAddTrain.action" 
						target="rightFrame">新增车辆</a><i></i></li>
				<li><cite></cite><a 
					href="${pageContext.request.contextPath }/trainController/toTypeManage.action" 
						target="rightFrame">车辆类型管理</a><i></i></li>
				<li><cite></cite><a 
					href="${pageContext.request.contextPath }/trainController/toSeatManage.action" 
						target="rightFrame">座位类型管理</a><i></i></li>
			</ul>
		</dd>
		<dd>
			<div class="title">
				<span><img src="${pageContext.request.contextPath }/images/leftico02.png" /></span>站点管理
			</div>
			<ul class="menuson">
				<li><cite></cite><a href="${pageContext.request.contextPath }/trainController/toStationManage.action" target="rightFrame">车辆站点/时间管理</a><i></i></li>
			</ul>
		</dd>
		<dd>
			<div class="title">
				<span><img
					src="${pageContext.request.contextPath }/images/leftico03.png" /></span>车票管理
			</div>
			<ul class="menuson">
				<li><cite></cite><a href="${pageContext.request.contextPath }/trainController/toStationTicketManage.action" target="rightFrame">站点余票/票价管理</a><i></i></li>
				
			</ul>
		</dd>
		<dd>
			<div class="title">
				<span><img
					src="${pageContext.request.contextPath }/images/leftico04.png" /></span>广告管理
			</div>
			<ul class="menuson">
				<li><cite></cite><a href="${pageContext.request.contextPath }/AdverController/toAdver.action" target="rightFrame">发放通知/广告</a><i></i></li>
				<li><cite></cite><a href="${pageContext.request.contextPath }/AdverController/findAllAdvert.action" target="rightFrame">广告管理</a><i></i></li>
			</ul>
		</dd>
	</dl>
</body>
</html>