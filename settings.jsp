<!DOCTYPE html>
<html>
	<head>
		<%@ page import = "java.io.*,java.util.*,java.sql.*"%>
		<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
		<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix = "sql" %>



		<title>Settings</title>
		<meta charset="utf-8">
		<link rel="icon" type="image/png" href="images/logo.png">
	    <meta name="viewport" content="width=device-width, initial-scale=1">
	    <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css">
	    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
	    <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>
		<link rel="stylesheet" type="text/css" href="content/styles/homepage.css">
		<script type="text/javascript" src="scripts/mainjs.js"></script>
		
	</head>
	<body onload="getupdates();">
		<jsp:include page="navbar.jsp"/>
		<br><br><br>

		<div id="allsettings">
			<div id="upload-profile">
				<p>Change your profile pic : </p>
				<form id="form1" enctype="multipart/form-data" action="addprofilepic" method="post">
		            <table>
		            	<tr>
		                    <td><input  type="text"  name="usrnme" style="display: none;" value="${sessionScope.UNAME}" /></td>
		                </tr>
		                <tr>
		                    <td><input type="file"  name="userphoto" accept="image/*" />
		                </tr>
		            </table>
		            <input id="addphoto" type="submit" value="Add Profile" />
		        </form>
		        <c:if test="${not empty param.photochange}">
				   <p id="updatemsg"><c:out value="${param.photochange}"/></p>
				</c:if>	
			</div>
			<hr id="form1-hr">
			<div id="changedata">
				<p>Change your Firstname :</p>
				<form id="form2" action="changedata.jsp" method="get">
					<table>
						<tr>
		                    <td><input  type="text"  name="work" style="display: none;" value="firstname" /></td>
		                </tr>
		            	<tr>
		                    <td><input  type="text"  name="finame"/></td>
		                </tr>
		            </table>
		            <input id="changedatabtn" type="submit" value="Change" />
				</form>
				<c:if test="${not empty param.firstchange}">
				   <p id="updatemsg"><c:out value="${param.firstchange}"/></p>
				</c:if>
			</div>
			<hr id="form2-hr">
			<div id="changedata">
				<p>Change your Lastname :</p>
				<form id="form2" action="changedata.jsp" method="get">
					<table>
						<tr>
		                    <td><input  type="text"  name="work" style="display: none;" value="lastname" /></td>
		                </tr>
		                <tr>
		                    <td><input  type="text"  name="laname"/></td>
		                </tr>
		            </table>
		            <input id="changedatabtn" type="submit" value="Change" />
				</form>
				<c:if test="${not empty param.lastchange}">
				   <p id="updatemsg"><c:out value="${param.lastchange}"/></p>
				</c:if>
			</div>
			<hr id="form2-hr">
			<div id="changedata">
				<p>Change your Email ID :</p>
				<form id="form2" action="changedata.jsp" method="get">
					<table>
						<tr>
		                    <td><input  type="text"  name="work" style="display: none;" value="emailid" /></td>
		                </tr>
		                <tr>
		                    <td><input  type="email"  name="email"/></td>
		                </tr>
		            </table>
		            <input id="changedatabtn" type="submit" value="Change" />
				</form>
				<c:if test="${not empty param.emailchange}">
				   <p id="updatemsg"><c:out value="${param.emailchange}"/></p>
				</c:if>
			</div>
			<hr id="form2-hr">
		</div>
	
	</body>
</html>