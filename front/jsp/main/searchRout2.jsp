<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- IE 浏览器运行最新的渲染模式-->
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<!-- 启用响应式特性 -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- 双核使用webkit内核 -->
<meta name="renderer" content="webkit">
<title>火车票售票系统</title>
<link href="${pageContext.request.contextPath }/css/bootstrap.min.css" rel="stylesheet">
<link href="${pageContext.request.contextPath }/css/common.css" rel="stylesheet">
<link href="${pageContext.request.contextPath }/css/corptravel.css" rel="stylesheet">
<link href="${pageContext.request.contextPath }/css/enterprise.css" rel="stylesheet">
<link href="${pageContext.request.contextPath }/css/iconfont.css" rel="stylesheet">
<link href="${pageContext.request.contextPath }/css/headerlog.css" rel="stylesheet">
<link rel="shortcut icon" type="image/x-icon"
	href="${pageContext.request.contextPath}/images/favicon.ico" />
<link rel="icon" type="image/x-icon"
	href="${pageContext.request.contextPath}/images/favicon.ico" />
<script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery-1.9.1.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/js/bootstrap.min.js"></script>
<!-- layer弹框 2.1 -->
<script type="text/javascript" src="${pageContext.request.contextPath }/js/layer/layer.js"></script>
<!-- 日历控件 -->
<script type="text/javascript" src="${pageContext.request.contextPath }/js/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript">
$(document).ready(function() { //页面加载执行
	$("#startDay").blur(function() {//校验出发日期
		var startDay = $("#startDay").val();
		if(startDay == ""){
			$("#tipmsg").text("请填写出发日期！");
		} else {
			$("#tipmsg").text("");
		}
		var date = new Date();//获得当前日期
        var seperator1 = "-";
        var year = date.getFullYear();
        var month = date.getMonth() + 1;
        var strDate = date.getDate();
        if (month >= 1 && month <= 9) {
            month = "0" + month;
        }
        if (strDate >= 0 && strDate <= 9) {
            strDate = "0" + strDate;
        }
        var currentdate = year+seperator1+month+seperator1+strDate;
		var limitDate = "2017-10-30";
		var d1 = new Date(startDay.replace("/\-/g", "\/"));  
		var d = new Date(currentdate.replace("/\-/g", "\/"));
		var d2 = new Date(limitDate.replace("/\-/g", "\/"));
		if(d1 < d){
			$("#tipmsg").text("请填写正确的出发日期！");
		} else if(d1 > d2){
			$("#tipmsg").text("限购30天之内的车票！");
		} else {
			$("#tipmsg").text("");
		}
	})
})
function goSearch() {//查询直达车
	var sname1 = $("#startStation").val();
	var sname2 = $("#endStation").val();
	window.location.href = "${pageContext.request.contextPath }/trainController/goSearch.action?sname1="
			+sname1+"&sname2="+sname2;
}
function changeSearch() {//换乘车查询
	var sname1 = $("#startStation").val();
	var sname2 = $("#endStation").val();
	window.location.href = "${pageContext.request.contextPath }/trainController/changeSearch.action?sname1="
			+sname1+"&sname2="+sname2;
}
function toBuy(tid) {//购票
	var sname1 = "${requestScope.sname1}";
	var sname2 = "${requestScope.sname2}";
	var startDay = $("#startDay").val();
	window.location.href="${pageContext.request.contextPath}/orderController/toOrderInfo.action?tid="
			+tid+"&sname1="+sname1+"&sname2="+sname2+"&type=2"+"&startDay="+startDay;
}
</script>
</head>
<body class="bg-body">
	<!--header start-->
	<jsp:include page="header.jsp"></jsp:include>
	<!--header end-->
	<!--当前位置 开始-->
	<div class="crumbs"><div class="form-group mar-left-10">
		您现在的位置：<a href="" shape="rect">首页</a> &nbsp;&gt;&nbsp;
		<a href="购票" shape="rect">路线查询</a></div>
	</div>
	<!--当前位置 结束-->
	<!-- 搜索 -->
	<!-- 搜索结束 -->
	<div class="crumbs">
		<form class="form-inline">
			<div class="form-group mar-left-10">
				<label>出发城市：</label>
				<c:choose>
					<c:when test="${requestScope.sname1 != null}">
						<input type="text" class="form-control"
							style="width: 85px;" id="startStation" value="${requestScope.sname1}" name="snam1">
					</c:when>
					<c:otherwise>
						<input type="text" class="form-control"
							style="width: 85px;" id="startStation" value="苏州" name="snam1">
					</c:otherwise>
				</c:choose>
			</div>
			<div class="form-group">
				<label for="">&nbsp;&nbsp;</label>
			</div>
			<div class="form-group">
				<label for="">到达城市：</label><c:choose>
					<c:when test="${requestScope.sname2 != null}">
						<input type="text" class="form-control"
							style="width: 85px;" id="endStation" value="${requestScope.sname2}" name="snam2">
					</c:when>
					<c:otherwise>
						<input type="text" class="form-control"
							style="width: 85px;" id="endStation" value="南京" name="snam2">
					</c:otherwise>
				</c:choose>
			</div>
			<div class="form-group mar-left-10">
				<label for="">出发日期：</label> <input type="text" class="form-control "
					style="width: 110px;" id="startDay" value="2017-09-30" onClick="WdatePicker()">
			</div>
			<div class="form-group mar-left-10">
				<label for="">车型：</label>
				<select id="dropAirlines" class="form-control"
					style="width: 120px;">
					<option value="0">全部车型</option>
					<option value="D-动车">D-动车</option>
					<option value="T-特快">T-特快</option>
					<option value="G-高铁">G-高铁</option>
				</select>
			</div>&nbsp;&nbsp;&nbsp;&nbsp;
			<button type="button" class="btn btn-danger btn-sm" onclick="goSearch();">直达车查询
			</button>&nbsp;&nbsp;&nbsp;&nbsp;
			<button type="button" class="btn btn-danger btn-sm" onclick="changeSearch();">换乘车查询</button>
			&nbsp;<span id="tipmsg" style="color: red;width: 80px;">&nbsp;</span>
		</form>
	</div>
	<!-- 搜索结束 -->

	<!-- 列表开始 -->
	<div class="container mar-bottom-30 ">
		<div class="hangbanlist">
			<div>
				<c:if test="${resultList[0].train1.tid != null}">
				<c:forEach var="resmap" items="${resultList}">
				<ul class="list-inline bor-bottom-solid-1  ">
					<li class="w-percentage-20"><strong
						class="rmb font16">换乘路线：</strong></li>
					<li class="w-percentage-20  font16">${requestScope.sname1}&nbsp;
						—&nbsp;${requestScope.sname2}</li>
					<li class="w-percentage-25  font16">${resmap.train1.stationList[0].stime1}&nbsp;
						—&nbsp;${resmap.train2.stationList[0].stime2}</li>
					<li class="w-percentage-20  font16">共 ${resmap.train1.stacount} 站</li>
					<li class="font16">换乘站： ${resmap.changeState}</li>
				</ul>
				<!-- 表头 -->
				<ul class="list-inline bor-bottom-solid-1  ">
					<li class="w-percentage-20"><strong
								class="rmb orange-f60 font16">${resmap.train1.tid}</strong></li>
					<li class="w-percentage-20  font16">${requestScope.sname1}&nbsp;—</li>
					<li class="w-percentage-25  font16">${resmap.train1.stationList[0].stime1}&nbsp;—</li>
					<li class="w-percentage-25">&nbsp;</li>
					<li><button type="button" class="btn btn-danger btn-sm" 
						onClick="toBuy('${resmap.train2.tid}');">
						购票</button></li>
				</ul>
				<!-- 表头结束 -->
				<!-- 表BODY -->
				<div class="collapse " id="collapseExample2" style="display: block;">
					<div class="hangbanlist-body " style="background-color: #FEFCFC;">
						<ul class="list-inline">
							<li class="w-percentage-20">座位类型/余票</li>
							<li class="w-percentage-20">${resmap.train1.stype1}： ${resmap.train1.scount1}票</li>
							<li class="w-percentage-25">${resmap.train1.stype2}： ${resmap.train1.scount2}票</li>
							<li class="w-percentage-25">${resmap.train1.stype3}： ${resmap.train1.scount3}票</li>
							<li class="pull-right">&nbsp;</li>
						</ul>
						<ul class="list-inline">
							<li class="w-percentage-20">普通票价/<span
								class="rmb orange-f60">优惠价</span></li>
							<li class="w-percentage-20">￥${resmap.train1.tmoney1} / <strong
								class="rmb orange-f60">￥${resmap.train1.tmoney1 * 0.75}</strong></li>
							<li class="w-percentage-25">￥${resmap.train1.tmoney2} / <strong
								class="rmb orange-f60">￥${resmap.train1.tmoney2 * 0.75}</strong></li>
							<li class="w-percentage-25 ">￥${resmap.train1.tmoney3} / <strong
								class="rmb orange-f60">￥${resmap.train1.tmoney3 * 0.75}</strong></li>
							<li class="pull-right">&nbsp;</li>
						</ul>
					</div>
				</div>
				<!-- 表BODY 结束 -->
				<!-- 表头 --><!-- 换乘车 -->
				<ul class="list-inline bor-bottom-solid-1  ">
					<li class="w-percentage-20"><strong
								class="rmb orange-f60 font16">${resmap.train2.tid}</strong></li>
					<li class="w-percentage-20  font16">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;—&nbsp;${requestScope.sname2}</li>
					<li class="w-percentage-25  font16">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;—&nbsp;
						${resmap.train2.stationList[0].stime2}</li>
					<li class="w-percentage-25">共 ${resmap.train2.stacount} 站</li>
					<li><button type="button" class="btn btn-danger btn-sm" 
						onClick="toBuy('${resmap.train2.tid}');">
						购票</button></li>
				</ul>
				<!-- 表头结束 -->
				<!-- 表BODY -->
				<div class="collapse " id="collapseExample2" style="display: block;">
					<div class="hangbanlist-body " style="background-color: #FEFCFC;">
						<ul class="list-inline">
							<li class="w-percentage-20">座位类型/余票</li>
							<li class="w-percentage-20">${resmap.train2.stype1}：${resmap.train2.scount1}票</li>
							<li class="w-percentage-25">${resmap.train2.stype2}：${resmap.train2.scount2}票</li>
							<li class="w-percentage-25">${resmap.train2.stype3}：${resmap.train2.scount3}票</li>
							<li class="pull-right">&nbsp;</li>
						</ul>
						<ul class="list-inline">
							<li class="w-percentage-20">普通票价/<span
								class="rmb orange-f60">优惠价</span></li>
							<li class="w-percentage-20">￥${resmap.train2.tmoney1} / <strong
								class="rmb orange-f60">￥${resmap.train2.tmoney1 * 0.75}</strong></li>
							<li class="w-percentage-25">￥${resmap.train2.tmoney2} / <strong
								class="rmb orange-f60">￥${resmap.train2.tmoney2 * 0.75}</strong></li>
							<li class="w-percentage-25 ">￥${resmap.train2.tmoney3} / <strong
								class="rmb orange-f60">￥${resmap.train2.tmoney3 * 0.75}</strong></li>
							<li class="pull-right">&nbsp;</li>
						</ul>
					</div>
				</div>
				<!-- 表BODY 结束 -->
				</c:forEach></c:if>
			</div>
			<!-- 分页 -->
			<!-- <div class=" pull-right ">
			<ul class="pagination">
				<li><a href="#" > <span>&laquo;</span>
				</a></li>
				<li><a href="#">1</a></li>
				<li><a href="#">2</a></li>
				<li><a href="#">3</a></li>
				<li><a href="#">4</a></li>
				<li><a href="#">5</a></li>
				<li><a href="#"> <span>&raquo;</span></a></li>
			</ul>
			</div> -->
			<!-- 分页结束 -->
		</div>
	</div>
	<!-- 列表结束 -->
</body>
</html>
