<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="${pageContext.request.contextPath }/css/style2.css"
	rel="stylesheet" type="text/css" />
<style type="text/css">
.toolbar li {
	background: url('${pageContext.request.contextPath }/images/toolbg.gif')
		repeat-x;
}

.tablelist th {
	background: url('${pageContext.request.contextPath }/images/th.gif')
		repeat-x;
}
</style>
<script type="text/javascript"
	src="${pageContext.request.contextPath }/js/jquery2.js"></script>
<script type="text/javascript">
$(document).ready(function() { //页面加载执行
	//页面加载执行-根据所选择的车辆类别显示车辆列表 
	var ttype = "${ttype}";
	if(ttype == null){//没有指定车辆类别
		
	} else {//指定了车辆类别
		getTrainList();
	}
	
	//根据所选择的车辆类别显示车辆列表 
	$('#trainType').change(function() {
		getTrainList();
	});
})

function getTrainList() { //根据所选择的车辆类别显示车辆列表 
	var tid = $('#trainType').children('option:selected').val();
	if (tid == 0) {
		$("#tipmsg").text("请选择车辆类型！");
		var tr = $("#tbodyid").ChildNode
		$("#tbodyid").remove(tr);
	} else {
	var ttype = $('#trainType').children('option:selected').text();
	$("#tipmsg").text("");
	var tr = $("#tbodyid").ChildNode;
	$("#tbodyid").remove(tr);
	$.ajax({
		url : "${pageContext.request.contextPath}/trainController/getTrainList.action",
		type : "POST",
		data : {
			"ttype" : ttype
		},
		success : function(returnData) {
			if (returnData == null) {// 没查询到结果
				$("#tipmsg").text("未查询到结果！");
			} else {
				$("#trainsale").append("<tbody id='tbodyid'>");
				for (var i = 0; i < returnData.length; i++) {
					var trainTid = returnData[i].tid;
					var trHTML = "<tr><td>"+trainTid
					+"</td><td>"+returnData[i].ttype+"</td>"
					+"<td><a href='javascript:void(0);' onclick='toTrainInfo(\""
					+trainTid+"\");'>查看车辆信息</a></td>"
					+"<td><a href='javascript:void(0);' onclick='seatManage(\""
					+trainTid+"\");'>座位类型管理</a></td>"
					+"</tr>" ;
					$("#trainsale").append(trHTML);
				}
				$("#trainsale").append("</tbody>");
			}
		}
	});
	}
}
function modifyTrain(trainTid) {//修改车辆类型
	alert(trainTid);
}
function toTrainInfo(trainTid) {//查看车辆信息
	window.location.href = 
		"${pageContext.request.contextPath}/trainController/toTrainInfo.action?tid="
				+trainTid;
}
function seatManage(trainTid) {//座位类型管理
	window.location.href = 
		"${pageContext.request.contextPath}/trainController/toSeatManage.action?tid="
				+trainTid;
}
</script>
</head>

<body>
	<div class="place" 
	style="background:url('${pageContext.request.contextPath }/images/righttop.gif') repeat-x;">
		<span>位置：</span>
		<ul class="placeul">
			<li><a href="${pageContext.request.contextPath}/userController/toIndex1.action" 
				title="rightFrame">首页</a></li>
			<li><a href="">车辆管理</a></li>
			<li><a href="">车辆类型管理</a></li>
		</ul>
	</div>
	<div class="rightinfo">
		<div class="tools">
			<ul class="toolbar">
				<li style="border: none;"><span></span>车辆类型: </li>
			</ul>
			<ul class="toolbar">
				<li><span></span>
			<select class="toolbar" id="trainType">
				<option value="0">请选择车辆类型</option>
				<option value="1">T-特快</option>
				<option value="2">G-高铁</option>
				<option value="3">D-动车</option>
			</select></li>
			</ul>
			<ul class="toolbar">
				<li style="border: none;">
				<span id="tipmsg" style="color: red">请选择车辆类型！</span></li>
			</ul>
		</div>
		
		<table class="tablelist" id="trainsale">
			<thead>
				<tr>
					<th>车次编号</th>
					<th>车辆类型</th>
					<th colspan="3">操作</th>
				</tr>
			</thead>
		</table>

		<div class="pagin">
			<div class="message">
				共<i class="blue">1</i>页，当前显示第&nbsp;<i class="blue">1&nbsp;</i>页
			</div>
			<ul class="paginList">
				<li class="paginItem"><a href="javascript:;"><span
						class="pagepre"></span></a></li>
				<li class="paginItem current"><a href="javascript:;">1</a></li>
				<li class="paginItem"><a href="javascript:;">2</a></li>
				<li class="paginItem"><a href="javascript:;">3</a></li>
				<li class="paginItem more"><a href="javascript:;">...</a></li>
				<li class="paginItem"><a href="javascript:;"><span
						class="pagenxt"></span></a></li>
			</ul>
		</div>
	</div>
</body>
</html>
