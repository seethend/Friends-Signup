<%@ page import = "java.io.*,java.util.*,java.sql.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix = "sql" %>


<sql:setDataSource var="snapshot" driver="${initParam.DB_DRIVER}" url="${initParam.DB_URL}" user="${initParam.DB_USER}" password="${initParam.DB_PASS}"/>


	<sql:update dataSource="${snapshot}" var="onenotyp">
		UPDATE UPDATEFRIENDS SET ONE_TYP = 0 WHERE FRIENDS_ONE = ${param.myid} AND FRIENDS_TWO = ${param.frid}
	</sql:update>
	<c:if test="${onenotyp>1}">
		<p>Updated</p>
	</c:if>
	<sql:update dataSource="${snapshot}" var="twonotyp">
		UPDATE UPDATEFRIENDS SET TWO_TYP = 0 WHERE FRIENDS_TWO = ${param.myid} AND FRIENDS_ONE = ${param.frid}
	</sql:update>
	<c:if test="${twonotyp>1}">
		<p>Updated</p>
	</c:if>