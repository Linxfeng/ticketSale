<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>网络售票中心</title>
<link href="${pageContext.request.contextPath}/css/global20150101.css"
	rel="stylesheet" type="text/css" />
<link href="${pageContext.request.contextPath}/css/erweima.css"
	rel="stylesheet" type="text/css" />
<link rel="shortcut icon" type="image/x-icon"
	href="${pageContext.request.contextPath}/images/favicon.ico" />
<link rel="icon" type="image/x-icon"
	href="${pageContext.request.contextPath}/images/favicon.ico" />
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/jquery-1.9.1.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/jquery.SuperSlide.2.1.1.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/jquery.bgiframe.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/adKyfw.min.js"
	charset="utf-8"></script>
<script type="text/javascript">
$(document).ready(function() { //页面加载执行
	$.ajax({//加载车次编号下拉框
		url : "${pageContext.request.contextPath }/AdverController/showAllAdvert.action",
		type : "POST",
		success : function(returnData) {
			if (returnData != null) {
				$("#zxdt").append("<ul><li><span class='zxdt_time'></span><a>公 告</a></li>");
				var len = returnData.length;
				 for(var i = 0;i < len;i++){
					 var senddate = "("+returnData[i].sendtime.substring(0,10)+")";
					 var str = "<li><span class='zxdt_time'>"+senddate
						+"</span><a href='${pageContext.request.contextPath}/AdverController/toAdvertInfo.action?aid="
						+returnData[i].aid+"' target='_blank' title='"+returnData[i].title
						+"'>"+returnData[i].title+"</a></li>";
					$("#zxdt").append(str);
				}
				$("#zxdt").append("</ul>");
			}
		}
	});
})
</script>
</head>

