<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <!-- IE 浏览器运行最新的渲染模式-->
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <!-- 启用响应式特性 -->
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- 双核使用webkit内核 -->
    <meta name="renderer" content="webkit">
    <title>火车票售票系统</title>
    <link href="${pageContext.request.contextPath }/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath }/css/common.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath }/css/corptravel.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath }/css/enterprise.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath }/css/iconfont.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath }/css/headerlog.css" rel="stylesheet">
    <link rel="shortcut icon" type="image/x-icon" href="${pageContext.request.contextPath}/images/favicon.ico"/>
    <link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/images/favicon.ico"/>
    <script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery-3.2.1.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath }/js/bootstrap.min.js"></script>
    <!-- layer弹框 2.1 -->
    <script type="text/javascript" src="${pageContext.request.contextPath }/js/layer/layer.js"></script>
    <!-- 日历控件 -->
    <script type="text/javascript" src="${pageContext.request.contextPath }/js/My97DatePicker/WdatePicker.js"></script>
    <script type="text/javascript">
        $(document).ready(function () { //页面加载执行
            //填充当天日期
            $("#startDay").val(getDate());
            $("#startDay").blur(function () {//校验出发日期
                checkDate();
            })
        })

        //限购30天
        function limitDate30(nowDate) {
            var currentdate = getDate();
            var sDate1 = Date.parse(currentdate);
            var sDate2 = Date.parse(nowDate);
            var dateSpan = Math.abs(sDate2 - sDate1);
            var iDays = Math.floor(dateSpan / (24 * 3600 * 1000));
            if (sDate2 - sDate1 < 0) return false;
            if (iDays > 31) return false;
            return true;
        }

        //获取当前日期，格式：xxxx-xx-xx
        function getDate() {
            var date = new Date();//获得当前日期
            var seperator1 = "-";
            var year = date.getFullYear();
            var month = date.getMonth() + 1;
            var strDate = date.getDate();
            if (month >= 1 && month <= 9) {
                month = "0" + month;
            }
            if (strDate >= 0 && strDate <= 9) {
                strDate = "0" + strDate;
            }
            return year + seperator1 + month + seperator1 + strDate;
        }

        //查询直达车
        function goSearch() {
            var sname1 = $("#startStation").val();
            var sname2 = $("#endStation").val();
            if (checkStation(sname1, sname2) && checkDate()) {//校验参数
                $.ajax({
                    url: "http://localhost:8084/train/goSearch",
                    type: "POST",
                    data: {"name1": sname1, "name2": sname2},
                    success: function (data) {
                        if (data.code == '0000') {
                            var trainList = data.data;
                            for (var i = 0; i < trainList.length; i++) {
                                var train = trainList[i];
                                var trHTML = "<!-- 表头 --><ul class='list-inline bor-bottom-solid-1'><li class='w-percentage-20'>"
                                    + "<strong class='rmb orange-f60 font16'>" + train.tid + "</strong></li><li class='w-percentage-20  font16'>"
                                    + train.stationList[0].name1 + "&nbsp;—&nbsp;" + train.stationList[1].name2 + "</li><li class='w-percentage-25  font16'>"
                                    + train.stationList[0].time1 + "&nbsp;—&nbsp;" + train.stationList[1].time2 + "</li><li class='w-percentage-25'>共 "
                                    + train.stationSum + " 站</li><li><button type='button' class='btn btn-danger btn-sm' onClick='toBuy(\""
                                    + train.tid + "," + train.stationList[0].name1 + "," + train.stationList[1].name2 + "\");'>购票</button></li></ul><!-- 表头结束 -->"
                                    + "<!-- 表BODY --><div class='collapse ' id='collapseExample2' style='display: block;'><div class='hangbanlist-body ' "
                                    + "style='background-color: #FEFCFC;'><ul class='list-inline'><li class='w-percentage-20'>座位类型/余票</li><li class='w-percentage-20'>"
                                    + train.seatType1 + "：" + train.lastTicket1 + "票</li><li class='w-percentage-25'>" + train.seatType2 + "：" + train.lastTicket2 + "票</li>"
                                    + "<li class='w-percentage-25'>" + train.seatType3 + "：" + train.lastTicket3 + "票</li><li class='pull-right'>&nbsp;</li></ul>"
                                    + "<ul class='list-inline'><li class='w-percentage-20'>普通票价/<span class='rmb orange-f60'>优惠价</span></li><li "
                                    + "class='w-percentage-20'>￥" + train.money1 + " / <strong class='rmb orange-f60'>￥" + train.money1 * 0.75 + "</strong></li>"
                                    + "<li class='w-percentage-25'>￥" + train.money2 + " / <strong class='rmb orange-f60'>￥" + train.money2 * 0.75 + "</strong></li>"
                                    + "<li class='w-percentage-25 '>￥" + train.money3 + " / <strong class='rmb orange-f60'>￥" + train.money3 * 0.75 + "</strong></li>"
                                    + "<li class='pull-right'>&nbsp;</li></ul></div></div><!-- 表BODY 结束 -->";
                                $("#trainListDiv").append(trHTML);
                            }
                            $("#routListDiv").removeAttr("hidden");//显示列表
                        } else {
                            alert(data.message);
                        }
                    },
                    error: function () {
                        alert("出错了，请重试！");
                    }
                });
            } else {
                alert($("#tipmsg").text());
                return;
            }
        }

        function changeSearch() { //换乘车查询
            // var sname1 = $("#startStation").val();
            // var sname2 = $("#endStation").val();
            // window.location.href = "${pageContext.request.contextPath }/trainController/changeSearch.action?sname1="
            // 		+sname1+"&sname2="+sname2;
        }

        function toBuy(tid, sname1, sname2) { //购票
            var startDay = $("#startDay").val();
            window.location.href = "${pageContext.request.contextPath}/orderController/toOrderInfo.action?tid="
                + tid + "&sname1=" + sname1 + "&sname2=" + sname2 + "&type=1" + "&startDay=" + startDay;
        }

        //校验出发/到达城市
        function checkStation(sname1, sname2) {
            if (sname1 == "") {
                $("#tipmsg").text("请填写出发城市！");
                $('#sname1').focus();
                ;
                return false;
            }
            if (sname2 == "") {
                $("#tipmsg").text("请填写到达城市！");
                $('#sname2').focus();
                ;
                return false;
            }
            $("#tipmsg").text("");
            return true;
        }

        //校验出发日期
        function checkDate() {
            var startDay = $("#startDay").val();
            if (startDay == "") {
                $("#tipmsg").text("请填写出发日期！");
                return false;
            } else {
                $("#tipmsg").text("");
            }
            //限购30天
            if (limitDate30(startDay)) {
                $("#tipmsg").text("");
            } else {
                $("#tipmsg").text("请填写正确的日期，限购30天！");
                return false;
            }
            return true;
        }
    </script>
