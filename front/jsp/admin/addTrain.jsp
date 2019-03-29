<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="${pageContext.request.contextPath }/css/style2.css" rel="stylesheet" type="text/css" />
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
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery2.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.9.1.min.js"></script>

</head>

<body>
	<div class="place" style="background:url('${pageContext.request.contextPath}/images/righttop.gif') repeat-x;">
		<span>位置：</span>
		<ul class="placeul">
			<li><a href="${pageContext.request.contextPath}/userController/toIndex1.action" 
				title="rightFrame">首页</a></li>
			<li><a href="">车辆管理</a></li>
			<li><a href="">新增车辆</a></li>
		</ul>
	</div>
	<div class="rightinfo">

		<div class="formtitle">
			<span>基本信息</span>
		</div>
		
		<form action="${pageContext.request.contextPath }/trainController/addnewtrain.action">
		<ul class="forminfo">
			<li><label>车辆id</label><input name="tid" type="text" class="dfinput" /></li>
			<li><label>车辆类型</label><input name="ttype" type="text" class="dfinput" /></li>
			<li><label>总站数</label><input name="stacount" type="text" class="dfinput" /></li>
			<li><label>耗时</label><input name="runtime" type="text" class="dfinput" /></li>
			<li><label>座位类型</label><span id="addpas" onclick="addseat();">＋添加座位类型</span></li>
				<table class="tablelist" id="addseat">
					<thead>
					<tr>
						<th>座位类型</th>
						<th>座位数量</th>
						<th>座位价格</th>
					</tr>
					</thead>
				</table>
			
			<li><label>途经站点</label><span id="addpas" onclick="addstation();">＋添加车辆站点</span></li>
				<table class="tablelist" id="addstation">
					<thead>
					<tr>
						<th>从站点出发</th>
						<th>出发时间</th>
						<th>抵达站点</th>
						<th>抵达时间</th>
						<th>车票数量</th>
						<th>区间票价</th>
					</tr>
					</thead>
				</table>
			<li><input type="submit" value="提交" class="btn" ></li>
		</ul>
		</form>
	</div>
</body>

<script type="text/javascript">
var i = 1;
function addseat(){
	var str="<tr><td><input name='stype"+i+"' type='text' class='dfinput' /></td>"      
		+"<td><input name='scount"+i+"' type='text' class='dfinput' /></td>"
		+"<td><input name='tmoney"+i+"' type='text' class='dfinput' /></td></tr>"
		i++;
	$("#addseat").append(str);
}

var j = 0;
function addstation(){
	var str="<tr><td><input name='stationList["+j+"].sname1' type='text' class='dfinput' /></td>"      
		+"<td><input name='stationList["+j+"].stime1' type='text' class='dfinput' /></td>"
		+"<td><input name='stationList["+j+"].sname2' type='text' class='dfinput' /></td>"
		+"<td><input name='stationList["+j+"].stime2' type='text' class='dfinput' /></td>"
		+"<td><input name='stationList["+j+"].ticket' type='text' class='dfinput' /></td>"
		+"<td><input name='stationList["+j+"].tmoney' type='text' class='dfinput' /></td></tr>"	
		j++;
	$("#addstation").append(str);
}
</script>
</html>
