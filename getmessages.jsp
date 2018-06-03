<%@ page import = "java.io.*,java.util.*,java.sql.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix = "sql" %>

<sql:setDataSource var="snapshot" driver="${initParam.DB_DRIVER}" url="${initParam.DB_URL}" user="${initParam.DB_USER}" password="${initParam.DB_PASS}"/>

<sql:query dataSource="${snapshot}" var="allmessages">
	SELECT MSG_ID,FONE_ID,FTWO_ID,MSG,DATE_FORMAT(R_TIME,"%d %M at %h:%i") AS R_TIME FROM USERMESSAGESID ORDER BY MSG_ID
</sql:query>

<c:forEach var="m" items="${allmessages.rows}">
	<c:if test="${sessionScope.UID==m.FONE_ID}">
		<c:if test="${param.frid==m.FTWO_ID}">
			<div id="newmymsg">
				<p title="${m.R_TIME}" id="mymsg"><c:out value="${m.MSG}"/></p>
			</div>
		</c:if>
	</c:if>

	<c:if test="${param.frid==m.FONE_ID}">
		<c:if test="${sessionScope.UID==m.FTWO_ID}">
			<div id="newfrndmsg">
				<p title="${m.R_TIME}" id="frndmsg"><c:out value="${m.MSG}"/></p>
			</div>
		</c:if>
	</c:if>
</c:forEach>