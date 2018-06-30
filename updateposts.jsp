<%@ page import = "java.io.*,java.util.*,java.sql.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix = "sql" %>

<sql:setDataSource var="snapshot" driver="${initParam.DB_DRIVER}" url="${initParam.DB_URL}" user="${initParam.DB_USER}" password="${initParam.DB_PASS}"/>

<c:set var="work" value="${param.work}"/>
<c:set var="like" value="like"/>
<c:set var="dis" value="dislike"/>

<sql:query dataSource="${snapshot}" var="addlikes">
	SELECT POSTID,COUNT(POSTID)+1 AS NUMLIKES FROM POSTLIKES GROUP BY POSTID
</sql:query>

<sql:query dataSource="${snapshot}" var="totalcomms">
	SELECT COMM_PID,COUNT(COMMENTID) AS NUMCOMMS FROM POSTCOMMENTS GROUP BY COMM_PID
</sql:query>

<c:forEach var="tcomms" items="${totalcomms.rows}">
	<c:if test="${tcomms.COMM_PID==param.postid}">
		<p id="comms-count"><c:out value="${tcomms.NUMCOMMS}"/></p>
	</c:if>
</c:forEach>

<c:if test='${work==like}'>
	<sql:update dataSource="${snapshot}" var="likeresults">
		INSERT INTO POSTLIKES (POSTID,USERID) VALUES(?,?)
		<sql:param value="${param.postid}"/>
		<sql:param value="${sessionScope.UID}"/>
	</sql:update>
	<c:if test="${likeresults>=1}">
		<button name="${param.postid}" class="dislike-btn" onclick="dislikepost(this.name);">Like</button>
		<c:set var="lc" value="True"/>
		<c:forEach var="alikes" items="${addlikes.rows}">
			<c:if test="${alikes.POSTID==param.postid}">
				<p id="likes-count"><c:out value="${alikes.NUMLIKES}"/></p>
				<c:set var="lc" value="False"/>
			</c:if>
		</c:forEach>
		<c:if test="${lc}">
			<p id="likes-count">1</p>
		</c:if>
	</c:if>
	
</c:if>

<sql:query dataSource="${snapshot}" var="dellikes">
	SELECT POSTID,COUNT(POSTID)-1 AS NUMLIKES FROM POSTLIKES GROUP BY POSTID
</sql:query>

<c:if test='${work==dis}'>
	<sql:update dataSource="${snapshot}" var="deletefriends">
		DELETE FROM POSTLIKES WHERE POSTID=${param.postid} AND USERID=${sessionScope.UID}
	</sql:update>
	<c:if test="${deletefriends>=1}">
		<button name="${param.postid}" class="like-btn" onclick="likepost(this.name);">Like</button>
		<c:forEach var="dlikes" items="${dellikes.rows}">
			<c:if test="${dlikes.POSTID==param.postid}">
				<c:choose>
					<c:when test="${dlikes.NUMLIKES==0}">
						<p id="likes-count"></p>
					</c:when>
					<c:otherwise>
						<p id="likes-count"><c:out value="${dlikes.NUMLIKES}"/></p>
					</c:otherwise>
				</c:choose>
			</c:if>
		</c:forEach>
	</c:if>
</c:if>