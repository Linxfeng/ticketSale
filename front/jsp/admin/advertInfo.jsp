<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

    <link href="${pageContext.request.contextPath }/css/style2.css"
          rel="stylesheet" type="text/css" />
    <link rel="shortcut icon" type="image/x-icon"
          href="${pageContext.request.contextPath}/images/favicon.ico" />
    <link rel="icon" type="image/x-icon"
          href="${pageContext.request.contextPath}/images/favicon.ico" />

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
    <script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery2.js"></script>
    <script type="text/javascript">
        $(document).ready(function() { //页面加载执行
            function getUrlPara() { //获取当前url参数
                var url = document.location.toString();
                var arrUrl = url.split("?");
                return arrUrl[1].split("=")[1];
            }
            $.ajax({//加载当前公告信息
                url : "http://localhost:8082/advert/advertInfo",
                type : "POST",
                data: {id: getUrlPara()},
                success : function(returnData) {
                    if (returnData.data != null) {
                        advert  = returnData.data
                        $("#title").text(advert.title);
                        $("#createTime").text(advert.createTime);
                        $("#content").val(advert.content);
                    } else {
                        alert(returnData.message);
                    }
                },
                error: function(XMLHttpRequest, textStatus, errorThrown) {
                    alert("出错了，请重试！");
                }
            });
        })
    </script>
</head>

<body>
<!-- <div class="place" style="background:url('${pageContext.request.contextPath }/images/righttop.gif') repeat-x;">
		<span>位置：</span>
		<ul class="placeul">
			<li><a href="${pageContext.request.contextPath}/userController/toIndex1.action"
				title="rightFrame">首页</a></li>
			<li><a href="">广告管理</a></li>
			<li><a href="">新增广告</a></li>
		</ul>
	</div> -->
<div class="formbody">
    <div class="formtitle">
        <span>基本信息</span>
    </div>
    <ul class="forminfo">
        <li><label>广告标题</label><span id="title"></span></li>
        <li><label>发布时间</label><span id="createTime"></span></li>
        <li><label>广告内容</label>
            <textarea name="content" cols="" rows="" class="textinput" disabled="disabled" id="content"></textarea></li>
        <li><label>&nbsp;</label>
            <input type="button" class="btn" value="返回" onclick="window.close();"/></li>
    </ul>
</div>
</body>
</html>
