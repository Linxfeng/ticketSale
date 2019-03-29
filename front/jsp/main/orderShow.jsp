<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>确认订单</title>
<link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/css/common.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/css/corptravel.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/css/enterprise.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/css/iconfont.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/css/headerlog.css" rel="stylesheet">
<link rel="shortcut icon" type="image/x-icon"
	href="${pageContext.request.contextPath}/images/favicon.ico" />
<link rel="icon" type="image/x-icon"
	href="${pageContext.request.contextPath}/images/favicon.ico" />
<style type="text/css">
h3 {
    padding-left: 16px;
}
</style>
<script src="${pageContext.request.contextPath }/js/jquery-1.9.1.min.js" 
	type="text/javascript"></script>
</head>
<body class="bg-body">
	<!-- header -->
	<jsp:include page="header.jsp"/>
	<!--header end-->
	<!--当前位置 开始-->
	<div class="crumbs">
		您现在的位置：
		<a href="${pageContext.request.contextPath}/" shape="rect">首页</a> &nbsp;&gt;&nbsp; 
		<a href="${pageContext.request.contextPath}/userController/tousermessage.action" shape="rect">用户中心</a> &nbsp;&gt;&nbsp; 
		<a href="${pageContext.request.contextPath}/orderController/orderListUi.action" shape="rect">订单管理</a> &nbsp;&gt;&nbsp;
		<a href="" shape="rect">订单详情</a> 
	</div>
	<!--当前位置 结束-->
<!-- 管理模板 -->
<div class="container bg-gray-eee box-shadow mar-bottom-30" 
	style="padding-right:0px; padding-left:0px; position:relative; margin-top:20px;">
  <div class="rightCon">
    <!-- 引导 -->
    <ol class="breadcrumb">
      <li>首页</li>
      <li>订单管理</li> 
      <li>订单列表</li>
      <li class="active">订单详情</li>
    </ol>
    <!-- 引导结束 -->
    
    <h3>车辆信息</h3>
    <!-- 列表开始 -->
	<div class="container mar-bottom-30 ">
		<div class="hangbanlist">
			<div>
				<!-- 表头 -->
				<ul class="list-inline bor-bottom-solid-1 bg-gray-f5">
					<li style="width:12%" class="font16">车次</li>
					<li style="width:20%" class="font16">出发站/出发时间</li>
					<li style="width:20%" class="font16">到达站/到达时间</li>
					<li style="width:12%" class="font16"></li>
					<li style="width:20%" class="font16">座位类型</li>
					<li style="width:12%" class="font16"></li>
				</ul>
				<!-- 表头结束 -->
				<!-- 表BODY -->
				<div class="collapse " id="collapseExample2" style="display: block;">
					<div class="hangbanlist-body " style="background-color: #FEFCFC;">
						<ul class="list-inline">
							<li style="width:12%"><strong
								class="rmb orange-f60 font16">${requestScope.order.tid}</strong>
							</li>
							<li style="width:20%">
								<span>${requestScope.order.s_start} / ${requestScope.order.startTime}</span></li>
							<li style="width:20%">
								<span>${requestScope.order.s_end} / ${requestScope.order.endTime}</span></li>
							<li style="width:12%"></li>
							<li style="width:20%">${requestScope.order.stype}</li>
							<li style="width:12%" class="font16"><span></span></li>
						</ul>
					</div>
				</div>
				<!-- 表BODY 结束 -->
			</div>
		</div>
	</div>
	<!-- 乘客信息 -->
	<h3>乘客信息</h3>
	<div class="container mar-bottom-30 ">
		<div class="hangbanlist">
			<div id="passinfo">
				<!-- 表头 -->
				<ul class="list-inline bor-bottom-solid-1 bg-gray-f5">
					<li style="width:12%" class="font16">乘客姓名:</li>
					<li style="width:20%" class="font16">${requestScope.order.passenger.trueName}</li>
					<li style="width:20%" class="font16">身份证号:</li>
					<li style="width:20%" class="font16">${requestScope.order.passenger.idCard}</li>
					<li style="width:12%" class="font16">购票类别:</li>
					<li style="width:12%" class="font16">
						<c:if test="${requestScope.order.passenger.role == 0}">成人票</c:if>
						<c:if test="${requestScope.order.passenger.role == 1}">学生票</c:if>
					</li>
				</ul>
				<!-- 表头结束 -->
			</div>
		</div>
	</div>
	
    <h3>保险信息</h3> 
    <!-- 列表开始 -->
	<div class="container mar-bottom-30 ">
		<div class="hangbanlist">
			<div id="baoxiantemp">
				<!-- 表头 -->
				<ul class="list-inline bor-bottom-solid-1 bg-gray-f5">
					<li style="width:12%" class="font16">姓名</li>
					<li style="width:20%" class="font16">险种</li>
					<li style="width:20%" class="font16">保单号</li>
					<li style="width:12%" class="font16">份数</li>
					<li style="width:20%" class="font16">状态</li>
					<li style="width:12%" class="font16">价格</li>
				</ul>
				<!-- 表头结束 -->
				<!-- 表BODY -->
				<div class='collapse' id='baoxianadd' style='display: block;'>
					<div class='hangbanlist-body' style='background-color: #FEFCFC;'>
						<ul class='list-inline'>
							<li style='width: 12%'><strong class='rmb orange-f60 font16'>
								${requestScope.order.passenger.trueName}</strong></li>
							<li style='width: 20%'><span>铁路安全险 A款</span></li>
							<li style='width: 20%'><span>605137820170923</span></li>
							<li style='width: 12%'>1份</li>
							<li style='width: 20%'><span>待付款</span></li>
							<li style='width: 12%' class='font16'><span
								style='color: #ff0253; font-size: 14px; font-weight: bold;'>￥9.9</span></li>
						</ul>
					</div>
				</div>
				<!-- 表BODY 结束 -->
			</div>
		</div>
	</div>
	<h3>订单信息</h3>
	<!-- 列表开始 -->
	<div class="container mar-bottom-30 ">
		<div class="hangbanlist">
			<div>
				<!-- 表头 -->
				<ul class="list-inline bor-bottom-solid-1 bg-gray-f5">
					<li style="width:12%" class="font16">创建时间:</li>
					<li style="width:20%" class="font16">${requestScope.order.createTime}</li>
					<li style="width:20%" class="font16">订单状态：</li>
					<li style="width:12%" class="font16">未支付</li>
					<li style="width:20%" class="font16 text-right">订单总价：&nbsp;</li>
					<li style="width:12%" class="font16"><span id="totamoney" 
						style="color:#ff0253; font-size:14px; font-weight:bold;">
						￥${requestScope.order.money}</span>
					</li>
				</ul>
				<!-- 表头结束 -->
			</div>
		</div>
	</div>
	<!-- 订单信息 -->
    <div class="text-center">
    	<a href='javascript:history.go(-1);'><input type="button" value="返回" class="btn btn-default"></a>
   	</div>
  </div>
</div>
<!-- main end -->
<!-- 管理模板 结束 -->
</body>
</html>