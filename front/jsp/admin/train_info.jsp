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

.placeul li {
	background: url('${pageContext.request.contextPath }/images/rlist.gif')
		no-repeat right;
}
</style>
<script type="text/javascript"
	src="${pageContext.request.contextPath }/js/jquery2.js"></script>
<script type="text/javascript">
$(document).ready(function() { //页面加载执行
	$.ajax({//加载车次编号下拉框
		url : "${pageContext.request.contextPath }/trainController/getTidList.action",
		type : "POST",
		success : function(returnData) {
			if (returnData != null) {
				var tid = "${tid}";
				for(var i=0; i<returnData.length; i++){
					if(tid == null){//没有指定车次编号
						var trHTML = "<option value="+(i+1)+">"
						+returnData[i]+"</option>";
					} else {//指定了车次编号
						if(returnData[i] == tid){
							var trHTML = "<option value="+(i+1)
							+" selected='selected'>"
							+returnData[i]+"</option>";
						} else {
							var trHTML = "<option value="+(i+1)+">"
							+returnData[i]+"</option>";
						}
					}
					$("#trainTid").append(trHTML);
				}
			}
		}
	});
	
	//根据所选择的车次编号查询车辆信息
	var tid ="${tid}";
	if (tid == "") {
		$("#tipmsg").text("请选择车次！");
		var tr = $("#tbodyid").ChildNode
		$("#tbodyid").remove(tr);
	} else {
		$("#tipmsg").text("");
		var tr = $("#tbodyid").ChildNode
		$("#tbodyid").remove(tr);
		$.ajax({
			url : "${pageContext.request.contextPath }/trainController/getTrainInfoById.action",
			type : "POST",
			data : {"tid" : tid},
			success : function(returnData) {
				if (returnData == null) {// 没查询到结果
					$("#tipmsg").text("未查询到结果！");
				} else {
					var train = returnData.trainMap;
					$("#trainsale").append("<tbody id='tbodyid'>");
					var stationList = train.stationList;
					var satlenth = stationList.length - 1;
					var sname1 = stationList[0].sname1;
					var stime1 = stationList[0].stime1;
					var sname2 = stationList[satlenth].sname2;
					var stime2 = stationList[satlenth].stime2;
					var trHTML = "<tr><td>"+train.ttype
					+"</td><td>"+train.stacount
					+"</td><td>"+sname1+"</td><td>"+stime1
					+"</td><td>"+sname2+"</td><td>"+stime2
					+"</td><td>"+train.runtime
					+"</tr>" ;
					$("#trainsale").append(trHTML);
					$("#trainsale").append("</tbody>");
				}
			}
		});
	}
	
	//根据所选择的车次编号查询车辆信息
	$('#trainTid').change(function() {
		getTrainList();
	});
})
function getTrainList() {
	var tid = $("#trainTid").children('option:selected').val();
	var Tid = $("#trainTid").children('option:selected').text();
	if (tid == 0) {
		$("#tipmsg").text("请选择车次！");
		var tr = $("#tbodyid").ChildNode
		$("#tbodyid").remove(tr);
	} else {
		$("#tipmsg").text("");
		var tr = $("#tbodyid").ChildNode
		$("#tbodyid").remove(tr);
		$.ajax({
			url : "${pageContext.request.contextPath }/trainController/getTrainInfoById.action",
			type : "POST",
			data : {"tid" : Tid},
			success : function(returnData) {
				if (returnData == null) {// 没查询到结果
					$("#tipmsg").text("未查询到结果！");
				} else {
					var train = returnData.trainMap;
					$("#trainsale").append("<tbody id='tbodyid'>");
					var stationList = train.stationList;
					var satlenth = stationList.length - 1;
					var sname1 = stationList[0].sname1;
					var stime1 = stationList[0].stime1;
					var sname2 = stationList[satlenth].sname2;
					var stime2 = stationList[satlenth].stime2;
					var trHTML = "<tr><td>"+train.ttype
					+"</td><td>"+train.stacount
					+"</td><td>"+sname1+"</td><td>"+stime1
					+"</td><td>"+sname2+"</td><td>"+stime2
					+"</td><td>"+train.runtime
					+"</tr>" ;
					$("#trainsale").append(trHTML);
					$("#trainsale").append("</tbody>");
				}
			}
		});
	}
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
			<li><a href="">查看车辆信息</a></li>
		</ul>
	</div>
	<div class="rightinfo">
		<div class="tools">
			<ul class="toolbar">
				<li style="border: none;"><span></span>车次: </li>
			</ul>
			<ul class="toolbar">
				<li><span></span>
			<select class="toolbar" id="trainTid">
				<option value="0">请选择车次</option>
			</select></li>
			</ul>
			<ul class="toolbar">
				<li style="border: none;">
				<span id="tipmsg" style="color: red">请选择车次！</span></li>
			</ul>
		</div>
		
		<table class="tablelist" id="trainsale">
			<thead>
				<tr>
					<th>车辆类型</th>
					<th>途径站次</th>
					<th>始发站</th>
					<th>发车时间</th>
					<th>终点站</th>
					<th>到达时间</th>
					<th>车程历时</th>
				</tr>
			</thead>
		</table>

	</div>
</body>
</html>
