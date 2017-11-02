<%@ page import = "java.io.*,java.util.*,java.sql.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix = "sql" %>


<sql:setDataSource var="snapshot" driver="${initParam.DB_DRIVER}" url="${initParam.DB_URL}" user="${initParam.DB_USER}" password="${initParam.DB_PASS}"/>

<sql:query dataSource="${snapshot}" var="getallreq">
	SELECT * FROM USERS JOIN UPDATEFRIENDS ON USERS.USER_ID=UPDATEFRIENDS.FRIENDS_ONE
</sql:query>

<sql:query dataSource="${snapshot}" var="getrequpdates">
	SELECT * FROM UPDATES
</sql:query>

<c:set var="totalreqcount" value="0" scope="page" />
<c:set var="accreqcount" value="0" scope="page" />

<c:forEach var="reqforow" items="${getallreq.rows}">
	<c:if test="${sessionScope.UID==reqforow.FRIENDS_TWO}">
		<c:if test="${reqforow.STATUS==0 or reqforow.STATUS==1}">
			<c:set var="totalreqcount" value="${totalreqcount + 1}" scope="page"/>
		</c:if>
	</c:if>
</c:forEach>

<c:forEach var="reqforow" items="${getallreq.rows}">
	<c:if test="${sessionScope.UID==reqforow.FRIENDS_TWO}">
		<c:if test="${reqforow.STATUS==1}">
			<c:set var="accreqcount" value="${accreqcount + 1}" scope="page"/>
		</c:if>
	</c:if>
</c:forEach>

<c:forEach var="reqcol" items="${getrequpdates.rows}">
	<c:if test="${sessionScope.UID==reqcol.UPDATEUSERID}">
		<c:set var="newrequests" value="${totalreqcount - reqcol.PAST_REQ}" scope="page" />
		<c:if test="${newrequests>0}">
			<p  id="newfrndreq"><c:out value="${newrequests}"/></p>
		</c:if>
	</c:if>
</c:forEach>

<sql:update dataSource="${snapshot}" var="updatereqs">
	UPDATE UPDATES SET PAST_REQ = ? WHERE UPDATEUSERID = ?
	<sql:param value="${accreqcount}"/>
	<sql:param value="${sessionScope.UID}"/>
</sql:update>