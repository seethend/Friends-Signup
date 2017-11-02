<html>
<head>
	<%@ page import = "java.io.*,java.util.*,java.sql.*"%>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix = "sql" %>
	<title>Logout</title>
	<link rel="stylesheet" type="text/css" href="content/styles/homepage.css">
	<link rel="icon" type="image/png" href="images/logo.png">
</head>
<body>

	<sql:setDataSource var="snapshot" driver="${initParam.DB_DRIVER}" url="${initParam.DB_URL}" user="${initParam.DB_USER}" password="${initParam.DB_PASS}"/>
  	<sql:update dataSource="${snapshot}" var="updateactive">
        UPDATE USERS SET LASTLOGIN = NOW() WHERE USERNAME = ?
        <sql:param value="${sessionScope.UNAME}"/>
	</sql:update>

	<img style="width: 200px; display: block; margin: 0 auto; height: 100px;" src="images\friendslogo.png">
	<p align="center">Click <a href="signin.jsp">here</a> to login again</p>

</body>
</html>