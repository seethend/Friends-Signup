<%@ page import = "java.io.*,java.util.*,java.sql.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix = "sql" %>


<sql:setDataSource var="snapshot" driver="${initParam.DB_DRIVER}" url="${initParam.DB_URL}" user="${initParam.DB_USER}" password="${initParam.DB_PASS}"/>

<sql:query dataSource="${snapshot}" var="getrequpdates">
	SELECT * FROM UPDATES
</sql:query>

<sql:query dataSource="${snapshot}" var="getallmsgs">
	SELECT * FROM USERS JOIN USERMESSAGESID ON USERS.USER_ID=USERMESSAGESID.FTWO_ID
</sql:query>


<c:set var="msgcount" value="0" scope="page" />


<c:forEach var="msgforow" items="${getallmsgs.rows}">
	<c:if test="${sessionScope.UID==msgforow.FTWO_ID}">

		<c:set var="msgcount" value="${msgcount + 1}" scope="page"/>

	</c:if>
</c:forEach>



<c:forEach var="msgcol" items="${getrequpdates.rows}">
	<c:if test="${sessionScope.UID==msgcol.UPDATEUSERID}">
		<c:set var="newmsgscount" value="${msgcount - msgcol.PAST_MSGS}" scope="page" />
		<c:if test="${newmsgscount>0}">
			<span id="newmsgs"><c:out value="${newmsgscount}"/></span>
		</c:if>
	</c:if>
</c:forEach>



<sql:update dataSource="${snapshot}" var="updatemsgs">
	UPDATE UPDATES SET PAST_MSGS = ? WHERE UPDATEUSERID = ?
	<sql:param value="${msgcount}"/>
	<sql:param value="${sessionScope.UID}"/>
</sql:update>