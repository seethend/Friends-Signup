<%@ page import = "java.io.*,java.util.*,java.sql.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix = "sql" %>


<sql:setDataSource var="snapshot" driver="${initParam.DB_DRIVER}" url="${initParam.DB_URL}" user="${initParam.DB_USER}" password="${initParam.DB_PASS}"/>

<c:if test="${not empty param.cmnt}">
    <sql:update dataSource="${snapshot}" var="result">
        INSERT INTO POSTCOMMENTS (COMM_PID,COMM_UID,COMM_MSG,COMM_TIME) VALUES(?,?,?,NOW())
        <sql:param value="${param.postid}"/>
        <sql:param value="${sessionScope.UID}"/>
        <sql:param value="${param.cmnt}"/>
    </sql:update>
</c:if>

<sql:query dataSource="${snapshot}" var="commentresults">
	SELECT * FROM POSTCOMMENTS JOIN USERS WHERE USERS.USER_ID=POSTCOMMENTS.COMM_UID ORDER BY COMMENTID DESC
</sql:query>


<c:if test="${result>=1}">
	<c:forEach var="commrow" items="${commentresults.rows}">
		<c:if test="${commrow.COMM_PID==param.postid}">
			<div id="usercmnt">
				<p id="cmnt_user_name"><c:out value="${commrow.FIRSTNAME}"/></p>
				<p id="cmnt_user_msg"><c:out value="${commrow.COMM_MSG}"/></p>
			</div>
			<hr>
		</c:if>
	</c:forEach>
</c:if>