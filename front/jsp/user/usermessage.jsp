<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>用户中心</title>
    <link type="text/css"
          href="${pageContext.request.contextPath }/css/css.css" rel="stylesheet" />
    <link rel="shortcut icon" type="image/x-icon"
          href="${pageContext.request.contextPath}/images/favicon.ico" />
    <link rel="icon" type="image/x-icon"
          href="${pageContext.request.contextPath}/images/favicon.ico" />
    <script type="text/javascript"
            src="${pageContext.request.contextPath }/js/jquery2.min.js"></script>
    <script type="text/javascript"
            src="${pageContext.request.contextPath }/js/js.js"></script>
    <link href="${pageContext.request.contextPath}/css/headerlog.css" rel="stylesheet">
    <style type="text/css">
        .nav1 li a {
            display: block;
            height: 28px;
            line-height: 28px;
            color: #fff;
            font-size: 14px;
            text-align: center;
        }
    </style>
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
<div class="mianCont">
    <!--pnt/-->
    <div class="positions">
        当前位置：<a href="${pageContext.request.contextPath}/">首页</a> &gt;
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
                    <a href="${pageContext.request.contextPath}/userController/topassenger.action">乘客信息中心</a>
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
    <div class="inHelp">
        <div class="inHLeft">
            <h4>帮助中心</h4>
            <ul class="inHeList">
                <li><a href="help.html">购票指南</a></li>
                <li><a href="help.html">支付方式</a></li>
                <li><a href="help.html">售后服务</a></li>
                <li><a href="about.html">企业简介</a></li>
            </ul>
            <!--inHeList/-->
        </div>
        <!--inHLeft/-->
        <div class="inHLeft">
            <h4>会员服务</h4>
            <ul class="inHeList">
                <li><a href="reg.jsp">会员注册</a></li>
                <li><a href="login.jsp">会员登录</a></li>
                <li><a href="order.html">购票信息</a></li>
                <li><a href="order.jsp">我的订单</a></li>
            </ul>
            <!--inHeList/-->
        </div>
        <!--inHLeft/-->
        <div class="inHRight">
            <h4>全国统一免费服务热线</h4>
            <div class="telBox">400-0000-0000</div>
        </div>
        <!--inHRight/-->
        <div class="clears"></div>
    </div>
    <!--inHelp/-->
    <div class="footer">
        <p>
            <a href="#">进入铁路官网</a>&nbsp;|&nbsp; <a href="index.jsp">铁路首页</a>&nbsp;|&nbsp;
            <a href="order.jsp">我的订单</a>&nbsp;|&nbsp; <a href="new.html">新闻动态</a>&nbsp;|&nbsp;
            <a href="login.html">会员中心</a>&nbsp;|&nbsp; <a href="help.htmll">帮助中心</a>
        </p>
        <div class="foot">京ICP备15003716号-3 版权所有© 2017售票系统.com</div>
    </div>
    <!--footer/-->
</div>
<!--mianCont/-->
<a href="#" class="backTop">&nbsp;</a>
</body>
</html>
