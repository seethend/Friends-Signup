<html>
	<head>
		<%@ page import = "java.io.*,java.util.*,java.sql.*"%>
		<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
		<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix = "sql" %>
		
		<title>Homepage</title>
		<link rel="icon" type="image/png" href="images/logo.png">
		<meta charset="utf-8">
	    <meta name="viewport" content="width=device-width, initial-scale=1">
	    <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css">
	    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
	    <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>
		<link rel="stylesheet" type="text/css" href="content/styles/homepage.css">
		<script type="text/javascript" src="scripts/mainjs.js"></script>
		<script type="text/javascript" src="scripts/chatroom.js"></script>

		<link rel="stylesheet" type="text/css" href="content/styles/popup.css">
		<script type="text/javascript" src="scripts/popup.js"></script>
		
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
		
		<jsp:include page="navbar.jsp"/>

		<sql:setDataSource var="snapshot" driver="${initParam.DB_DRIVER}" url="${initParam.DB_URL}" user="${initParam.DB_USER}" password="${initParam.DB_PASS}"/>

		<sql:query dataSource="${snapshot}" var="result">
			SELECT * FROM USERS
		</sql:query>

		<sql:query dataSource="${snapshot}" var="friendone">
			SELECT * FROM USERS JOIN UPDATEFRIENDS ON USERS.USER_ID=UPDATEFRIENDS.FRIENDS_ONE
		</sql:query>


		<jsp:include page="msgbox.jsp" />

		<div id="online-box">
			
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

		<div id="posts-div">
			<div id="sendpost">
				<div id="hide-on-popup">
					<textarea id="postmsg" name="pmsg" onclick="popup_post_send()"></textarea>
					<input id="post-btn" type="submit" value="Post">
				</div>
			</div>
			<hr id="post-hr">

			<div id="showposts">
				<c:forEach var="postrow" items="${postsresults.rows}">
					<c:if test="${sessionScope.UID==postrow.POST_USERID}">
						<div id="singlepost">
							<img id="user-img" src=profilepics/${postrow.USERNAME}.jpg onerror="this.src = 'images/friendslogo.png';">
							<p id="pusername" onclick="showprofile(${sessionScope.UID},${postrow.USER_ID},'${postrow.FIRSTNAME}');"><c:out value="${postrow.FIRSTNAME}"/></p>
							<div id="edit-post-settings">
								<img src="images/postedit.png">
								<div id="pop-content">
									<p onclick="popup_post_edit(${postrow.POSTID})">Edit Post</p>
									<hr>
									<p onclick="popup_post_delete(${postrow.POSTID})">Delete Post</p>
								</div>
							</div>
							<p id="post-time"><c:out value="${postrow.POST_TIME}"/></p><hr>
							<div id="postspace">
								<p id="puserpost" class="${postrow.POSTID}"><c:out value="${postrow.POST_MSG}"/></p>
							</div>
							<div id="${postrow.POSTID}">
								<c:set var="ifbtn" value="True"/>
								<c:forEach var="likesrow" items="${postlikes.rows}">
									<c:if test="${postrow.POSTID==likesrow.POSTID}">
										<c:if test="${likesrow.USERID==sessionScope.UID}">
											<button name="${postrow.POSTID}" class="dislike-btn" onclick="dislikepost(this.name);">Like</button>
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
									<button name="${postrow.POSTID}" class="like-btn" onclick="likepost(this.name);">Like</button>
								</c:if>
							</div>
							<button name="${postrow.POSTID}" class="comment-btn" onclick="showcomments(this.name)">Comment</button>
							<div title="${postrow.POSTID}" class="comment-div">
								<div id="postcomment">
									<img id="cmnt-img" src=profilepics/${sessionScope.UNAME}.jpg onerror="this.src = 'images/friendslogo.png';">
									<input class="cmnt-msg" title="${postrow.POSTID}" type="text" name="cmnt_msg" onkeydown="if (event.keyCode == 13) {postComm(${postrow.POSTID})}"/>
									<button class="cmnt-btn" name="${postrow.POSTID}" onclick="postComm(${postrow.POSTID})">Comment</button>
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
					<c:forEach var="forow" items="${friendone.rows}">
						<c:if test="${forow.STATUS==1}">
							<c:if test="${sessionScope.UID==forow.FRIENDS_ONE}">
								<c:if test="${postrow.POST_USERID==forow.FRIENDS_TWO}">
									<div id="singlepost">
										<img id="user-img" src=profilepics/${postrow.USERNAME}.jpg onerror="this.src = 'images/friendslogo.png';">
										<p id="pusername" onclick="showprofile(${sessionScope.UID},${postrow.USER_ID},'${postrow.FIRSTNAME}');"><c:out value="${postrow.FIRSTNAME}"/></p>
										<p id="post-time"><c:out value="${postrow.POST_TIME}"/></p><hr>
										<div id="postspace">
											<p id="puserpost" class="${postrow.POSTID}"><c:out value="${postrow.POST_MSG}"/></p>
										</div>
										<div id="${postrow.POSTID}">
											<c:set var="ifbtn" value="True"/>
											<c:forEach var="likesrow" items="${postlikes.rows}">
												<c:if test="${postrow.POSTID==likesrow.POSTID}">
													<c:if test="${likesrow.USERID==sessionScope.UID}">
														<button id="" name="${postrow.POSTID}" class="dislike-btn" onclick="dislikepost(this.name);">Like</button>
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
												<button name="${postrow.POSTID}" class="like-btn" onclick="likepost(this.name);">Like</button>
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
							</c:if>
							<c:if test="${sessionScope.UID==forow.FRIENDS_TWO}">
								<c:if test="${postrow.POST_USERID==forow.FRIENDS_ONE}">
									<div id="singlepost">
										<img id="user-img" src=profilepics/${postrow.USERNAME}.jpg onerror="this.src = 'images/friendslogo.png';">
										<p id="pusername" onclick="showprofile(${sessionScope.UID},${postrow.USER_ID},'${postrow.FIRSTNAME}');"><c:out value="${postrow.FIRSTNAME}"/></p>
										<p id="post-time"><c:out value="${postrow.POST_TIME}"/></p><hr>
										<div id="postspace">
											<p id="puserpost" class="${postrow.POSTID}"><c:out value="${postrow.POST_MSG}"/></p>
										</div>
										<div id="${postrow.POSTID}">
											<c:set var="ifbtn" value="True"/>
											<c:forEach var="likesrow" items="${postlikes.rows}">
												<c:if test="${postrow.POSTID==likesrow.POSTID}">
													<c:if test="${likesrow.USERID==sessionScope.UID}">
														<button name="${postrow.POSTID}" class="dislike-btn" onclick="dislikepost(this.name);">Like</button>
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
												<button name="${postrow.POSTID}" class="like-btn" onclick="likepost(this.name);">Like</button>
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
							</c:if>
						</c:if>
					</c:forEach>
				</c:forEach>
			</div>
		</div>






		<div id="overlay">
			<div id="post-send">
				<textarea id="popup-postsendmsg" name="pmsg"></textarea>
				<button id="popup-post-btn" onclick="sendpostmsg()">Post</button>
			</div>

			<div id="close-popup" onclick="close_popup()" ></div>

			<div id="post-edit">
				<div id="post-edit-bg">
					<textarea id="popup-posteditmsg"></textarea>
					<button id="popup-post-upbtn" title="see" onclick="updatePost(this.title)">Update</button>
				</div>
			</div>
		</div>





	</body>
</html>