<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>网页无法访问</title>
<link href="${pageContext.request.contextPath }/css/global.css" rel="stylesheet"
	type="text/css">
<link href="${pageContext.request.contextPath }/css/err.css" rel="stylesheet" type="text/css">
<style type="text/css">
html, body {
	background: #fff;
}
</style>
</head>
<body>
	<div class="err_text">
		<ul id="error">
			<li id="err_top"></li>
			<li id="err_bot">页面无法访问，请您重试一下！
				<div class="time">
					<script language="javascript">
						function initArray() {
							for (i = 0; i < initArray.arguments.length; i++)
								this[i] = initArray.arguments[i];
						}
						var isnMonths = new initArray("1月", "2月", "3月", "4月",
								"5月", "6月", "7月", "8月", "9月", "10月", "11月",
								"12月");
						var isnDays = new initArray("星期日", "星期一", "星期二", "星期三",
								"星期四", "星期五", "星期六", "星期日");
						today = new Date();
						hrs = today.getHours();
						min = today.getMinutes();
						sec = today.getSeconds();
						clckh = "" + ((hrs > 12) ? hrs - 12 : hrs);
						clckm = ((min < 10) ? "0" : "") + min;
						clcks = ((sec < 10) ? "0" : "") + sec;
						clck = (hrs >= 12) ? "下午" : "上午";
						var stnr = "";
						var ns = "0123456789";
						var a = "";

						function getFullYear(d) {
							yr = d.getYear();
							if (yr < 1000)
								yr += 1900;
							return yr;
						}

						document.write(getFullYear(today) + "年"
								+ isnMonths[today.getMonth()] + today.getDate()
								+ "日" + " " + clckh + ":" + clckm + ":" + clcks
								+ " " + isnDays[today.getDay()]);
					</script>
				</div>
			</li>
		</ul>
	</div>
</body>
</html>