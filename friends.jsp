<!DOCTYPE html>
<html>
<head>
	
	<%@ page import = "java.io.*,java.util.*,java.sql.*"%>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix = "sql" %>
	
	<title>Friends</title>
	<meta charset="utf-8">
	<link rel="icon" type="image/png" href="images/logo.png">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
    <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>
	<link rel="stylesheet" type="text/css" href="content/styles/homepage.css">
	<script type="text/javascript" src="scripts/mainjs.js"></script>
	<script type="text/javascript" src="scripts/chatroom.js"></script>
		
		<% String WsUrl = getServletContext().getInitParameter("WsUrl"); %>
		
	<script type="text/javascript">
	
		var wsUri = '<%=WsUrl%>';
		var proxy = CreateProxy(wsUri);
		
		document.addEventListener("DOMContentLoaded", function(event) {
			console.log(document.getElementById('loginPanel'));
			proxy.initiate({ 
				msgPanel: document.getElementById('msgPanel'),
				txtMsg: document.getElementById('txtMsg'),
				msgContainer: document.getElementById('msgContainer'),
				msgController: document.getElementById('msgController'),
				showTyping: document.getElementById('show-typing')
			});
		});
	
	</script>


</head>
<body onload="getupdates();">
	<sql:setDataSource var="snapshot" driver="${initParam.DB_DRIVER}" url="${initParam.DB_URL}" user="${initParam.DB_USER}" password="${initParam.DB_PASS}"/>

	<sql:query dataSource="${snapshot}" var="result">
		SELECT * FROM USERS
	</sql:query>

	<sql:query dataSource="${snapshot}" var="friendone">
		SELECT * FROM USERS JOIN UPDATEFRIENDS ON USERS.USER_ID=UPDATEFRIENDS.FRIENDS_ONE
	</sql:query>

	<jsp:include page="navbar.jsp"/>
		<br><br><br>
<div id="div-container">
	<c:forEach var="forow" items="${friendone.rows}">
		<c:if test="${forow.STATUS==1}">
			<c:if test="${sessionScope.UID==forow.FRIENDS_ONE}">
				<c:forEach var="row" items="${result.rows}">
					<c:if test="${row.USER_ID==forow.FRIENDS_TWO}">
						<div id="new-friend">
							<img width="72px" height="72px" src=profilepics/${row.USERNAME}.jpg onerror="this.src = 'images/friendslogo.png';">
							<p class="hovername" id="${row.USER_ID}" onclick="showprofile(${sessionScope.UID},this.id,'${row.FIRSTNAME}');"><c:out value="${row.FIRSTNAME}"/></p>
							<p id="friendemail"><c:out value="${row.EMAILID}"/></p>
							<div id="main-div">
								<button id="main-btn"><img src="images/tickmark.png" width="10px" height="10px" id="btn-img">Friends</button>
								<div id="a-content">
									<a id="${forow.MSGCHN}" href="#" onclick="showbox(${row.USER_ID},'${row.FIRSTNAME}',this.id);proxy.login();">Message</a>
									<hr>
									<a id="${row.USER_ID}" href="#" onclick="sendDelete(this.id,3)">Unfriend</a>
								</div>
							</div>
						</div><br>
					</c:if>
				</c:forEach>
			</c:if>
			<c:if test="${sessionScope.UID==forow.FRIENDS_TWO}">
				<c:forEach var="row" items="${result.rows}">
					<c:if test="${row.USER_ID==forow.FRIENDS_ONE}">
						<div id="new-friend">
							<img width="72px" height="72px" src=profilepics/${row.USERNAME}.jpg onerror="this.src = 'images/friendslogo.png';">
							<p class="hovername" id="${row.USER_ID}" onclick="showprofile(${sessionScope.UID},this.id,'${row.FIRSTNAME}');"><c:out value="${row.FIRSTNAME}"/></p>
							<p id="friendemail"><c:out value="${row.EMAILID}"/></p>
							<div id="main-div">
								<button id="main-btn"><img src="images/tickmark.png" width="10px" height="10px" id="btn-img">Friends</button>
								<div id="a-content">
									<a id="${forow.MSGCHN}" href="#" onclick="showbox(${row.USER_ID},'${row.FIRSTNAME}',this.id);proxy.login();">Message</a>
									<hr>
									<a id="${row.USER_ID}" href="#" onclick="sendDelete(this.id,3)">Unfriend</a>
								</div>
							</div>
						</div><br>
					</c:if>
				</c:forEach>
			</c:if>
		</c:if>
	</c:forEach>
</div>

<jsp:include page="msgbox.jsp" />


<div id="online-box">
	
</div>

</body>
</html>