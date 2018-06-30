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
				<li class="active"><a href="homepage.jsp">Homepage</a></li>
				<li class=""><a href="users.jsp">Users</a></li>
				<li class=""><a href="friendrequests.jsp">FriendRequests<span id="newreq-div"><span id="newfrndreq"></span></span></a></li>
				<li class=""><a href="friends.jsp">Friends</a></li>
				<li class=""><a href="messages.jsp">Messages<span id="newmsgs-div"><span id="newmsgs"></span></span></a></li>
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