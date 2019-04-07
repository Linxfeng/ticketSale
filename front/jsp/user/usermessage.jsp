<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <%@ include file="head.jsp" %>
    <script type="text/javascript">
        $(document).ready(function() { //页面加载执行
            $.ajax({//加载用户信息
                url : "http://localhost:8081/user/getUserInfo",
                type : "GET",
                success : function(data) {
                    if (data.code == '0000') {
                        user  = data.data
                        $("#username").text(user.username);
                        $("#phone").text(user.phone);
                        $("#address").text(user.address);
                    } else {
                        alert(data.message);
                    }
                },
                error: function() {
                    alert("出错了，请重试！");
                }
            });
        })
        //修改个人信息时设置初始值
        function setValue(){
            $("#newname").val($("#username").text());
            $("#newphone").val($("#phone").text());
            $("#newaddress").val($("#address").text());
        }
        function save(){
            var phonevalue = $("#newphone").val().length;
            if(phonevalue != 11){
                $("#phone1").html("请填写正确的11位手机号码");
                return;
            }else{
                $("#phone1").html("");
            }
            $.ajax({//保存用户修改的信息
                url : "http://localhost:8081/user/updateInfo",
                type : "POST",
                data : {'username': $("#newname").val(),
                    'address': $("#newaddress").val(),
                    'phone' : $("#newphone").val()},
                success : function(data) {
                    if (data.code == '0000') {
                        alert(data.message);
                        window.location.reload();//刷新页面，重新加载信息
                    } else {
                        alert(data.message);
                    }
                },
                error: function() {
                    alert("出错了，请重试！");
                }
            });
        }
    </script>
</head>

<body>
<%@ include file="header.jsp" %>

<div class="mianCont">
    <!--pnt/-->
    <div class="positions">
        当前位置：<a href="${pageContext.request.contextPath}/jsp/main/main.jsp">首页</a> &gt;
        <a href="${pageContext.request.contextPath}/jsp/user/usermessage.jsp">用户中心</a> &gt;
        <a href="${pageContext.request.contextPath}/jsp/user/usermessage.jsp">个人信息</a>
    </div>
    <!--positions/-->
    <div class="cont">
        <div class="contLeft" id="contLeft">
            <h3 class="leftTitle">用户中心</h3>
            <dl class="helpNav vipNav">
                <dt>账户设置</dt>
                <dd>
                    <a href="javascript:void(0);" onclick="window.location.reload();">个人信息</a>
                    <a href="${pageContext.request.contextPath}/jsp/user/password.jsp">密码修改</a>
                </dd>
                <dt>信息管理</dt>
                <dd>
                    <a href="${pageContext.request.contextPath}/orderController/orderListUi.action">我的订单</a>
                    <a href="${pageContext.request.contextPath}/jsp/user/passenger.jsp">乘客信息</a>
                </dd>
                <dt>客户服务</dt>
                <dd>
                    <a href="">网站使用条款</a>
                    <a href="">网站免责声明</a>
                    <a href="">在线留言</a>
                </dd>
            </dl>
            <!--helpNav/-->
        </div>
        <!--contLeft/-->
        <div class="contRight">
            <h1 class="vipName">
                <span></span> <strong class="vipUp" onclick="setValue();">[点击修改个人信息]</strong>
            </h1>
            <table class="vipMy">
                <tr>
                    <th>用户名</th>
                    <th>联系方式</th>
                    <th>收货地址</th>
                </tr>
                <tr>
                    <td id="username"></td>
                    <td id="phone"></td>
                    <td id="address"></td>
                </tr>
            </table>

            <div class="address"> <!--修改个人信息-->
                <div class="addList">
                    <label><span class="red"  >* </span>用&nbsp;户&nbsp;名:</label> <input  type="text" id="newname" class="newname"/>
                </div>

                <div class="addList">
                    <label><span class="red"  >* </span>手机号码:</label> <input  type="text" id="newphone" class="newphone"/>
                    <span id="phone1" style="color: red; text-align: right;"></span>
                </div>

                <div class="addList">
                    <label><span class="red" >* </span>收货地址:</label> <input id="newaddress"	type="text" />
                </div>

                <div class="addList2">
                    <input type="image" src="${pageContext.request.contextPath}/images/baocun.png" width="79" height="30"
                           onclick="save();" />
                </div>
            </div>
            <!--address/-->
        </div>
        <!--contRight/-->
        <div class="clears"></div>
    </div>
    <!--cont/-->

    <%@ include file="footer.jsp" %>
</div>
<!--mianCont/-->
<a href="#" class="backTop">&nbsp;</a>
</body>
</html>
