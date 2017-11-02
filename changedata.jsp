<%@ page import = "java.io.*,java.util.*,java.sql.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix = "sql" %>

<sql:setDataSource var="snapshot" driver="${initParam.DB_DRIVER}" url="${initParam.DB_URL}" user="${initParam.DB_USER}" password="${initParam.DB_PASS}"/>

<c:set var="work" value="${param.work}"/>
<c:set var="fn" value="firstname"/>
<c:set var="ln" value="lastname"/>
<c:set var="ei" value="emailid"/>
<c:set var="nofn" value="True"/>
<c:set var="noln" value="True"/>
<c:set var="noei" value="True"/>

<c:if test="${work==fn}">
	<c:if test="${not empty param.finame}">
		<c:set var="nofn" value="False"/>
		<sql:update dataSource="${snapshot}" var="result">
			UPDATE USERS SET FIRSTNAME=? WHERE USER_ID=?
			<sql:param value="${param.finame}"/>
			<sql:param value="${sessionScope.UID}"/>
		</sql:update>
		<c:if test="${result>=1}">
			<c:set var="FNAME" value="${param.finame}" scope="session" />
			<c:redirect url="settings.jsp">
				<c:param name="firstchange" value="First Name Updated Successfully!!!" />
			</c:redirect>
		</c:if>
	</c:if>
	<c:if test="${nofn}">
		<c:redirect url="settings.jsp">
			<c:param name="firstchange" value="No FirstName Entered!!!" />
		</c:redirect>
	</c:if>
</c:if>

<c:if test="${work==ln}">
	<c:if test="${not empty param.laname}">
		<c:set var="noln" value="False"/>
		<sql:update dataSource="${snapshot}" var="result">
			UPDATE USERS SET LASTNAME=? WHERE USER_ID=?
			<sql:param value="${param.laname}"/>
			<sql:param value="${sessionScope.UID}"/>
		</sql:update>
		<c:if test="${result>=1}">
			<c:redirect url="settings.jsp">
				<c:param name="lastchange" value="Last Name Updated Successfully!!!" />
			</c:redirect>
		</c:if>
	</c:if>
	<c:if test="${noln}">
		<c:redirect url="settings.jsp">
			<c:param name="lastchange" value="No LastName Entered!!!" />
		</c:redirect>
	</c:if>
</c:if>

<c:if test="${work==ei}">
	<c:if test="${not empty param.email}">
		<c:set var="noei" value="False"/>
		<sql:update dataSource="${snapshot}" var="result">
			UPDATE USERS SET EMAILID=? WHERE USER_ID=?
			<sql:param value="${param.email}"/>
			<sql:param value="${sessionScope.UID}"/>
		</sql:update>
		<c:if test="${result>=1}">
			<c:redirect url="settings.jsp">
				<c:param name="emailchange" value="Email Updated Successfully!!!" />
			</c:redirect>
		</c:if>
	</c:if>
	<c:if test="${noei}">
		<c:redirect url="settings.jsp">
			<c:param name="emailchange" value="No EmailID Entered!!!" />
		</c:redirect>
	</c:if>
</c:if>