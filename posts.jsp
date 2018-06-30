<%@ page import = "java.io.*,java.util.*,java.sql.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix = "sql" %>


<sql:setDataSource var="snapshot" driver="${initParam.DB_DRIVER}" url="${initParam.DB_URL}" user="${initParam.DB_USER}" password="${initParam.DB_PASS}"/>

<c:set var="task" value="${param.work}"/>
<c:set var="cre" value="create"/>
<c:set var="upd" value="update"/>
<c:set var="del" value="delete"/>


<c:if test="${task==cre}">

    <c:if test="${not empty param.pmsg}">
        <sql:update dataSource="${snapshot}" var="result">
            INSERT INTO POSTS (POST_USERID,POST_MSG,POST_TIME) VALUES(?,?,NOW())
            <sql:param value="${sessionScope.UID}"/>
            <sql:param value="${param.pmsg}"/>
        </sql:update>
    </c:if>

</c:if>

<c:if test="${task==upd}">

    <c:if test="${not empty param.pmsg}">
        <sql:update dataSource="${snapshot}" var="updateres">
            UPDATE POSTS SET POST_MSG = ?,POST_TIME = NOW() WHERE POSTID = ${param.pid}
            <sql:param value="${param.pmsg}"/>
        </sql:update>
    </c:if>

</c:if>

<c:if test="${task==del}">
    
    <sql:update dataSource="${snapshot}" var="deletecomm">
        DELETE FROM POSTCOMMENTS WHERE COMM_PID = ${param.pid}
    </sql:update>

    <sql:update dataSource="${snapshot}" var="deletelike">
        DELETE FROM POSTLIKES WHERE POSTID = ${param.pid}
    </sql:update>

    <sql:update dataSource="${snapshot}" var="deletepos">
        DELETE FROM POSTS WHERE POSTID = ${param.pid}
    </sql:update>

</c:if>
