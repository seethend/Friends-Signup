<%@ page import = "java.io.*,java.util.*,java.sql.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix = "sql" %>

<script type="text/javascript">
	window.history.forward();
</script>
<sql:setDataSource var="snapshot" driver="${initParam.DB_DRIVER}" url="${initParam.DB_URL}" user="${initParam.DB_USER}" password="${initParam.DB_PASS}"/>

<sql:query dataSource="${snapshot}" var="result">
	SELECT * FROM USERS
</sql:query>
<c:set var="MSGID" value="roomone" scope="session" />
<c:set var="ifnouser" value="True"/>
<c:set var="ifnopass" value="True"/>
<c:forEach var = "row" items = "${result.rows}">
    <c:if test = "${param.LUSERNAME == row.USERNAME}">
		<c:set var="ifnouser" value="False"/>
		<c:if test="${param.LPASSWORD == row.PASSWORD}">
			<c:set var="ifnopass" value="False"/>
			<p>LOGIN SUCCESSFULL</p>
			<c:set var="token" value="active" scope="session" />
			<c:set var="FNAME" value="${row.FIRSTNAME}" scope="session" />
			<c:set var="UNAME" value="${row.USERNAME}" scope="session" />
			<c:set var="UID" value="${row.USER_ID}" scope="session" />

			<sql:update dataSource="${snapshot}" var="updateactive">
				UPDATE USERS SET ACTIVE = 1 WHERE USERNAME = ?
				<sql:param value="${row.USERNAME}"/>
			</sql:update>

			<c:if test="${updateactive==1}">
				<c:redirect url="homepage.jsp"/>
			</c:if>

		</c:if>
    </c:if>
</c:forEach>

<c:if test="${ifnouser}">
  	<p>USERNAME IS INCORRECT</p>
  	<c:redirect url="signin.jsp">
		<c:param name="errorMessage" value="Invalid user" />
	</c:redirect>
</c:if>

<c:if test="${ifnopass}">
	<p>PASSWORD IS INCORRECT</p>
	<c:redirect url="signin.jsp">
		<c:param name="errorMessage" value="Invalid password" />
	</c:redirect>
</c:if>