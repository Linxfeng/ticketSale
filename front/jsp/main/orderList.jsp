<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
 <%@  taglib  prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
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
<title>订单列表</title>
<link href="${pageContext.request.contextPath }/css/bootstrap.min.css"
	rel="stylesheet">
<link href="${pageContext.request.contextPath }/css/common.css"
	rel="stylesheet">
<link href="${pageContext.request.contextPath }/css/corptravel.css"
	rel="stylesheet">
<link href="${pageContext.request.contextPath }/css/enterprise.css"
	rel="stylesheet">
<link href="${pageContext.request.contextPath }/css/orderlist.css"
	rel="stylesheet">
<link href="${pageContext.request.contextPath }/css/headerlog.css" rel="stylesheet">
<!-- IconFont图标 -->
<link href="${pageContext.request.contextPath }/css/iconfont.css"
	rel="stylesheet">
<link rel="shortcut icon" type="image/x-icon"
	href="${pageContext.request.contextPath}/images/favicon.ico" />
<link rel="icon" type="image/x-icon"
	href="${pageContext.request.contextPath}/images/favicon.ico" />
<script type="text/javascript"
	src="${pageContext.request.contextPath }/js/jquery-3.2.1.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath }/js/bootstrap.min.js"></script>
<!-- layer弹框 2.1 -->
<script type="text/javascript"
	src="${pageContext.request.contextPath }/js/layer/layer.js"></script>
</head>

<body class="bg-body">

	<!--header start-->
	<jsp:include page="header.jsp" />
	<!--header end-->
	
	<!--当前位置 开始-->
	<div class="crumbs">
		您现在的位置：
		<a href="${pageContext.request.contextPath}/" shape="rect">首页</a> &nbsp;&gt;&nbsp; 
		<a href="${pageContext.request.contextPath}/userController/tousermessage.action" shape="rect">用户中心</a> &nbsp;&gt;&nbsp; 
		<a href="${pageContext.request.contextPath}/orderController/orderListUi.action" shape="rect">订单管理</a> &nbsp;&gt;&nbsp;
		<a href="" shape="rect">订单列表</a> 
	</div>
	<!--当前位置 结束-->
	<!-- 管理模板 -->
	<div class="container bg-gray-eee box-shadow mar-bottom-30"
		style="padding-right: 0px; padding-left: 0px; position: relative; margin-top: 15px;">

		<!-- main -->
		<div class=""  style="height: 120px;background: white">
			<!-- 引导 -->
			<ol class="breadcrumb">
				<li>首页</li>
				<li>订单管理</li>
				<li class="active">订单列表</li>
			</ol>
			<!-- 引导结束 -->
				<div class="col-sm-4">
					<div class="form-group">
						<label for="apdiv" class="w90 text-right">订单状态</label> 
						<select id="otype" class="form-control input-sm"
							style="width: 200px; display: inline-block;">
							<option value="8">全部订单</option>
							<option value="0">未支付</option>
							<option value="1">已支付</option>
							<option value="2">已出票</option>
							<option value="3"></option>
						</select>
					</div>
	
				</div>
			</div>
			
			<table  id="ordertable" border="0" cellspacing="0" cellpadding="0"
				class="table table-hover table-striped font12 table-bordered v-align-top">
				<thead>
				<tr>
					<th>创建时间</th>
					<th>乘客</th>
					<th>车次</th>
					<th>座位类型</th>
					<th>出发站/出发时间</th>
					<th>到达站/到达时间</th>
					<th>订单总价</th>
					<th style="width: 65px;">订单状态</th>
					<th>操作</th>
				</tr>
				</thead>
			<tbody id = "orderall">
			<c:forEach items="${requestScope.orderList}" var="orders">
				<tr id="${orders.oid}">
					<td>${orders.createTime}</td>
					<td><p>${orders.passenger.trueName}</p></td>
					<td>${orders.tid}</td>
					<td>${orders.stype}</td>
					<td><div class="startbox">

							<div class="startcity">
								<span>${orders.s_start}</span> 火车站<br /> ${orders.startTime}
							</div>
						</div></td>
					<td><div class="startbox">

							<div class="startcity">
								<span>${orders.s_end}</span> 火车站<br /> ${orders.endTime}
							</div>
						</div></td>
					<td>${orders.money }</td>
					<c:if test="${orders.otype == 0}">
						<td>未支付 </td>
					</c:if>
					<c:if test="${orders.otype == 1}">
						<td>已支付 </td>
					</c:if>
					<c:if test="${orders.otype == 2}">
						<td>已出票 </td>
					</c:if>
					
					<c:if test="${orders.otype == 0}">
						<td><a href="${pageContext.request.contextPath}/orderController/toOrderShow.action?oid=${orders.oid}">【查看详情】</a><br> 
						<a href="${pageContext.request.contextPath}/orderController/deleteOrder.action?oid=${orders.oid}" onClick="return confirm('是否确认取消定单？');">【取消订单】</a><br> 
						<a href="${pageContext.request.contextPath}/orderController/listToPay.action?oid=${orders.oid}" onClick="return confirm('是否确认付款？');">【立即支付】</a></td>
					</c:if>
					<c:if test="${orders.otype == 1}">
						<td><a href="${pageContext.request.contextPath}/orderController/toOrderShow.action?oid=${orders.oid}">【查看详情】</a><br>  
						<a href="${pageContext.request.contextPath}/orderController/listToTake.action?oid=${orders.oid}" onClick="return confirm1();">【出 &nbsp; &nbsp; 票】</a></td>
					</c:if>
					<c:if test="${orders.otype == 2}">
						<td><a href="${pageContext.request.contextPath}/orderController/toOrderShow.action?oid=${orders.oid}">【查看详情】</a></td>
					</c:if>
				</tr>
			</c:forEach>
		    </tbody>
		</table>
			<div class="pull-right ">
			<ul class="pagination pagination-sm" style="margin-top: 0px;">
				<li class="disabled"><a href="" aria-label="Previous"><span
						aria-hidden="true">&laquo;</span></a></li>
				<li class="active"><a href="">1 <span class="sr-only">(current)</span></a></li>
				<li><a href="">2</a></li>
				<li><a href="">...</a></li>
				<li><a href="">5</a></li>
				<li><a href="" aria-label="Next"> <span aria-hidden="true">&raquo;</span>
				</a></li>
			</ul>
			<div class="clearfix"></div>
			<div class="clearfix"></div>
		</div>
	</div>
	<!-- main end -->
	<!-- 管理模板 结束 -->

