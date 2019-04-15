<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link href="${pageContext.request.contextPath }/css/style2.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
        .toolbar li {
            background: url('${pageContext.request.contextPath }/images/toolbg.gif') repeat-x;
        }
        .tablelist th {
            background: url('${pageContext.request.contextPath }/images/th.gif') repeat-x;
        }
    </style>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery2.js"></script>
    <script type="text/javascript">
        var i = 1;
        function addseat(){
            if (i == 4) {
                alert("每辆列车最多只能添加3种座位类型！");
                return;
            }
            var str="<tr><td><input name='seatType"+i+"' type='text' class='dfinput' /></td>"
                +"<td><input name='lastTicket"+i+"' type='text' class='dfinput' /></td>"
                +"<td><input name='money"+i+"' type='text' class='dfinput' /></td></tr>"
            i++;
            $("#addseat").append(str);
        }
        var j = 0;
        function addstation(){
            var str="<tr><td><input name='stationList["+j+"].name1' type='text' class='dfinput' /></td>"
                +"<td><input name='stationList["+j+"].time1' type='time' class='dfinput' /></td>"
                +"<td><input name='stationList["+j+"].name2' type='text' class='dfinput' /></td>"
                +"<td><input name='stationList["+j+"].time2' type='time' class='dfinput' /></td>"
                +"<td><select name='stationList["+j+"].isNextDay' class='dfinput'>"
                +"<option value='0'>当天到达</option><option value='1'>次日到达</option></select></td>"
                +"<td><input name='stationList["+j+"].ticket' type='text' class='dfinput' /></td>"
                +"<td><input name='stationList["+j+"].money' type='text' class='dfinput' /></td></tr>"
            j++;
            $("#addstation").append(str);
        }
        function submitForm(){ //新增车辆提交
            if(true){//校验
                $.ajax({
                    url : "http://localhost:8084/train/addTrain",
                    type: "POST",
                    data:$('#addTrainForm').serialize(),
                    success : function(data) {
                        if (data.code == '0000') {
                            alert(data.message);
                            // window.location.reload();//刷新页面，重新加载信息
                        } else {
                            alert(data.message);
                        }
                    },
                    error: function() {
                        alert("出错了，请重试！");
                    }
                });
            } else {
                return false;
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
        <li><a href="">车辆管理</a></li>
        <li><a href="">新增车辆</a></li>
    </ul>
</div>
<div class="rightinfo">
    <div class="formtitle">
        <span>基本信息</span>
    </div>
    <form id="addTrainForm">
        <ul class="forminfo">
            <li><label>车辆编号</label><input name="tid" type="text" class="dfinput" /></li>
            <li><label>车辆类型</label><input name="trainType" type="text" class="dfinput" /></li>
            <li><label>站点总数</label><input name="stacount" type="text" class="dfinput" /></li>
            <li><label>车程耗时</label><input name="runtime" type="text" class="dfinput" /></li>
            <li><label>座位类型</label><span onclick="addseat();">＋添加座位类型</span></li>
            <table class="tablelist" id="addseat">
                <thead>
                <tr>
                    <th>座位类型</th>
                    <th>座位数量</th>
                    <th>座位价格</th>
                </tr>
                </thead>
            </table>

            <li><label>途经站点</label><span onclick="addstation();">＋添加车辆站点</span></li>
            <table class="tablelist" id="addstation">
                <thead>
                <tr>
                    <th>出发站点</th>
                    <th>出发时间</th>
                    <th>抵达站点</th>
                    <th>抵达时间</th>
                    <th>到达日程</th>
                    <th>车票数量</th>
                    <th>区间票价</th>
                </tr>
                </thead>
            </table>
            <div><br/></div>
            <li><input type="button" value="提交" class="btn" onclick="submitForm();"></li>
        </ul>
    </form>
</div>
</body>
</html>
