<%@ page import = "java.io.*,java.util.*,java.sql.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix = "sql" %>


<sql:setDataSource var="snapshot" driver="${initParam.DB_DRIVER}" url="${initParam.DB_URL}" user="${initParam.DB_USER}" password="${initParam.DB_PASS}"/>

<sql:query dataSource="${snapshot}" var="result">
	SELECT * FROM USERS
</sql:query>

<sql:query dataSource="${snapshot}" var="friendone">
	SELECT * FROM USERS JOIN UPDATEFRIENDS ON USERS.USER_ID=UPDATEFRIENDS.FRIENDS_ONE
</sql:query>

<sql:query dataSource="${snapshot}" var="activeago">
	SELECT USER_ID,TIMESTAMPDIFF(SECOND,LASTLOGIN,NOW()) AS LASTLOGIN_SECONDS,TIMESTAMPDIFF(MINUTE,LASTLOGIN,NOW()) AS LASTLOGIN_MINUTES,TIMESTAMPDIFF(HOUR,LASTLOGIN,NOW()) AS LASTLOGIN_HOURS,TIMESTAMPDIFF(DAY,LASTLOGIN,NOW()) AS LASTLOGIN_DAYS FROM USERS
</sql:query>




<div id="online-user" onclick="onlineboxtogle();"><p>Online Users</p></div><hr>
<div id="scroll-div">
	<c:forEach var="forow" items="${friendone.rows}">
		<c:if test="${forow.STATUS==1}">
			<c:if test="${sessionScope.UID==forow.FRIENDS_ONE}">
				<c:forEach var="row" items="${result.rows}">
					<c:if test="${row.USER_ID==forow.FRIENDS_TWO}">
						<div id="frnd-div">
							<img id="onuser-img" src=profilepics/${row.USERNAME}.jpg onerror="this.src = 'images/friendslogo.png';">
							<p class="frnd-on" id="${forow.MSGCHN}" title="${row.FIRSTNAME}" onclick="showbox(${row.USER_ID},${sessionScope.UID},'${row.FIRSTNAME}',this.id);proxy.login();"><c:out value="${row.FIRSTNAME}"/></p>
							<c:if test="${row.ACTIVE==1}">
								<p id="active-light-on"></p>
							</c:if>
							<c:if test="${row.ACTIVE==0}">
								<c:forEach var="actago" items="${activeago.rows}">
									<c:if test="${actago.USER_ID==row.USER_ID}">
										<c:if test="${actago.LASTLOGIN_SECONDS < 59}">
											<p id="active-light-off"><c:out value="${actago.LASTLOGIN_SECONDS}"/>Secs</p>
										</c:if>
										<c:if test="${actago.LASTLOGIN_SECONDS > 60}">
											<c:if test="${actago.LASTLOGIN_SECONDS < 3599}">
												<c:if test="${actago.LASTLOGIN_MINUTES == 1}">
													<p id="active-light-off"><c:out value="${actago.LASTLOGIN_MINUTES}"/>Min</p>
												</c:if>
												<c:if test="${actago.LASTLOGIN_MINUTES > 1}">
													<p id="active-light-off"><c:out value="${actago.LASTLOGIN_MINUTES}"/>Mins</p>
												</c:if>
											</c:if>
										</c:if>
										<c:if test="${actago.LASTLOGIN_SECONDS > 3600}">
											<c:if test="${actago.LASTLOGIN_SECONDS < 89196}">
												<c:if test="${actago.LASTLOGIN_HOURS == 1}">
													<p id="active-light-off"><c:out value="${actago.LASTLOGIN_HOURS}"/>Hr</p>
												</c:if>
												<c:if test="${actago.LASTLOGIN_HOURS > 1}">
													<p id="active-light-off"><c:out value="${actago.LASTLOGIN_HOURS}"/>Hrs</p>
												</c:if>
											</c:if>
										</c:if>
										<c:if test="${actago.LASTLOGIN_SECONDS > 89196}">
											<c:if test="${actago.LASTLOGIN_DAYS == 1}">
												<p id="active-light-off"><c:out value="${actago.LASTLOGIN_DAYS}"/>Day</p>
											</c:if>
											<c:if test="${actago.LASTLOGIN_DAYS > 1}">
												<p id="active-light-off"><c:out value="${actago.LASTLOGIN_DAYS}"/>Days</p>
											</c:if>
										</c:if>
									</c:if>
								</c:forEach>
							</c:if>
						</div><hr>
					</c:if>
				</c:forEach>
			</c:if>
			<c:if test="${sessionScope.UID==forow.FRIENDS_TWO}">
				<c:forEach var="row" items="${result.rows}">
					<c:if test="${row.USER_ID==forow.FRIENDS_ONE}">
						<div id="frnd-div">
							<img id="onuser-img" src=profilepics/${row.USERNAME}.jpg onerror="this.src = 'images/friendslogo.png';">
							<p class="frnd-on" id="${forow.MSGCHN}" title="${row.FIRSTNAME}" onclick="showbox(${row.USER_ID},${sessionScope.UID},'${row.FIRSTNAME}',this.id);proxy.login();"><c:out value="${row.FIRSTNAME}"/></p>
							<c:if test="${row.ACTIVE==1}">
								<p id="active-light-on"></p>
							</c:if>
							<c:if test="${row.ACTIVE==0}">
								<c:forEach var="actago" items="${activeago.rows}">
									<c:if test="${actago.USER_ID==row.USER_ID}">
										<c:if test="${actago.LASTLOGIN_SECONDS < 59}">
											<p id="active-light-off"><c:out value="${actago.LASTLOGIN_SECONDS}"/>Secs</p>
										</c:if>
										<c:if test="${actago.LASTLOGIN_SECONDS > 60}">
											<c:if test="${actago.LASTLOGIN_SECONDS < 3599}">
												<c:if test="${actago.LASTLOGIN_MINUTES == 1}">
													<p id="active-light-off"><c:out value="${actago.LASTLOGIN_MINUTES}"/>Min</p>
												</c:if>
												<c:if test="${actago.LASTLOGIN_MINUTES > 1}">
													<p id="active-light-off"><c:out value="${actago.LASTLOGIN_MINUTES}"/>Mins</p>
												</c:if>
											</c:if>
										</c:if>
										<c:if test="${actago.LASTLOGIN_SECONDS > 3600}">
											<c:if test="${actago.LASTLOGIN_SECONDS < 89196}">
												<c:if test="${actago.LASTLOGIN_HOURS == 1}">
													<p id="active-light-off"><c:out value="${actago.LASTLOGIN_HOURS}"/>Hr</p>
												</c:if>
												<c:if test="${actago.LASTLOGIN_HOURS > 1}">
													<p id="active-light-off"><c:out value="${actago.LASTLOGIN_HOURS}"/>Hrs</p>
												</c:if>
											</c:if>
										</c:if>
										<c:if test="${actago.LASTLOGIN_SECONDS > 89196}">
											<c:if test="${actago.LASTLOGIN_DAYS == 1}">
												<p id="active-light-off"><c:out value="${actago.LASTLOGIN_DAYS}"/>Day</p>
											</c:if>
											<c:if test="${actago.LASTLOGIN_DAYS > 1}">
												<p id="active-light-off"><c:out value="${actago.LASTLOGIN_DAYS}"/>Days</p>
											</c:if>
										</c:if>
									</c:if>
								</c:forEach>
							</c:if>
						</div><hr>
					</c:if>
				</c:forEach>
			</c:if>
		</c:if>
	</c:forEach>
</div>