</body>
<script type="text/javascript">
$(document).ready(function() { //页面加载执行
	$('#otype').change(function() {
		f1();
	});
	var msg = "${msg}";
	if(msg != ""){
		alert(msg);
	}
})

function confirm1() {
	if(confirm('是否确认出票？')){
		alert("出票成功！");
		return true;
	} else {
		return false;
	}
}


function f1() { //根据状态查询订单列表
	var otype = $("#otype").val();
	if(otype == 8){
		location.href="${pageContext.request.contextPath}/orderController/orderListUi.action";
	} else {
	var param = {"otype":otype};//参数
	var tr = $("#orderall").ChildNode;
	$("#orderall").remove(tr);
	$.post("${pageContext.request.contextPath}/orderController/findOrderByOtype.action",param,function(returnData){
		//alert(returnData);
		$("#ordertable").append("<tbody id='orderall'>");
		 for(var i = 0;i<returnData.length;i++){
			  if (returnData[i].otype == 0){
				  var otype = "未支付";
				  var STR = "<td><a href='${pageContext.request.contextPath}/orderController/toOrderShow.action?oid="
					+returnData[i].oid+"'>【查看详情】</a><br>"
					+"<a href='javaScript:void(0);' id='deleteOrder' onclick='deleteOrder(\'${orders.oid }\');'>【取消订单】</a><br>" 
					+"<a href='${pageContext.request.contextPath}/orderController/listToPay.action?oid="
					+returnData[i].oid+"' onClick='return confirm(\'是否确认付款？\');'>【立即支付】</a></td>"
			  }
			  if (returnData[i].otype == 1){
				  var otype = "已支付";
				  var STR ="<td><a href='${pageContext.request.contextPath}/orderController/toOrderShow.action?oid="
					+returnData[i].oid+"'>【查看详情】</a><br>"
					+"<a href='${pageContext.request.contextPath}/orderController/listToTake.action?oid="
					+returnData[i].oid+"'>【出      票】</a></td>"
			  }
			  if (returnData[i].otype == 2){
				  var otype = "已出票";
				  var STR ="<td><a href='${pageContext.request.contextPath}/orderController/toOrderShow.action?oid="
					+returnData[i].oid+"'>【查看详情】</a></td>"
			  }
			 var str = "";
			  str += "<tr id="+returnData[i].oid+"}>"
			  + "<td>"+returnData[i].createTime+"</td>"
			  + "<td><p>"+returnData[i].passenger.trueName+"</p></td>"
			  + "<td>"+returnData[i].tid+"</td>"
			  + "<td>"+returnData[i].stype+"</td>"
			  + "<td><div class='startbox'>"
			  + "<div class='startcity'>"
			  + "<span>"+returnData[i].s_start+"</span>"
			  + "火车站<br />"+returnData[i].startTime +"</div></div></td>"
			  + "<td><div class='startbox'>"
			  + "<div class='startcity'>"
			  + "<span>"+returnData[i].s_end+"</span>"
			  + "火车站<br />"+returnData[i].endTime +"</div></div></td>"
		      + "<td>"+returnData[i].money+"</td>"
		      + "<td>"+otype+"</td>"
		      + STR
		      + "</tr>"	
		      $("#orderall").append(str);
		  }
		 $("#ordertable").append("</tbody>");
    });
	}
}
</script>
	
</html>