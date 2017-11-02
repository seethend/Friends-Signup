<%@ page import = "java.io.*,java.util.*,java.sql.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix = "sql" %>


<sql:setDataSource var="snapshot" driver="${initParam.DB_DRIVER}" url="${initParam.DB_URL}" user="${initParam.DB_USER}" password="${initParam.DB_PASS}"/>


<c:if test="${not empty param.pmsg}">
    <sql:update dataSource="${snapshot}" var="result">
        INSERT INTO POSTS (POST_USERID,POST_MSG,POST_TIME) VALUES(?,?,NOW())
        <sql:param value="${sessionScope.UID}"/>
        <sql:param value="${param.pmsg}"/>
    </sql:update>
</c:if>

<c:redirect url="homepage.jsp"/>
