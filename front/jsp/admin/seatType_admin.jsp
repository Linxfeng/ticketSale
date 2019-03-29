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
	
	//页面加载执行-根据所选择的车次编号查询车辆信息
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
						var stype1 = train.stype1;
						var tmoney1 = train.tmoney1;
						var stype2 = train.stype2;
						var tmoney2 = train.tmoney2;
						var stype3 = train.stype3;
						var tmoney3 = train.tmoney3;
						var trHTML = "<tr><td>"+tid+"</td><td><input class='dfinput' name='stype1' value="+stype1+"></td>"
						+"<td><input class='dfinput' name='tmoney1' value="+tmoney1+"></td>"
						+"<td><a href='javascript:void(0);' onclick='modifySeat1(\""+train.tid+"\");'>修改座位类型</a></td>"
						+"<td><a href='javascript:void(0);' onclick='toTrainInfo(\""+train.tid+"\");'>查看车辆信息</a></td></tr>"
						+"<tr><td>"+tid+"</td><td><input class='dfinput' name='stype2' value="+stype2+"></td>"
						+"<td><input class='dfinput' name='tmoney2' value="+tmoney2+"></td>"
						+"<td><a href='javascript:void(0);' onclick='modifySeat2(\""+train.tid+"\");'>修改座位类型</a></td>"
						+"<td><a href='javascript:void(0);' onclick='toTrainInfo(\""+train.tid+"\");'>查看车辆信息</a></td></tr>"
						+"<tr><td>"+tid+"</td><td><input class='dfinput' name='stype3' value="+stype3+"></td>"
						+"<td><input class='dfinput' name='tmoney3' value="+tmoney3+"></td>"
						+"<td><a href='javascript:void(0);' onclick='modifySeat3(\""+train.tid+"\");'>修改座位类型</a></td>"
						+"<td><a href='javascript:void(0);' onclick='toTrainInfo(\""+train.tid+"\");'>查看车辆信息</a></td>"
						+"</tr>" ;
						$("#trainsale").append(trHTML);
					$("#trainsale").append("</tbody>");
				}
			}
		});
	}
	
	//根据所选择的车次编号查询车辆信息
	$('#trainTid').change(function() {
		getTrainInfo();
	});
})
function getTrainInfo() { //查询车辆信息
	var tid = $('#trainTid').children('option:selected').val();
	var Tid = $('#trainTid').children('option:selected').text();
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

						var stype1 = train.stype1;
						var tmoney1 = train.tmoney1;
						var stype2 = train.stype2;
						var tmoney2 = train.tmoney2;
						var stype3 = train.stype3;
						var tmoney3 = train.tmoney3;
						var trHTML = "<tr><td>"+Tid+"</td><td><input class='dfinput' id='stype1' value="+stype1+"></td>"
						+"<td><input class='dfinput' id='tmoney1' value="+tmoney1+"></td>"
						+"<td><a href='javascript:void(0);' onclick='modifySeat1(\""+train.tid+"\");'>修改座位类型</a></td>"
						+"<td><a href='javascript:void(0);' onclick='toTrainInfo(\""+train.tid+"\");'>查看车辆信息</a></td></tr>"
						+"<tr><td>"+Tid+"</td><td><input class='dfinput' id='stype2' value="+stype2+"></td>"
						+"<td><input class='dfinput' id='tmoney2' value="+tmoney2+"></td>"
						+"<td><a href='javascript:void(0);' onclick='modifySeat2(\""+train.tid+"\");'>修改座位类型</a></td>"
						+"<td><a href='javascript:void(0);' onclick='toTrainInfo(\""+train.tid+"\");'>查看车辆信息</a></td></tr>"
						+"<tr><td>"+Tid+"</td><td><input class='dfinput' id='stype3' value="+stype3+"></td>"
						+"<td><input class='dfinput' id='tmoney3' value="+tmoney3+"></td>"
						+"<td><a href='javascript:void(0);' onclick='modifySeat3(\""+train.tid+"\");'>修改座位类型</a></td>"
						+"<td><a href='javascript:void(0);' onclick='toTrainInfo(\""+train.tid+"\");'>查看车辆信息</a></td>"
						+"</tr>" ;
						$("#trainsale").append(trHTML);
					$("#trainsale").append("</tbody>");
				}
			}
		});
	}
}
function modifySeat1(trainTid) {//修改座位类型
	var stype1 = $("#stype1").val();
	var tmoney1 = $("#tmoney1").val();
	var param = {"tid":trainTid,"stype1":stype1,"tmoney1":tmoney1};
	$.post("${pageContext.request.contextPath}/trainController/updateTrainSeatType1.action",
		param,function(returnData){
			var str = returnData.result
			alert(str);
	});
	
}
function modifySeat2(trainTid) {//修改座位类型
	var stype2 = $("#stype2").val();
	var tmoney2 = $("#tmoney2").val();
	var param = {"tid":trainTid,"stype2":stype2,"tmoney2":tmoney2};
	$.post("${pageContext.request.contextPath }/trainController/updateTrainSeatType2.action",
		param,function(returnData){
			var str = returnData.result
			alert(str);
	});
	
	
}
function modifySeat3(trainTid) {//修改座位类型
	var stype3 = $("#stype3").val();
	var tmoney3 = $("#tmoney3").val();
	var param = {"tid":trainTid,"stype3":stype3,"tmoney3":tmoney3};
	$.post("${pageContext.request.contextPath }/trainController/updateTrainSeatType3.action",
		param,function(returnData){
			var str = returnData.result
			alert(str);
	});
	
	
}
function toTrainInfo(trainTid) {//查看车辆信息
	window.location.href = 
		"${pageContext.request.contextPath }/trainController/toTrainInfo.action?tid="
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
			<li><a href="">座位类型管理</a></li>
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
					<th>车次编号</th>
					<th >座位类型</th>
					<th >底价</th>
					<th colspan="2">操作</th>
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
