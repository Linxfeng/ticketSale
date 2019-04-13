<%@ page contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link rel="shortcut icon" type="image/x-icon"
          href="${pageContext.request.contextPath}/images/favicon2.ico" />
    <link rel="icon" type="image/x-icon"
          href="${pageContext.request.contextPath}/images/favicon2.ico" />
    <title>网络售票后台管理系统</title>
</head>
<frameset rows="88,*" cols="*" frameborder="no" border="0" framespacing="0">
    <frame src="${pageContext.request.contextPath}/jsp/admin/top.jsp" name="topFrame" scrolling="No"
           noresize="noresize" id="topFrame" title="topFrame" />
    <frameset cols="187,*" frameborder="no" border="0" framespacing="0">
        <frame src="${pageContext.request.contextPath}/jsp/admin/left.jsp" name="leftFrame" scrolling="No"
               noresize="noresize" id="leftFrame" title="leftFrame" />
        <frame src="${pageContext.request.contextPath}/jsp/admin/index1.jsp" name="rightFrame" id="rightFrame"
               title="rightFrame" />
    </frameset>
</frameset>
<body>
</body>
</html>