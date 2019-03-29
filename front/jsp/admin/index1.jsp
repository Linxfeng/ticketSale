<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery2.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/js/common2.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/js/script2.js"></script>
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath }/css/style3.css">
</head>

<body>
	<div class="load_box" style="margin-top: 50px;">
		<div class="login_cg_left" style="padding-left: 210px;">
			<p class="per_name">
				管理员用户: <em class="per_tel">admin</em>
			</p>
			<p class="per_name login_cg">登录成功</p>
			<div style="height: 20px;">&nbsp;</div>
			<p class="tc_js">车辆管理：可以新添加车辆，查看车辆信息，对座位类型和车辆类型进行管理；</p>
			<p class="tc_js">站点管理：管理不同车辆的途径站点，以及到站时间/出站时间的管理；</p>
			<p class="tc_js">车票管理：对不同车辆经过的站点区段进行票价管理和余票数量的控制；</p>
			<p class="tc_js">广告管理：后台可投放广告和优惠活动，以及发送公告/通知等。</p>
			<div style="height: 20px;">&nbsp;</div>
			<!-- 时间插件 -->
			<div align="center">
				<embed wmode="transparent" src="${pageContext.request.contextPath }/images/honehone_clock_wh.swf" 
					quality="high" bgcolor="#ffffff" width="170" height="80" name="honehoneclock" align="middle" 
					allowscriptaccess="always" type="application/x-shockwave-flash" 
					pluginspage="http://www.macromedia.com/go/getflashplayer">
			</div>
		</div>
	</div>
	<div class="foot">浙ICP备 201709 .com  鸿程定制班 版权所有</div>
</body>
</html>