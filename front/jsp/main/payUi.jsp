<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>支付成功</title>
<link href="${pageContext.request.contextPath}/css/bootstrap.min.css"
	rel="stylesheet">
<link href="${pageContext.request.contextPath}/css/common.css"
	rel="stylesheet">
<link href="${pageContext.request.contextPath}/css/corptravel.css"
	rel="stylesheet">
<link href="${pageContext.request.contextPath}/css/enterprise.css"
	rel="stylesheet">
<link href="${pageContext.request.contextPath}/css/iconfont.css"
	rel="stylesheet">
<link href="${pageContext.request.contextPath}/css/headerlog.css"
	rel="stylesheet">
<link rel="shortcut icon" type="image/x-icon"
	href="${pageContext.request.contextPath}/images/favicon.ico" />
<link rel="icon" type="image/x-icon"
	href="${pageContext.request.contextPath}/images/favicon.ico" />
<link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/css/common.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/css/corptravel.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/css/enterprise.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/css/iconfont.css" rel="stylesheet">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.9.1.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
</head>
<body>
	<!-- header -->
	<jsp:include page="header.jsp" />
	<!--header end-->

	<div class="container bg-white box-shadow pad-15 mar-bottom-30"
		style="position: relative;">
		<!-- 支付提示 -->
		<div class="tishibox">
			<p class="title">支付已成功!</p>
			<p>
				您可以继续操作：<a href="${pageContext.request.contextPath}/orderController/orderListUi.action">[查看我的订单]</a> <a
					href="./">[返回首页]</a>
			</p>
			<div class="img_fudong">
				<a href="#"><img src="${pageContext.request.contextPath}/images/chenggong2.gif" width="50"
					height="50" border="0" /></a>
			</div>
			<div class="clearfix"></div>
		</div>
		<!-- 支付提示 结束 -->

		<div class="clearfix"></div>
		<div class="text-center mar-bottom-10">
			<input type="button" value="返回" class="btn btn-default "
				onclick="location.href='${pageContext.request.contextPath}/orderController/orderListUi.action'">
		</div>

	</div>


	<!-- 修改联系人弹框 -->
	<div id="contact-info" style="display: none">

		<div class="modal-body">
			<form class="form-horizontal">
				<div class="form-group">
					<label for="inputEmail3" class="col-sm-4 control-label">联系人</label>
					<div class="col-sm-7">
						<input type="text" class="form-control" id="" placeholder="请输入姓名">
					</div>
				</div>
				<div class="form-group">
					<label for="inputPassword3" class="col-sm-4 control-label">手机号</label>
					<div class="col-sm-7">
						<input type="text" class="form-control" id="" placeholder="请输入手机号">
					</div>
				</div>
				<div class="form-group">
					<label for="inputPassword3" class="col-sm-4 control-label">座机号</label>
					<div class="col-sm-7">
						<input type="text" class="form-control" id="" placeholder="请输入座机号">
					</div>
				</div>

			</form>
		</div>

		<div class="modal-footer ">
			<label class="mar-right-30" style="font-weight: normal;"><input
				name="" type="checkbox" value="" checked> 下次继续使用该联系人</label>

			<button type="button" class="btn btn-primary"
				onClick="layer.closeAll()">确 定</button>
			<button type="button" class="btn btn-default"
				onClick="layer.closeAll()">关 闭</button>
		</div>
	</div>

	<!-- 提交订单弹框 -->
	<div id="rev" style="display: none">

		<div class="modal-body">
			<div class="pad-10 ">
				<span class="red"> 您购买的保险份数，少于实际预订乘客人数，请确认是否有乘客遗漏了保险。</span>
			</div>

		</div>

		<div class="modal-footer mar-top-5">

			<button type="button" class="btn btn-primary"
				onClick="layer.closeAll()">返回，核实保险</button>
			<button type="button" class="btn btn-default"
				onClick="location.href='支付.html'">没有问题，继续下一步</button>
		</div>
	</div>
</body>
</html>