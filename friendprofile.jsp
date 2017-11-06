<!DOCTYPE html>
<html>
<head>

	<%@ page import = "java.io.*,java.util.*,java.sql.*"%>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix = "sql" %>
	
	<title>${param.fname}</title>
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
						<li class=""><a href="friendrequests.jsp">FriendRequests<div id="newreq-div"><p id="newfrndreq"></p></div></a></li>
						<li class=""><a href="friends.jsp">Friends</a></li>
						<li class=""><a href="messages.jsp">Messages<div id="newmsgs-div"><p id="newmsgs"></p></div></a></li>
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
		<br><br><br>

		<sql:setDataSource var="snapshot" driver="${initParam.DB_DRIVER}" url="${initParam.DB_URL}" user="${initParam.DB_USER}" password="${initParam.DB_PASS}"/>

		<sql:query dataSource="${snapshot}" var="result">
			SELECT * FROM USERS
		</sql:query>

		<sql:query dataSource="${snapshot}" var="friendone">
			SELECT * FROM USERS JOIN UPDATEFRIENDS ON USERS.USER_ID=UPDATEFRIENDS.FRIENDS_ONE
		</sql:query>

	<div id="profile-container">
		<c:forEach var="row" items="${result.rows}">
			<c:if test="${row.USER_ID==param.friendid}">
				<c:set var="paramusername" value="${row.USERNAME}"/>
				<img id="profile-pic" width="200px" height="200px" src=profilepics/${row.USERNAME}.jpg onerror="this.src = 'images/friendslogo.png';">
				<p>Name:&nbsp;&nbsp;<c:out value="${row.LASTNAME}"/>&nbsp;<c:out value="${row.FIRSTNAME}"/></p>
			</c:if>
		</c:forEach>
	</div>
	<div id="ul-field">
		<ul id="profile-ul">
			<li id="about" onclick="showdiv(this.id);">About</li>
			<li id="photos" onclick="showdiv(this.id);">Photos</li>
			<li id="friends" onclick="showdiv(this.id);">Friends</li>
		</ul>
	</div>

	<sql:query dataSource="${snapshot}" var="postsresults">
		SELECT USER_ID,USERNAME,FIRSTNAME,LASTNAME,POSTID,POST_USERID,POST_MSG,DATE_FORMAT(POST_TIME,"%d %M at %h:%i") AS POST_TIME FROM POSTS JOIN USERS WHERE USERS.USER_ID=POSTS.POST_USERID ORDER BY POSTID DESC
	</sql:query>


	<sql:query dataSource="${snapshot}" var="postlikes">
		SELECT * FROM POSTLIKES
	</sql:query>

	<sql:query dataSource="${snapshot}" var="totallikes">
		SELECT POSTID,COUNT(POSTID) AS NUMLIKES FROM POSTLIKES GROUP BY POSTID
	</sql:query>

	<sql:query dataSource="${snapshot}" var="commentresults">
		SELECT * FROM POSTCOMMENTS JOIN USERS WHERE USERS.USER_ID=POSTCOMMENTS.COMM_UID ORDER BY COMMENTID DESC
	</sql:query>

	<sql:query dataSource="${snapshot}" var="totalcomms">
		SELECT COMM_PID,COUNT(COMMENTID) AS NUMCOMMS FROM POSTCOMMENTS GROUP BY COMM_PID
	</sql:query>

	<div id="ul-about">
		<p style="background-color: #DDD;padding: 20px;margin: 10px;font-size: 2em;">About</p><hr>
		<c:forEach var="row" items="${result.rows}">
			<c:if test="${row.USER_ID==param.friendid}">
				<p>Name:&nbsp;&nbsp;<c:out value="${row.LASTNAME}"/>&nbsp;<c:out value="${row.FIRSTNAME}"/></p><hr>
				<p>Email:&nbsp;&nbsp;<c:out value="${row.EMAILID}"/></p><hr>
			</c:if>
		</c:forEach>
	</div>

	<div id="ul-friends">
		<p style="background-color: #DDD;padding: 20px;margin: 10px;font-size: 2em;">Friends</p><hr>
		<c:forEach var="forow" items="${friendone.rows}">
			<c:if test="${forow.STATUS==1}">
				<c:if test="${param.friendid==forow.FRIENDS_ONE}">
					<c:forEach var="row" items="${result.rows}">
						<c:if test="${row.USER_ID==forow.FRIENDS_TWO}">
							<div style="width: 75%;" id="new-friend">
								<img width="72px" height="72px" src=profilepics/${row.USERNAME}.jpg onerror="this.src = 'images/friendslogo.png';">
								<p class="hovername" id="${row.USER_ID}" onclick="showprofile(${sessionScope.UID},this.id,'${row.FIRSTNAME}');"><c:out value="${row.FIRSTNAME}"/></p>
								<p id="friendemail"><c:out value="${row.EMAILID}"/></p>
								<!-- <div id="main-div">
									<button id="main-btn"><img src="images/tickmark.png" width="10px" height="10px" id="btn-img">Friends</button>
									<div id="a-content">
										<a href="#">Message</a>
										<hr>
										<a name="${row.USER_ID}" href="#" onclick="sendDelete(this.name,${sessionScope.UID})">Unfriend</a>
									</div>
								</div> -->
							</div><br>
						</c:if>
					</c:forEach>
				</c:if>
				<c:if test="${param.friendid==forow.FRIENDS_TWO}">
					<c:forEach var="row" items="${result.rows}">
						<c:if test="${row.USER_ID==forow.FRIENDS_ONE}">
							<div style="width: 75%;" id="new-friend">
								<img width="72px" height="72px" src=profilepics/${row.USERNAME}.jpg onerror="this.src = 'images/friendslogo.png';">
								<p class="hovername" id="${row.USER_ID}" onclick="showprofile(${sessionScope.UID},this.id,'${row.FIRSTNAME}');"><c:out value="${row.FIRSTNAME}"/></p>
								<p id="friendemail"><c:out value="${row.EMAILID}"/></p>
								<!-- <div id="main-div">
									<button id="main-btn"><img src="images/tickmark.png" width="10px" height="10px" id="btn-img">Friends</button>
									<div id="a-content">
										<a href="#">Message</a>
										<hr>
										<a name="${row.USER_ID}" href="#" onclick="sendDelete(this.name,${sessionScope.UID})">Unfriend</a>
									</div>
								</div> -->
							</div><br>
						</c:if>
					</c:forEach>
				</c:if>
			</c:if>
		</c:forEach>
	</div>

