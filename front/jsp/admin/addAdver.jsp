<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link href="${pageContext.request.contextPath}/css/style2.css" rel="stylesheet" type="text/css"/>
    <style type="text/css">
        .toolbar li {
            background: url('${pageContext.request.contextPath}/images/toolbg.gif') repeat-x;
        }

        .tablelist th {
            background: url('${pageContext.request.contextPath}/images/th.gif') repeat-x;
        }
    </style>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery2.js"></script>
    <script type="text/javascript">
        function submitForm() { //新增公告表单提交
            if (checkWordLen() && checkForm()) {//校验表单
                $.ajax({
                    url: "http://localhost:8082/advert/addAdvert",
                    type: "POST",
                    data: $('#advertForm').serialize(),
                    success: function (data) {
                        if (data.code == '0000') {
                            alert(data.message);
                            //刷新当前页面
                            window.location.href = "../admin/addAdver.jsp";
                        } else {
                            alert(data.message);
                        }
                    },
                    error: function () {
                        alert("出错了，请重试！");
                    }
                });
            } else {
                return false;
            }
        }

        function checkForm() { //校验表单
            if ($("#advertTitle").val() == null || $("#advertTitle").val() == "") {
                alert("公告标题不能为空");
                return false;
            }
            if ($("#advertText").val() == null || $("#advertText").val() == "") {
                alert("公告内容不能为空");
                return false;
            }
            return true;
        }

        //校验标题长度
        function checkWordLen() {
            var titleWord = $("#advertTitle").val();
            if (titleWord.length > 25) {
                document.getElementById("tipmsg").style.color = "red";
                return false;
            } else {
                document.getElementById("tipmsg").style.color = "";
                return true;
            }
        }
    </script>
</head>

<body>
<div class="place"
     style="background:url('${pageContext.request.contextPath }/images/righttop.gif') repeat-x;">
    <span>位置：</span>
    <ul class="placeul">
        <li><a href="${pageContext.request.contextPath}/jsp/admin/index1.jsp"
               title="rightFrame">首页</a></li>
        <li><a href="">广告管理</a></li>
        <li><a href="">新增广告</a></li>
    </ul>
</div>

<div class="formbody">
    <div class="formtitle">
        <span>基本信息</span>
    </div>

    <form id="advertForm">
        <ul class="forminfo">
            <li><label>公告标题</label>
                <input name="title" id="advertTitle" type="text" class="dfinput" style="width:360px;"
                       onblur="checkWordLen();"/>
                <i id="tipmsg">标题不能超过25个字符</i></li>
            <li><label>公告内容</label>
                <textarea name="content" cols="" rows="" class="textinput" id="advertText"></textarea></li>
            <li><label>&nbsp;</label>
                <input type="button" class="btn" value="确认发布" onclick="submitForm();"/></li>
        </ul>
    </form>
</div>
</body>
</html>
