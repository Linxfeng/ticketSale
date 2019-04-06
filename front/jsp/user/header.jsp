<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!--header start-->
<div class="header"
	 style="background:url('${pageContext.request.contextPath }/images/bg1.png') repeat-x;">
	<div style="z-index: 2000" class="header-bd">
		<a href="http://www.12306.cn/"><span class="logo"
											 style="background:url('${pageContext.request.contextPath }/images/logo1.png') 12px 8px no-repeat;">
					中国铁路客户服务中心-客运中心</span> </a>
		<div class="login-info">
			欢迎您： &nbsp;<span style="color:red;">${sessionScope.loginUser.userName}</span>  &nbsp;| &nbsp;
			<a id="regist_out" href="${pageContext.request.contextPath }/userController/userExit.action">退出</a>
		</div>
		<div class="nav1"
			 style="background:url('${pageContext.request.contextPath }/images/bg_nav1.png') right top no-repeat;">
			<ul>
				<li><span style="width: 30px;"></span></li>
				<li><a href="${pageContext.request.contextPath }/">网站首页</a></li>
				<li id="selectYuding"><a
						href="${pageContext.request.contextPath }/trainController/toSearchRout.action">车票预订</a></li>
				<li><a href="${pageContext.request.contextPath }/trainController/toSearchRout.action"
					   target="_blank">路线查询</a></li>
				<li style="width: 71px;" id="js-xd" class="nav-guide"><a
						href="${pageContext.request.contextPath }/trainController/toSearchRout.action">余票查询</a></li>
				<li id="selectHelp"><a
						href="${pageContext.request.contextPath }/orderController/orderListUi.action">订单中心</a></li>
			</ul>
		</div>
	</div>
</div>
<!--header end-->