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
        function submit() {//修改密码
            if (checkPwd() && checkNewPwd() && checkNewPwd2()) {
                var oldpwd = $("#oldpwd").val();
                var newpwd = $("#newpwd1").val();
                if(oldpwd == newpwd){
                    $("#pwd1").html("新密码不能与原密码相同！");
                    $("#newpwd1").focus();
                    return;
                }
                $.ajax({//保存用户修改的信息
                    url : "http://localhost:8081/user/updatePassword",
                    type : "POST",
                    data : {'oldpwd': oldpwd, 'newpwd': newpwd},
                    success : function(data) {
                        if (data.code == '0000') {
                            alert(data.message);//修改密码成功，跳转到个人中心页面
                            window.location.href='${pageContext.request.contextPath}/jsp/user/usermessage.jsp';
                        } else {
                            alert(data.message);
                        }
                    },
                    error: function() {
                        alert("出错了，请重试！");
                    }
                });
            }
        }
        function checkPwd(){ //原密码校验
            var oldpwd = $("#oldpwd").val();
            if(oldpwd == ""){
                $("#pwd").html("请输入原密码！");
                $("#oldpwd").focus();
                return false;
            } else if((oldpwd.length < 4) || (oldpwd.length > 12)){
                $("#pwd").html("原密码错误！");
                $("#oldpwd").focus();
                return false;
            } else {
                $("#pwd").html("");
                return true;
            }
        }
        function checkNewPwd(){ //新密码校验
            var newpwd1 = $("#newpwd1").val();
            if(newpwd1 == ""){
                $("#pwd1").html("请输入新密码！");
                $("#newpwd1").focus();
                return false;
            } else if((newpwd1.length < 4) || (newpwd1.length > 12)){
                $("#pwd1").html("请输入4-12位的新密码！");
                $("#newpwd1").focus();
                return false;
            } else {
                $("#pwd1").html("");
                return true;
            }
        }
        function checkNewPwd2(){ //确认密码校验
            var newpwd1 = $("#newpwd1").val();
            var newpwd2 = $("#newpwd2").val();
            if(newpwd1 != newpwd2){
                $("#pwd2").html("两次密码输入不一致！");
                $("#newpwd2").focus();
                return false;
            } else {
                $("#pwd2").html("");
                return true;
            }
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
        <a href="${pageContext.request.contextPath}/jsp/user/password.jsp">修改密码</a>
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
            </dl><!--helpNav/-->
        </div><!--contLeft/-->

        <div class="contRight">
            <h2 class="oredrName">修改密码</h2>

            <div class="address" style="display:block">
                <div class="addList">
                    <label><span class="red"  >* </span>原&nbsp;密&nbsp;码:</label>
                    <input type="password" id="oldpwd" onblur="checkPwd();"/>
                    <span id="pwd" style="color: red; text-align: left;"></span>
                </div><!--addList-->

                <div class="addList" >
                    <label><span class="red"  >* </span>新&nbsp;密&nbsp;码:</label>
                    <input type="password" class="vipPwd1" id="newpwd1" onblur="checkNewPwd();"/>
                    <span id="pwd1" style="color: red; text-align: left;"></span>
                </div><!--addList-->

                <div class="addList">
                    <label><span class="red"  >* </span>确认密码:</label>
                    <input type="password" class="vipPwd2" id="newpwd2" onblur="checkNewPwd2();" />
                    <span id="pwd2" style="color: red; text-align: left;"></span>
                </div>

                <div class="addList2">
                    <button style="height:30px;width: 79px; " onclick="submit();">修改</button>
                </div><!--addList2/-->
            </div><!--address/-->
        </div><!--contRight/-->
        <div class="clears"></div>
    </div>


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