<div id="msg-box">
	<div id="frnd-div" onclick="togle();">
		<p id="user-name" onclick="profileFromMsgBox(this.title);">seethend</p>
	</div>
	<div id="close-msgbox">
		<p onclick="close_msg();proxy.logout();">&times;</p>
	</div>
	<div id="disp-msg">
		<div id="msgPanel">
			<div id="msgContainer">
			</div>
			<div id="msgController" title="see">
				<textarea id="txtMsg" name="${sessionScope.UNAME}"
							title="Enter to send message" oninput="proxy.typing()" 
							onkeyup="proxy.sendMessage_keyup(event)"></textarea>
			</div>
		</div>
	</div>
</div>

<div id="show-typing"></div>

<div id="online-box">
	
</div>

	<div id="posts-div"  style="margin-top: 10px;margin-left: 15%; width: 60%;">
		<div id="showposts">
			<c:forEach var="postrow" items="${postsresults.rows}">
				<c:if test="${param.friendid==postrow.POST_USERID}">
					<div id="singlepost">
						<img id="user-img" src=profilepics/${postrow.USERNAME}.jpg onerror="this.src = 'images/friendslogo.png';">
						<p id="pusername" onclick="showprofile(${sessionScope.UID},'${postrow.USER_ID}','${postrow.FIRSTNAME}');"><c:out value="${postrow.FIRSTNAME}"/></p>
						<p id="post-time"><c:out value="${postrow.POST_TIME}"/></p><hr>
						<div id="postspace">
							<p id="puserpost"><c:out value="${postrow.POST_MSG}"/></p>
						</div>
						<div id="${postrow.POSTID}">
							<c:set var="ifbtn" value="True"/>
							<c:forEach var="likesrow" items="${postlikes.rows}">
								<c:if test="${postrow.POSTID==likesrow.POSTID}">
									<c:if test="${likesrow.USERID==sessionScope.UID}">
										<button name="${postrow.POSTID}" class="dislike-btn" onclick="dislikepost(this.name,${sessionScope.UID});">Like</button>
										<c:set var="ifbtn" value="False"/>
									</c:if>
								</c:if>
							</c:forEach>
							<c:forEach var="tlikes" items="${totallikes.rows}">
								<c:if test="${tlikes.POSTID==postrow.POSTID}">
									<p id="likes-count"><c:out value="${tlikes.NUMLIKES}"/></p>
								</c:if>
							</c:forEach>

							<c:forEach var="tcomms" items="${totalcomms.rows}">
								<c:if test="${tcomms.COMM_PID==postrow.POSTID}">
									<p id="comms-count"><c:out value="${tcomms.NUMCOMMS}"/></p>
								</c:if>
							</c:forEach>

							<c:if test="${ifbtn}">
								<button name="${postrow.POSTID}" class="like-btn" onclick="likepost(this.name,${sessionScope.UID});">Like</button>
							</c:if>
						</div>
						<button name="${postrow.POSTID}" class="comment-btn" onclick="showcomments(this.name)">Comment</button>
						<div title="${postrow.POSTID}" class="comment-div">
							<div id="postcomment">
								<img id="cmnt-img" src=profilepics/${sessionScope.UNAME}.jpg onerror="this.src = 'images/friendslogo.png';">
								<input class="cmnt-msg" title="${postrow.POSTID}" type="text" name="cmnt_msg" onkeydown="if (event.keyCode == 13) {postComm(${postrow.POSTID},${sessionScope.UID})}"/>
								<button class="cmnt-btn" name="${postrow.POSTID}" onclick="postComm(${postrow.POSTID},${sessionScope.UID})">Comment</button>
							</div>
							<div title="${postrow.POSTID}" class="singlecomment">
								<c:forEach var="commrow" items="${commentresults.rows}">
									<c:if test="${commrow.COMM_PID==postrow.POSTID}">
										<div id="usercmnt">
											<p id="cmnt_user_name" onclick="showprofile(${sessionScope.UID},${commrow.USER_ID},'${commrow.FIRSTNAME}');"><c:out value="${commrow.FIRSTNAME}"/></p>
											<p id="cmnt_user_msg"><c:out value="${commrow.COMM_MSG}"/></p>
										</div>
										<hr>
									</c:if>
								</c:forEach>
							</div>
						</div>
					</div>
				</c:if>
			</c:forEach>
		</div>
	</div>

</body>
</html>