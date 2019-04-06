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
<%@ include file="header.jsp" %>
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

    <!--footer -->
    <%@ include file="footer.jsp" %>
    <!--footer/ -->
</div>
<!--mianCont/-->
<a href="#" class="backTop">&nbsp;</a>
</body>
</html>