</head>
<body class="bg-body">
<!--header start-->
<jsp:include page="header.jsp"></jsp:include>
<!--header end-->
<!--当前位置 开始-->
<div class="crumbs">
    <div class="form-group mar-left-10">
        您现在的位置：<a href="" shape="rect">首页</a> &nbsp;&gt;&nbsp;
        <a href="" shape="rect">路线查询</a>
    </div>
</div>
<!--当前位置 结束-->
<!-- 搜索 -->
<!-- 搜索结束 -->
<div class="crumbs">
    <form class="form-inline" style="width: 1140px;">
        <div class="form-group mar-left-10">
            <label>出发城市：</label>
            <input type="text" class="form-control"
                   style="width: 85px;" id="startStation" value="苏州" name="name1">
        </div>
        <div class="form-group">
            <label>&nbsp;&nbsp;</label>
        </div>
        <div class="form-group">
            <label>到达城市：</label>
            <input type="text" class="form-control" style="width: 85px;" id="endStation" value="南京" name="name2">
        </div>
        <div class="form-group mar-left-10">
            <label>出发日期：</label>
            <input type="text" class="form-control" style="width: 110px;" id="startDay" onClick="WdatePicker()">
        </div>
        <div class="form-group mar-left-10">
            <label>车型：</label>
            <select id="dropAirlines" class="form-control" style="width: 120px;">
                <option value="0">请选择</option>
                <option value="K-快车">K-快车</option>
                <option value="T-特快">T-特快</option>
                <option value="G-高铁">G-高铁</option>
                <option value="D-动车">D-动车</option>
                <option value="Z-直达">Z-直达</option>
                <option value="普通列车">普通列车</option>
            </select>
        </div>&nbsp;&nbsp;&nbsp;&nbsp;
        <button type="button" class="btn btn-danger btn-sm" onclick="goSearch();">直达车查询</button>
        &nbsp;&nbsp;&nbsp;&nbsp;
        <button type="button" class="btn btn-danger btn-sm" onclick="changeSearch();">换乘车查询</button>
        &nbsp;<span id="tipmsg" style="color: red;width: 80px;">&nbsp;</span>
    </form>
</div>
<!-- 搜索结束 -->

<!-- 列表开始 -->
<div class="container mar-bottom-30" id="routListDiv" hidden>
    <div class="hangbanlist">
        <div id="trainListDiv"></div>
        <!-- 分页 -->
        <!-- <div class=" pull-right ">
        <ul class="pagination">
        <li><a href="#" > <span>&laquo;</span>
        </a></li>
        <li><a href="#">1</a></li>
        <li><a href="#">2</a></li>
        <li><a href="#">3</a></li>
        <li><a href="#">4</a></li>
        <li><a href="#">5</a></li>
        <li><a href="#"> <span>&raquo;</span></a></li>
        </ul>
        </div> -->
        <!-- 分页结束 -->
    </div>
</div>
<!-- 列表结束 -->
</body>
</html>
