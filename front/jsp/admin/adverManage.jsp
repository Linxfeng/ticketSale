<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link href="${pageContext.request.contextPath }/css/style2.css" rel="stylesheet" type="text/css"/>
    <script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery2.js"></script>
    <script type="text/javascript">
        $(document).ready(function () { //页面加载执行
            $.ajax({ //加载车次编号下拉框
                url: "http://localhost:8082/advert/listAdvert",
                type: "GET",
                success: function (data) {
                    if (data.code == '0000') {
                        $("#advertTable").append("<tbody id='tbodyid'>");
                        var advertList = data.data;
                        for (var i = 0; i < advertList.length; i++) {
                            if (advertList[i].del == 0) {
                                var delStr = "有效";
                            } else {
                                var delStr = "无效";
                            }
                            var trHTML = "<tr id=" + advertList[i].id + "><td>" + advertList[i].title
                                + "</td><td>" + advertList[i].createTime + "</td><td id=status_" + advertList[i].id + ">"
                                + delStr + "</td><td><a href='${pageContext.request.contextPath}/jsp/admin/advertInfo.jsp?id="
                                + advertList[i].id + "' target='_blank' class='tablelink'>查看</a></td><td>"
                                + "<a href='javascript:void(0);' onclick='deletethis(" + advertList[i].id
                                + ");' class='tablelink'>删除</a></td></tr>";
                            $("#advertTable").append(trHTML);
                        }
                        $("#advertTable").append("</tbody>");
                    } else {
                        alert(data.message);
                    }
                },
                error: function () {
                    alert("出错了，请重试！");
                }
            });
        })

        //新增公告
        function addAdver() {
            window.location.href = "../admin/addAdver.jsp";
        }

        //删除某条公告
        function deletethis(aid) {
            if (confirm("是否确认删除？")) {
                $.ajax({
                    url: "http://localhost:8082/advert/deleteAdvert",
                    type: "POST",
                    data: {"id": aid},
                    success: function (data) {
                        if (data.code == '0000') {
                            alert(data.message);
                            //状态改为无效
                            $("#status_" + aid).text("无效");
                        } else {
                            alert(data.message);
                        }
                    },
                    error: function () {
                        alert("出错了，请重试！");
                    }
                });
            }
        }
    </script>
</head>

<body>
<div class="place">
    <span>位置：</span>
    <ul class="placeul">
        <li><a href="${pageContext.request.contextPath}/userController/toIndex1.action"
               title="rightFrame">首页</a></li>
        <li><a href="">公告管理</a></li>
        <li><a href="">公告管理</a></li>
    </ul>
</div>
<div class="rightinfo">
    <div class="tools">
        <ul class="toolbar">
            <li class="click"><span><img src="${pageContext.request.contextPath }/images/t01.png"/></span><span
                    onclick="addAdver();">发布广告</span></li>
        </ul>
    </div>
    <table class="tablelist" id="advertTable">
        <thead>
        <tr>
            <th>公告标题</th>
            <th>发布时间</th>
            <th>是否有效</th>
            <th colspan="2">操作</th>
        </tr>
        </thead>
    </table>
</div>
</body>
</html>