<body>
<div id="page" class="clearfix">
	<!--header start-->
	<jsp:include page="top.jsp"></jsp:include>
	<!--header end-->
		<!--erweima-->
		<div id="appDown">
			<div class="erweima" id="erweima" style="display: block;">
				<a class="shutDown" id="shutDown" href="javascript:void(0);"></a>
				<div id="erweimaNews" class="undis">
					<div class="erweimaPic">
						<a href="https://kyfw.12306.cn/otn/appDownload/init"
							target="_blank"><img src="${pageContext.request.contextPath}/images/dynamic.png"
							width="80" height="80" /> </a>
					</div>
					<div class="ft">
						<a href="https://kyfw.12306.cn/otn/appDownload/init"
							target="_blank">手机购票客户端<br> 点击或扫描下载
						</a>
					</div>
				</div>
			</div>
		</div>
		<!--end-->
	
		<div id="indexLeft">
			<div id="newLeft">
				<!--左幻灯片-->
				<div align="center">
					<img alt="加载失败" style='border: 0; width: 192px; height: 192px;'
						src="${pageContext.request.contextPath}/images/ad_left.jpg">
				</div>
				<!--end-->
				<div class="textCenter">
					<a href="http://dynamic.12306.cn/surweb/" target="_blank"><img
						src="${pageContext.request.contextPath}/images/ico_question.gif"
						border="0" width="194"> </a>
				</div>
			</div>

			<div id="newContent" class="">
				<div class="newsTitle">最新动态</div>
				<div class="newH2" id="newContent2">
					<div>
						<marquee width="260" onmouseout="this.start()"
							onmouseover="this.stop()" scrollamount="3" scrolldelay="100"
							style="width: 260px;">
							<font color="blue" style="font-size: 14px;"> </font>
						</marquee>
					</div>
					<div id="zxdt">
						<!-- 异步获取 -->
					</div>
					<div class="textRight">
						<a target="_blank"
							href="http://www.12306.cn/mormhweb/zxdt/index_zxdt.html">更多&gt;&gt;&gt;&nbsp;&nbsp;</a>
					</div>
				</div>
			</div>

			<div id="indexLeftB" class="clearfix">
				<div id="indexLeftBL">
					<ul class="leftItem">
						<li><a href="https://kyfw.12306.cn/otn" target="_blank"><img
								src="${pageContext.request.contextPath }/images/newS.gif" alt=""
								width="194" height="37" border="0"></a></li>
						<li><a class="k1" href="https://kyfw.12306.cn/otn/regist/init" target="_blank">网上购票用户注册</a></li>
						<li><a class="k2" href="https://kyfw.12306.cn/otn/" target="_blank">购票</a></li>
						<li><a class="k11" href="https://kyfw.12306.cn/otn/insurance/init" target="_blank">我的保险</a></li>
						<li><a class="k3" href="https://kyfw.12306.cn/otn/queryOrder/init" target="_blank">退票</a></li>
						<li><a class="k4" href="https://kyfw.12306.cn/otn/leftTicket/init" target="_blank">余票查询</a></li>
						<li><a class="k5" href="https://kyfw.12306.cn/otn/leftTicket/init" target="_blank">旅客列车时刻表查询</a></li>
						<li><a class="k6" href="http://www.12306.cn/mormhweb/kyfw/lczwdcx/">旅客列车正晚点查询</a></li>
						<li><a class="k7" href="https://kyfw.12306.cn/otn/leftTicketPrice/init" target="_blank">票价查询</a></li>
						<li><a class="k8" href="https://kyfw.12306.cn/otn/queryAgencySellTicket/init" target="_blank">客票代售点查询</a></li>
						<li><a class="k10" href="http://www.12306.cn/mormhweb/tlkytst/"><img
								src="${pageContext.request.contextPath}/images/ico_tltel.gif" height="44"></a></li>
					</ul>
				</div>
				<div id="indexLeftBR">
					<div id="search">
						<form id="fmsearch" name="fmsearch" onsubmit="return replaceALL()"
							target="_blank" action="http://dynamic.12306.cn/search/"
							method="post">
							<input id="searchword" name="searchword" type="hidden" value="">
							<span> <strong>全文搜索</strong>:
							</span> <input name="searchwordl" id="searchwordl"
								onfocus="clearSearchText();" type="text" value="请输入搜索条件"
								size="50" style="color: #999"> <input type="image"
								src="${pageContext.request.contextPath}/images/search_submit_1.jpg">
						</form>
					</div>
					<div class="slideTxtBox">
						<div class="hd">
							<ul>
								<li class="on">网上购票常见问题</li>
								<li>铁路常识</li>
								<li>货运办理常见问题</li>
							</ul>
						</div>
						<div class="tempWrap"
							style="overflow: hidden; position: relative; width: 560px">
							<div class="bd"
								style="width: 2240px; left: 0px; position: relative; overflow: hidden; padding: 0px; margin: 0px;">
								<ul style="float: left; width: 540px;">

									<li class="info_item"><a class="k" target="_blank"
										href="http://www.12306.cn/mormhweb/kyfw/question/201703/t20170320_327283.html">
											《铁路旅客信用记录管理办法（试行）》制定依据是什么？ </a></li>

									<li class="info_item"><a class="k" target="_blank"
										href="http://www.12306.cn/mormhweb/kyfw/question/201703/t20170320_327282.html">
											哪些失信行为，将纳入铁路旅客信用信息记录管理？ </a></li>

									<li class="info_item"><a class="k" target="_blank"
										href="http://www.12306.cn/mormhweb/kyfw/question/201703/t20170320_327281.html">
											铁路旅客信用信息记录期限为多长时间？ </a></li>

									<li class="info_item"><a class="k" target="_blank"
										href="http://www.12306.cn/mormhweb/kyfw/question/201703/t20170320_327280.html">
											纳入铁路旅客信用信息，旅客有异议时如何办理？ </a></li>

									<li class="info_item"><a class="k" target="_blank"
										href="http://www.12306.cn/mormhweb/kyfw/question/201703/t20170320_327279.html">
											铁路进站乘车禁止和限制携带物品 </a></li>

									<li class="info_item"><a class="k" target="_blank"
										href="http://www.12306.cn/mormhweb/kyfw/question/201512/t20151207_30751.html">
											旅客持银行卡购票后需退票时，如果银行卡处于挂失、冻结、销卡状态，无法退款怎么办？ </a></li>

									<li class="info_item"><a class="k" target="_blank"
										href="http://www.12306.cn/mormhweb/kyfw/question/201505/t20150511_16561.html">
											身份核验结果有哪几种状态？ </a></li>

									<li class="info_item"><a class="k" target="_blank"
										href="http://www.12306.cn/mormhweb/kyfw/question/201505/t20150511_16559.html">
											如何了解自己的身份信息核验结果？ </a></li>

									<li class="info_item"><a class="k" target="_blank"
										href="http://www.12306.cn/mormhweb/kyfw/question/201505/t20150511_16557.html">
											“已通过”的身份证注册用户如何添加常用联系人（乘车人）？ </a></li>

									<li class="info_item"><a class="k" target="_blank"
										href="http://www.12306.cn/mormhweb/kyfw/question/201506/t20150610_17011.html">
											“已通过”的居民身份证注册用户、常用联系人（乘车人）如何购票？ </a></li>

									<li class="info_item"><a class="k" target="_blank"
										href="http://www.12306.cn/mormhweb/kyfw/question/201505/t20150511_16553.html">
											注册用户、常用联系人（乘车人）核验结果为“待核验”时，怎么办？ </a></li>

									<li class="info_item"><a class="k" target="_blank"
										href="http://www.12306.cn/mormhweb/kyfw/question/201505/t20150511_16551.html">
											持身份证注册用户、常用联系人（乘车人）核验结果为“未通过”时，怎么办？ </a></li>

									<li class="rignt_more"><a
										href="http://www.12306.cn/mormhweb/kyfw/question/">更多&gt;&gt;&gt;
									</a></li>
								</ul>
								<ul style="float: left; width: 540px;">

									<li class="info_item"><a class="k" target="_blank"
										href="http://www.12306.cn/mormhweb/tlcs/201612/t20161217_324822.html">
											在检票进站前丢失实名制车票，如何办理挂失补办手续？ </a></li>

									<li class="info_item"><a class="k" target="_blank"
										href="http://www.12306.cn/mormhweb/tlcs/201612/t20161217_324821.html">
											在列车上丢失实名制车票，列车能够查询到购票信息，如何办理挂失补办手续？ </a></li>

									<li class="info_item"><a class="k" target="_blank"
										href="http://www.12306.cn/mormhweb/tlcs/201612/t20161217_324820.html">
											在列车上丢失实名制车票，列车未查询到购票信息，怎么办？ </a></li>

									<li class="info_item"><a class="k" target="_blank"
										href="http://www.12306.cn/mormhweb/tlcs/201612/t20161217_324819.html">
											在出站检票前丢失实名制车票，怎么办？ </a></li>

									<li class="info_item"><a class="k" target="_blank"
										href="http://www.12306.cn/mormhweb/tlcs/201612/t20161217_324818.html">
											哪些情况不办理实名制车票挂失补办手续？ </a></li>

									<li class="info_item"><a class="k" target="_blank"
										href="http://www.12306.cn/mormhweb/tlcs/201505/t20150512_16663.html">
											车票有哪些种类？ </a></li>

									<li class="info_item"><a class="k" target="_blank"
										href="http://www.12306.cn/mormhweb/tlcs/201505/t20150512_16662.html">
											什么是直达票、通票？ </a></li>

									<li class="info_item"><a class="k" target="_blank"
										href="http://www.12306.cn/mormhweb/tlcs/201505/t20150512_16661.html">
											什么是异地票、联程票和往返票？ </a></li>

									<li class="info_item"><a class="k" target="_blank"
										href="http://www.12306.cn/mormhweb/tlcs/201505/t20150512_16660.html">
											去哪里可以购买车票？ </a></li>

									<li class="info_item"><a class="k" target="_blank"
										href="http://www.12306.cn/mormhweb/tlcs/201505/t20150512_16659.html">
											如何购买优待（惠）车票？ </a></li>

									<li class="info_item"><a class="k" target="_blank"
										href="http://www.12306.cn/mormhweb/tlcs/201505/t20150512_16658.html">
											车票有效期是如何规定的？ </a></li>

									<li class="info_item"><a class="k" target="_blank"
										href="http://www.12306.cn/mormhweb/tlcs/201505/t20150512_16657.html">
											为什么有“硬卧代硬座”和“软卧代软座或二等座”车票？ </a></li>

									<li class="rignt_more"><a
										href="http://www.12306.cn/mormhweb/tlcs/">更多&gt;&gt;&gt; </a>
									</li>
								</ul>
								<ul style="float: left; width: 540px;">

									<li class="info_item"><a class="k" target="_blank"
										href="http://www.12306.cn/mormhweb/hyfw/hyquestion/201306/t20130607_2077.html">
											如何通过拨打12306客服电话办理发货？ </a></li>

									<li class="info_item"><a class="k" target="_blank"
										href="http://www.12306.cn/mormhweb/hyfw/hyquestion/201306/t20130607_2076.html">
											12306网上“我要发货”办理流程是什么？ </a></li>

									<li class="info_item"><a class="k" target="_blank"
										href="http://www.12306.cn/mormhweb/hyfw/hyquestion/201406/t20140630_10869.html">
											12306网上自助办理流程是什么？ </a></li>

									<li class="info_item"><a class="k" target="_blank"
										href="http://www.12306.cn/mormhweb/hyfw/hyquestion/201405/t20140521_10486.html">
											如何使用12306网站货物追踪服务？ </a></li>

									<li class="info_item"><a class="k" target="_blank"
										href="http://www.12306.cn/mormhweb/hyfw/hyquestion/201406/t20140630_10867.html">
											货运服务质量问题投诉渠道有哪些？ </a></li>

									<li class="info_item"><a class="k" target="_blank"
										href="http://www.12306.cn/mormhweb/hyfw/hyquestion/201306/t20130616_2123.html">
											客户自装卸货物的装卸费核收问题？ </a></li>

									<li class="info_item"><a class="k" target="_blank"
										href="http://www.12306.cn/mormhweb/hyfw/hyquestion/201306/t20130607_2080.html">
											铁路货运承运哪些货物？ </a></li>

									<li class="info_item"><a class="k" target="_blank"
										href="http://www.12306.cn/mormhweb/hyfw/hyquestion/201306/t20130607_2079.html">
											提报铁路货运需求有哪几种渠道？ </a></li>

									<li class="info_item"><a class="k" target="_blank"
										href="http://www.12306.cn/mormhweb/hyfw/hyquestion/201306/t20130607_2078.html">
											如何通过拨打铁路货运站受理电话办理发货？ </a></li>

									<li class="info_item"><a class="k" target="_blank"
										href="http://www.12306.cn/mormhweb/hyfw/hyquestion/201306/t20130607_2075.html">
											如何通过铁路货运营业站或营业场所办理发货？ </a></li>

									<li class="info_item"><a class="k" target="_blank"
										href="http://www.12306.cn/mormhweb/hyfw/hyquestion/201306/t20130607_2074.html">
											能够联系铁路人员上门服务办理业务吗？ </a></li>

									<li class="info_item"><a class="k" target="_blank"
										href="http://www.12306.cn/mormhweb/hyfw/hyquestion/201306/t20130607_2073.html">
											什么是“大宗稳定货物”？ </a></li>

									<li class="rignt_more"><a
										href="http://www.12306.cn/mormhweb/hyfw/hyquestion/">更多&gt;&gt;&gt;
									</a></li>
								</ul>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div id="indexRight">
			<!--右幻灯片-->
			<div align="center">
				<img alt="加载失败" style='border: 0; width: 186px; height: 192px;'
					src="${pageContext.request.contextPath}/images/ad_right.jpg">
			</div>
			<!--end-->
			<div id="ljimg">
				<a href="http://hyfw.95306.cn/Hywsyyt"> <img
					src="${pageContext.request.contextPath}/images/ico_hy009.gif"
					width="188" height="95" border="0" alt="点击进入">
				</a>
			</div>
			<div id="shkyimg" style="margin-top: 2px">
				<a href=""> <img
					src="${pageContext.request.contextPath}/images/ico_hy010.gif"
					width="188" height="57" border="0" usemap="#Map" alt="点击进入">
				</a>
			</div>
			<ul class="rightItem">
				<li><a class="h1"
					href="http://hyfw.12306.cn/gateway/DzswNewD2D/Dzsw/action/InfoHystationAction_queryHystationInfoMorInit"
					target="_blank">主要营业站受理服务电话</a></li>
				<li><a class="h3" href="./hyfw/hyckcx/">货运运费查询</a></li>
			</ul>
			<div>
				<img
					src="${pageContext.request.contextPath}/images/ico_link001.gif"
					width="188" height="30">
			</div>
			<div id="linkbg">
				<div
					style="margin: auto; width: 174px; height: 194px; text-align: left; font-size: 9pt; overflow-x: hidden; overflow-y: auto;">
					<ul>
						<li><a href="" target="_blank">中央政府门户网站</a></li>
						<li><a href="" target="_blank">外交部</a></li>
						<li><a href="" target="_blank">发展改革委</a></li>
						<li><a href="" target="_blank">教育部</a></li>
						<li><a href="" target="_blank">科技部</a></li>
						<li><a href="" target="_blank">国家民委</a></li>
						<li><a href="" target="_blank">公安部</a></li>
						<li><a href="" target="_blank">监察部</a></li>
						<li><a href="" target="_blank">铁道部工程交易中心</a></li>
						<li><a href="" target="_blank">北京铁道大厦</a></li>
					</ul>
				</div>
			</div>
		<div id="linkbot"></div>
	</div>
</div>
<jsp:include page="bottom.jsp"/>
</body>
</html>
