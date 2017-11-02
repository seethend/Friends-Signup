<%@ page import = "java.io.*,java.util.*,java.sql.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix = "sql" %>


<sql:setDataSource var="snapshot" driver="${initParam.DB_DRIVER}" url="${initParam.DB_URL}" user="${initParam.DB_USER}" password="${initParam.DB_PASS}"/>

<sql:query dataSource="${snapshot}" var="result">
	SELECT * FROM USERS
</sql:query>

<c:set var="task" value="${param.work}"/>
<c:set var="page" value="${param.page}"/>
<c:set var="req" value="request"/>
<c:set var="acc" value="accept"/>
<c:set var="del" value="delete"/>
<c:set var="roomname" value="room"/>

<c:if test="${task==req}">
	<sql:query dataSource="${snapshot}" var="check">
		SELECT * FROM UPDATEFRIENDS
	</sql:query>
	
	<c:set var="shoot" value="True" scope="page" />
	
	<c:forEach var="ch" items="${check.rows}">
		
		<c:if test="${ch.FRIENDS_ONE==param.myid}">
			<c:if test="${ch.FRIENDS_TWO==param.friendid}">
				<% System.out.println("INSIDE"); %>
				<c:set var="shoot" value="False" scope="page" />
			</c:if>
		</c:if>

		<c:if test="${ch.FRIENDS_TWO==param.myid}">
			<c:if test="${ch.FRIENDS_ONE==param.friendid}">
				<% System.out.println("INSIDE"); %>
				<c:set var="shoot" value="False" scope="page" />
			</c:if>
		</c:if>
		
	</c:forEach>
	
	<c:if test="${shoot}">
	
		<sql:update dataSource="${snapshot}" var="updaterequests">
			INSERT INTO UPDATEFRIENDS(FRIENDS_ONE,FRIENDS_TWO,STATUS) VALUES(?,?,0)
			<sql:param value="${param.myid}"/>
			<sql:param value="${param.friendid}"/>
		</sql:update>
		
		<sql:query dataSource="${snapshot}" var="getid">
			SELECT * FROM UPDATEFRIENDS
		</sql:query>
		
		<c:forEach var="forow" items="${getid.rows}">
			<c:if test="${forow.FRIENDS_ONE==param.myid}">
				<c:if test="${forow.FRIENDS_TWO==param.friendid}">
					<c:set var="ufid" value="${forow.UFID}"/>
					<p>Value: <c:out value="${ufid}"></c:out>
				</c:if>	
			</c:if>	
		</c:forEach>
		
		<sql:update dataSource="${snapshot}" var="updateaccepts">
			UPDATE UPDATEFRIENDS SET MSGCHN = ? WHERE UFID = ${ufid}
			<sql:param value="${roomname}${ufid}"/>
		</sql:update>
		
	</c:if>
	
	<c:redirect url="users.jsp"/>

</c:if>

<c:if test="${task==acc}">	
	<sql:update dataSource="${snapshot}" var="updateaccepts">
		UPDATE UPDATEFRIENDS SET STATUS = 1 WHERE FRIENDS_ONE=${param.friendid} AND FRIENDS_TWO = ${param.myid}
	</sql:update>
	<c:if test="${page==1}">
		<c:redirect url="users.jsp"/>
	</c:if>
	<c:if test="${page==2}">
		<c:redirect url="friendrequests.jsp"/>
	</c:if>
</c:if>

<c:if test="${task==del}">
	<sql:update dataSource="${snapshot}" var="deletefriends">
		DELETE FROM UPDATEFRIENDS WHERE FRIENDS_ONE=${param.myid} AND FRIENDS_TWO=${param.friendid}
	</sql:update>
	<sql:update dataSource="${snapshot}" var="deletefriends">
		DELETE FROM UPDATEFRIENDS WHERE FRIENDS_ONE=${param.friendid} AND FRIENDS_TWO=${param.myid}
	</sql:update>
	<c:if test="${page==1}">
		<c:redirect url="users.jsp"/>
	</c:if>
	<c:if test="${page==2}">
		<c:redirect url="friendrequests.jsp"/>
	</c:if>
	<c:if test="${page==3}">
		<c:redirect url="friends.jsp"/>
	</c:if>
	<c:if test="${page==4}">
		<c:redirect url="profile.jsp"/>
	</c:if>
</c:if>