<html>
<head>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
	<title>LOGIN</title>
	<link rel="icon" type="image/png" href="images/logo.png">
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
	<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>
	
	<script type="text/javascript" src="scripts/signin.js"></script>
	<link rel="stylesheet" type="text/css" href="content/styles/signin.css">
	
</head>
<body>
	<img id="main-logo" src="images\friendslogo.png">

	<h1>LOGIN</h1>
	<hr style="background-color: grey; margin-top: 0;" width="90%" size="5px">
	<br><br>
	<div id="signin">
		<form method="post" action="login.jsp">
			<fieldset>
				<table>
					<tr><td><input id="user" pattern=".{1,}" title="1 characters minimum" type="text" name="LUSERNAME" required placeholder="Username" ></td></tr>
					<tr><td><input id="pass" pattern=".{1,}" title="1 characters minimum" type="password" name="LPASSWORD" required placeholder="Password" ></td></tr>
				</table>
				<input id="but0" type="submit" value="LOGIN">
				<input type="button" id="but1" class="buttons" onclick="openNav()" value="SIGNUP">
			</fieldset>
		</form>
		<c:if test="${not empty param.errorMessage}">
		  <div class="alert alert-warning alert-dismissable page-msg">
		    <a href="#" class="close" data-dismiss="alert" aria-label="close">×</a>
		    <c:out value="${param.errorMessage}"/>
		  </div>
		</c:if>
		<c:if test="${not empty param.signupMsg}">
		  <div class="alert alert-info alert-dismissable page-msg">
		    <a href="#" class="close" data-dismiss="alert" aria-label="close">×</a>
		    <strong>Info!</strong> <c:out value="${param.signupMsg}"/>
		  </div>
		</c:if>
		<c:if test="${not empty param.successMsg}">
		  <div class="alert alert-success alert-dismissable page-msg">
		    <a href="#" class="close" data-dismiss="alert" aria-label="close">×</a>
		    <strong>Congratulation!</strong> <c:out value="${param.successMsg}"/>
		  </div>
		</c:if>
	</div>
	<br><br>
	<div id="signupoverlay" class="overlay">
	<div id="closeoverlay"  onclick="closeNav()"></div>
	<br>
	<div class="overlay-content">
		<form action="loaddata.jsp" method="post">
			<h2>Sign Up!!!</h2>
			<fieldset style="box-shadow: 6px 6px 10px #222;">
				<legend align="left">New Contact</legend>
					<input id="iuser"  type="text" pattern=".{1,}" title="1 characters minimum" name="SUSERNAME" maxlength="32" required placeholder="Username*"><br><br><br>
					<input id="ifirst" type="text" pattern=".{1,}" title="1 characters minimum" name="FIRSTNAME" maxlength="32" required placeholder="First Name*"><br><br><br>
					<input id="ilast" type="text"  name="LASTNAME" maxlength="32" placeholder="Last Name"><br><br><br>
					<input id="ipass" type="password" pattern="[a-zA-Z0-9.!@#$%^*_|]{1,}" title="1 characters minimum" name="SPASSWORD" maxlength="8" required placeholder="Password*"><br><br><br>
					<input id="iemail" type="Email" name="EMAIL" placeholder="Email"><br><br>
				<input id="but2" type="submit" name="Submit">
			</fieldset>	
		</form>
	</div>
	</div>
	<br>
	
</body>
</html>