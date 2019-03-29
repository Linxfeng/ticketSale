<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>订单详情</title>
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
<script type="text/javascript">
$(document).ready(function() { //页面加载执行
	//根据所选择的座位类型显示不同的票价
	$('#stype').change(function() {
		var stype = $(this).children('option:selected').val();
		if (stype == "硬座" || stype == "二等座") {
			var money = "${train.tmoney1 + (train.stacount * 19.8 + 9.9)}";
			var m = money.substring(0,5);
			$("#tmoney").text("￥${train.tmoney1 + (train.stacount * 19.8)}");
			$("#totamoney").text("￥"+m);
		} else if (stype == "硬卧" || stype == "一等座") {
			var money = "${train.tmoney2 + (train.stacount * 19.8 + 9.9)}";
			var m = money.substring(0,5);
			$("#tmoney").text("￥${train.tmoney2 + (train.stacount * 19.8)}");
			$("#totamoney").text("￥"+m);
		} else if (stype == "软卧" || stype == "商务座") {
			var money = "${train.tmoney3 + (train.stacount * 19.8 + 9.9)}";
			var m = money.substring(0,5);
			$("#tmoney").text("￥${train.tmoney3 + (train.stacount * 19.8)}");
			$("#totamoney").text("￥"+m);
		}
	})
})
function checkOrder() { //提交订单，校验
	$("#startTime").val("${requestScope.startDay}"+" "+"${train.stationList[0].stime1}");
	$("#endTime").val("${requestScope.startDay}"+" "+"${train.stationList[1].stime2}");
	var stype = $('#stype').children('option:selected').text();
	$("#stypef").val(stype);
	var money = $("#totamoney").text();
	$("#money").val(money);
	var pid = $("#pid").val();
	if(pid == "" || pid == 0){
		alert("请选择一个乘客！");
		return false;
	} else { 
		return true;
	}
}
function choosep() { //选择已有乘客
	//先清除
	$(".passtemp").remove();
	var uid = ${sessionScope.loginUser.uid};
	$.ajax({
		url : "${pageContext.request.contextPath}/userController/findPassenger.action",
		type : "POST",
		data : {"uid" : uid},
		success : function(returnData) {
			if (returnData != null) {
				var len = returnData.length;
				for(var i=0; i<len; i++){
					var role = "";
					if(returnData[i].role == 0){
						role = "成人票";
					} else {
						role = "学生票";
					}
					var trueName = returnData[i].trueName;
					var idCard = returnData[i].idCard;
					var pid = returnData[i].pid;
					var str = "<div class='collapse' style='display: block;'>"
					+"<div class='hangbanlist-body ' style='background-color: #FEFCFC;'>"
					+"<ul class='list-inline passtemp'><li style='width:12%' class='font16'>"
					+trueName+"</li><li style='width:20%' class='font16'>"
					+"</li><li style='width:20%' class='font16'>"+idCard
					+"</li><li style='width:20%' class='font16'></li>"
					+"<li style='width:18%' class='font16'>"+role
					+"</li><li><a onclick='addChoice(\""
					+trueName+"\",\""+idCard+"\",\""+role+"\",\""+pid+"\");'>选择</a></li></ul></div></div>";
					$("#passinfo").append(str);
				}
			}
		}
	});
}
function addp() { //添加新乘客
	//先清除
	$(".passtemp").remove();
	var str = "<div class='collapse' style='display: block;'>"
		+"<div class='hangbanlist-body ' style='background-color: #FEFCFC;'>"
		+"<ul class='list-inline passtemp'><li style='width:12%' class='font16'>"
		+"<input style='width: 200px;height: 28px;' name='trueName' id='trueName1'></li>"
		+"<li style='width:20%' class='font16'>"
		+"</li><li style='width:20%' class='font16'>"
		+"<input style='width: 200px;height: 28px;' name='idCard' id='idCard1'>"
		+"</li><li style='width:20%' class='font16'></li>"
		+"<li style='width:18%' class='font16'><select name='role' class='form-control input-sm' "
		+"style='width: 100px; display: inline-block;' id='role1'><option  value='0'>成人票</option>"
    	+"<option  value='1'>学生票</option></select></li><li><button onclick='addChoicep();'"
		+" class='btn btn-default'>添加</button></li></ul></div></div>";
	$("#passinfo").append(str);
}
function addChoice(trueName,idCard,role,pid) { //选中乘客
	$(".passtemp").remove();
	$("#trueName").text(trueName);
	$("#idCard").text(idCard);
	$("#role").text(role);
	$("#pid").val(pid);
	//添加保险信息
	$("#baoxianadd").remove();//先清空
	var str = "<div class='collapse' id='baoxianadd' style='display: block;'><div class='hangbanlist-body'"
		+" style='background-color: #FEFCFC;'><ul class='list-inline'><li style='width:12%'>"
		+"<strong class='rmb orange-f60 font16'>"+trueName+"</strong></li><li style='width:20%'>"
		+"<span>铁路安全险 A款</span></li><li style='width:20%'><span>605137820170923</span></li>"
		+"<li style='width:12%'>1份</li><li style='width:20%'><span>待付款</span></li>"
		+"<li style='width:12%' class='font16'><span style='color:#ff0253; font-size:14px; font-weight:bold;'>"
		+"￥9.9</span></li></ul></div></div>";
	$("#baoxiantemp").append(str);
	
}
function addChoicep() { //添加新乘客到乘客列表
	var uid = ${sessionScope.loginUser.uid};
	var trueName = $("#trueName1").val();
	var idCard = $("#idCard1").val();
	var role = $("#role1").find("option:selected").text();
	if(role == "学生票"){
		role = 1;
	} else {
		role = 0;
	}
	//乘客信息校验
	if(trueName == ""){
		alert("请填写乘客姓名！");
		$("#trueName1").focus();
	} else if(idCard == ""){
		alert("请填写乘客身份证号！");
		$("#idCard1").focus();
	} else if(idCard.length != 18){
		alert("请填写正确的身份证号！");
		$("#idCard1").focus();
	} else {
		$.ajax({
			url : "${pageContext.request.contextPath}/userController/addpas.action",
			type : "POST",
			data : {"trueName":	trueName,
					"idCard":idCard,
					"role":role,
					"uid" : uid},
			success : function(returnData) {
				if (returnData != null) {
					var msg = returnData.resmsg;
					alert(msg);
					if(msg == "添加成功！"){
						var pid = returnData.pid;
						if(role == 1){
							role = "学生票";
						} else {
							role = "成人票";
						}
						addChoice(trueName,idCard,role,pid);
					}
				}
			}
		});
	}
}
</script>
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
					<li style="width:12%" class="font16">行程</li>
					<li style="width:20%" class="font16">座位类型</li>
					<li style="width:12%" class="font16">票价</li>
				</ul>
				<!-- 表头结束 -->
				<!-- 表BODY -->
				<div class="collapse " id="collapseExample2" style="display: block;">
					<div class="hangbanlist-body " style="background-color: #FEFCFC;">
						<ul class="list-inline">
							<li style="width:12%"><strong
								class="rmb orange-f60 font16">${requestScope.train.tid}</strong>
							</li>
							<li style="width:20%">
								<span>${requestScope.sname1} / ${train.stationList[0].stime1}</span></li>
							<li style="width:20%">
								<span>${requestScope.sname2} / ${train.stationList[1].stime2}</span></li>
							<li style="width:12%">共 ${train.stacount} 站</li>
							<li style="width:20%">
								<select name='stype' class='form-control input-sm' 
									style='width: 100px; display: inline-block;' id="stype">
						        	<option  value='${train.stype1}'>${train.stype1}</option>
						        	<option  value='${train.stype2}'>${train.stype2}</option>
						        	<option  value='${train.stype3}'>${train.stype3}</option>
					        	</select>
					        </li>
							<li style="width:12%" class="font16"><span id="tmoney" 
								style="color:#ff0253; font-size:14px; font-weight:bold;">
								￥<fmt:formatNumber type="number" value="${train.tmoney1 + (train.stacount * 19.8)}" 
						pattern="0.00" maxFractionDigits="2"/></span></li>
						</ul>
					</div>
				</div>
				<!-- 表BODY 结束 -->
			</div>
		</div>
	</div>
	<!-- 乘客信息 -->
	<h3>乘客信息</h3>
	<div>&nbsp;&nbsp;
    	<input type="button" value="选择已有乘客" class="btn btn-default" onClick="choosep();">&nbsp;
    	<input type="button" value="添加新乘客" class="btn btn-default" onClick="addp();">
   	</div> 
	<div class="container mar-bottom-30 ">
		<div class="hangbanlist">
			<div id="passinfo">
				<!-- 表头 -->
				<ul class="list-inline bor-bottom-solid-1 bg-gray-f5">
					<li style="width:12%" class="font16">乘客姓名:</li>
					<li style="width:20%" class="font16" id="trueName"></li>
					<li style="width:20%" class="font16">身份证号:</li>
					<li style="width:20%" class="font16" id="idCard"></li>
					<li style="width:12%" class="font16">购票类别:</li>
					<li style="width:12%" class="font16" id="role"></li>
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
					<!-- 待选择乘客，自动添加 -->
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
					<li style="width:12%" class="font16">出发日期:</li>
					<li style="width:20%" class="font16">${requestScope.startDay}</li>
					<li style="width:20%" class="font16"></li>
					<li style="width:12%" class="font16"></li>
					<li style="width:20%" class="font16 text-right">订单总价：&nbsp;</li>
					<li style="width:12%" class="font16"><span id="totamoney" 
						style="color:#ff0253; font-size:14px; font-weight:bold;">
						￥<fmt:formatNumber type="number" value="${train.tmoney1 + (train.stacount * 19.8) + 9.9}" 
						pattern="0.00" maxFractionDigits="2"/></span>
					</li>
				</ul>
				<!-- 表头结束 -->
			</div>
		</div>
	</div>
	<!-- 订单信息 -->
	<form action="${pageContext.request.contextPath}/orderController/sureOrder.action" 
		method="post" name="orderForm" >
	<input type="hidden" name="uid" value="${sessionScope.loginUser.uid}">
	<input type="hidden" name="pid" value="" id="pid">
	<input type="hidden" name="tid" value="${requestScope.train.tid}">
	<input type="hidden" name="s_start" value="${requestScope.sname1}">
	<input type="hidden" name="s_end" value="${requestScope.sname2}">
	<input type="hidden" name="startTime" value="" id="startTime">
	<input type="hidden" name="endTime" value="" id="endTime">
	<input type="hidden" name="stype" value="" id="stypef">
	<input type="hidden" name="createTime" value="" id="money">
    <div class="text-center">
    	<a href='javascript:history.go(-1);'><input type="button" value="返回购票" class="btn btn-default">
    	</a><input type="submit" value="提交订单" class="btn btn-default" onClick="return checkOrder();">
   	</div>
   </form>
  </div>
</div>
<!-- main end -->
<!-- 管理模板 结束 -->
</body>
</html>