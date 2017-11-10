<!DOCTYPE html>
<html>
<head>

	<%@ page import = "java.io.*,java.util.*,java.sql.*"%>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix = "sql" %>

	<title>Messages</title>
	<link rel="icon" type="image/png" href="images/logo.png">
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
    <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>
	<link rel="stylesheet" type="text/css" href="content/styles/messages.css">
	<script type="text/javascript" src="scripts/sendmessage.js"></script>
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
	<nav class="navbar navbar-inverse">
		<div class="container-fluid">
			<div class="navbar-header">
				<button class="navbar-toggle" data-toggle='collapse' data-target='#mainnavbar'>
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
				</button>
				<a href="homepage.jsp" class="navbar-brand"><img id="main-logo" src="images\friendslogo.png"></a>
			</div>

			<div class="collapse navbar-collapse" id="mainnavbar">
				<ul class="nav navbar-nav">
					<li class=""><a href="homepage.jsp">Homepage</a></li>
					<li class=""><a href="users.jsp">Users</a></li>
					<li class=""><a href="friendrequests.jsp">FriendRequests<span id="newreq-div"><span id="newfrndreq"></span></span></a></li>
					<li class=""><a href="friends.jsp">Friends</a></li>
					<li class="active"><a href="messages.jsp">Messages<span id="newmsgs-div"><span id="newmsgs"></span></span></a></li>
					<li class="dropdown">
						<a href="profile.jsp" class="dropdown-toggle" data-toggle='dropdown'>${sessionScope.FNAME}&nbsp;<span class="caret"></span></a>
						<ul class="dropdown-menu">
							<li><a href="profile.jsp">Profile</a></li>
							<li><a href="settings.jsp">Settings</a></li>
						</ul>
					</li>
				</ul>

				<ul class="nav navbar-nav navbar-right">
					<li><a href="logout.jsp">Logout</a></li>
				</ul>
			</div>
		</div>
	</nav>


	<sql:setDataSource var="snapshot" driver="${initParam.DB_DRIVER}" url="${initParam.DB_URL}" user="${initParam.DB_USER}" password="${initParam.DB_PASS}"/>

	<sql:query dataSource="${snapshot}" var="result">
		SELECT * FROM USERS
	</sql:query>

	<sql:query dataSource="${snapshot}" var="friendone">
		SELECT * FROM USERS JOIN UPDATEFRIENDS ON USERS.USER_ID=UPDATEFRIENDS.FRIENDS_ONE
	</sql:query>

	<div id="show-friends">
		<div id="div-container">
			<c:forEach var="forow" items="${friendone.rows}">
				<c:if test="${forow.STATUS==1}">
					<c:if test="${sessionScope.UID==forow.FRIENDS_ONE}">
						<c:forEach var="row" items="${result.rows}">
							<c:if test="${row.USER_ID==forow.FRIENDS_TWO}">
								<div class="new-friend" id="${forow.MSGCHN}" onclick="selectedfriend(this.id,${sessionScope.UID},${row.USER_ID});proxy.login()">
									<img id="friend-img" width="40px" height="40px" src=profilepics/${row.USERNAME}.jpg onerror="this.src = 'images/friendslogo.png';">
									<p class="hovername" id="${row.USER_ID}"><c:out value="${row.FIRSTNAME}"/></p>
								</div><hr>
							</c:if>
						</c:forEach>
					</c:if>
					<c:if test="${sessionScope.UID==forow.FRIENDS_TWO}">
						<c:forEach var="row" items="${result.rows}">
							<c:if test="${row.USER_ID==forow.FRIENDS_ONE}">
								<div class="new-friend" id="${forow.MSGCHN}" onclick="selectedfriend(this.id,${sessionScope.UID},${row.USER_ID});proxy.login()">
									<img id="friend-img" width="40px" height="40px" src=profilepics/${row.USERNAME}.jpg onerror="this.src = 'images/friendslogo.png';">
									<p class="hovername" id="${row.USER_ID}"><c:out value="${row.FIRSTNAME}"/></p>
								</div><hr>
							</c:if>
						</c:forEach>
					</c:if>
				</c:if>
			</c:forEach>
		</div>
	</div>
	
	<div id="disp-msg">
		<div id="msgPanel">
			<div id="msgContainer"></div>
			<div id="msgController" title="see">
				<textarea id="txtMsg" name="${sessionScope.UNAME}"
					title="Enter to send message" oninput="proxy.typing();" 
					onkeyup="proxy.sendMessage_keyup(event)"></textarea>
			</div>
		</div>
	</div>
	<div id="show-typing"></div>
</body>
</html>