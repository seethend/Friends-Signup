
<%@ page import = "java.io.*,java.util.*,java.sql.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix = "sql" %>

<sql:setDataSource var="snapshot" driver="${initParam.DB_DRIVER}" url="${initParam.DB_URL}" user="${initParam.DB_USER}" password="${initParam.DB_PASS}"/>

<sql:query dataSource="${snapshot}" var="getuserid">
	SELECT * FROM USERS
</sql:query>

<c:set var="check" value="True" scope="page"/>

<c:forEach var="checkuser" items="${getuserid.rows}">
	<c:if test="${checkuser.USERNAME==param.SUSERNAME}">
		<c:set var="check" value="False" scope="page"/>
	</c:if>
</c:forEach>

<c:if test="${check}">

	<sql:update dataSource="${snapshot}" var="result">
		INSERT INTO USERS (USERNAME,FIRSTNAME,LASTNAME,PASSWORD,EMAILID) VALUES(?,?,?,?,?)
		<sql:param value="${param.SUSERNAME}"/>
		<sql:param value="${param.FIRSTNAME}"/>
		<sql:param value="${param.LASTNAME}"/>
		<sql:param value="${param.SPASSWORD}"/>
		<sql:param value="${param.EMAIL}"/>
	</sql:update>

	<c:if test="${result>=1}">
	
		<sql:query dataSource="${snapshot}" var="setuserid">
			SELECT * FROM USERS
		</sql:query>

		<c:forEach var="forow" items="${setuserid.rows}">
			<c:if test="${forow.USERNAME==param.SUSERNAME}">
				<c:set var="id" value="${forow.USER_ID}" scope="page"/>
			</c:if>
		</c:forEach>
		
		<sql:update dataSource="${snapshot}" var="updateactive">
			INSERT INTO UPDATES (UPDATEUSERID) VALUES(?)
			<sql:param value="${id}"/>
		</sql:update>
		
		
		<c:redirect url="signin.jsp">
			<c:param name="successMsg" value=" You have Successfully Registered" />
		</c:redirect>

	</c:if>

</c:if>

<c:if test="${not check}">
	<c:redirect url="signin.jsp">
		<c:param name="signupMsg" value="User already Exists...!!!! Create with new Username" />
	</c:redirect>
</c:if>