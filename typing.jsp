<%@ page import = "java.io.*,java.util.*,java.sql.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix = "sql" %>


<sql:setDataSource var="snapshot" driver="${initParam.DB_DRIVER}" url="${initParam.DB_URL}" user="${initParam.DB_USER}" password="${initParam.DB_PASS}"/>


	<sql:update dataSource="${snapshot}" var="updateaccepts">
		UPDATE UPDATEFRIENDS SET ONE_TYP = 1 WHERE FRIENDS_ONE=${param.myid} AND FRIENDS_TWO=${param.frid}
	</sql:update>
	<c:if test="${onetyp>1}">
		<p>Updated</p>
	</c:if>
	<sql:update dataSource="${snapshot}" var="twotyp">
		UPDATE UPDATEFRIENDS SET TWO_TYP = 1 WHERE FRIENDS_TWO=${param.myid} AND FRIENDS_ONE=${param.frid}
	</sql:update>
	<c:if test="${twotyp>1}">
		<p>Updated</p>
	</c:if>