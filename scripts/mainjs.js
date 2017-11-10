var updateinterval = 15000;

function togle() {
	var h = document.getElementById("msg-box").clientHeight;
	if(h==324){
		document.getElementById("msg-box").style.height='25px';
		document.getElementById('txtMsg').style.display = 'none';
	}
	else if(h==19){
		document.getElementById("msg-box").style.height='330px';
		document.getElementById('txtMsg').style.display = 'block';
	}
}

function close_msg() {
	interval=10000;
	document.getElementById("msg-box").style.display='none';
	document.getElementById("txtMsg").style.display='none';
}

function onlineboxtogle() {
	var h = document.getElementById("online-box").clientHeight;
	if(h==294){
		document.getElementById("online-box").style.height='40px';
	}
	else if(h==34){
		document.getElementById("online-box").style.height='300px';
	}
}


function showbox(frndid,myid,frndname,msgRoom) {
	interval=2000;
  	document.getElementById('disp-msg').style.display = 'block';
	document.getElementById("msg-box").style.display='block';
	document.getElementById("msg-box").style.height='330px';
	document.getElementById("user-name").innerHTML = frndname;
	document.getElementById('msgController').title = msgRoom;
	document.getElementById('user-name').title = frndname;
	document.getElementById('disp-msg').title = frndid;
	document.getElementById('txtMsg').style.display = 'block';
	
	getMessages(myid,frndid);
}

function getMessages(mid,fid){
	var xhttp;
	xhttp = new XMLHttpRequest();
	xhttp.onreadystatechange = function(){
		if(this.readyState == 4 && this.status == 200){
			document.getElementById("msgContainer").innerHTML = this.responseText;
		}
	};
	xhttp.open("POST", "getmessages.jsp", true);
	xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
	xhttp.send("myid="+mid+"&frid="+fid);
}

function showdiv(id) {
	if(id=='about'){
		document.getElementById('posts-div').style.display = 'none';
		document.getElementById('ul-friends').style.display = 'none';
		document.getElementById('ul-about').style.display = 'block';
	}
	else if(id=='friends'){
		document.getElementById('posts-div').style.display = 'none';
		document.getElementById('ul-friends').style.display = 'block';
		document.getElementById('ul-about').style.display = 'none';
	}
}

function likepost(pid,mid) {
	var xhttp;
	xhttp = new XMLHttpRequest();
	xhttp.onreadystatechange = function() {
		if (this.readyState == 4 && this.status == 200) {
		    document.getElementById(pid).innerHTML = this.responseText;
		}
	};
	xhttp.open("POST", "updateposts.jsp", true);
	xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
	xhttp.send("postid="+pid+"&myid="+mid+"&work=like");
}

function dislikepost(pid,mid) {
	var xhttp;
	xhttp = new XMLHttpRequest();
	xhttp.onreadystatechange = function() {
		if (this.readyState == 4 && this.status == 200) {
		    document.getElementById(pid).innerHTML = this.responseText;
		}
	};
	xhttp.open("POST", "updateposts.jsp", true);
	xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
	xhttp.send("postid="+pid+"&myid="+mid+"&work=dislike");
}


function showprofile(uid,fpid,fpn) {
	if(uid==fpid)
		window.location = "profile.jsp";
	else
		window.location = "friendprofile.jsp?friendid="+fpid+"&fname="+fpn;
}

function profileFromMsgBox(name){
	var id = document.getElementById("disp-msg").title;
	window.location = "friendprofile.jsp?friendid="+id+"&fname="+name;
}

function sendParam(btname,frId,page) {
	window.location = "updatefriends.jsp?friendid="+btname+"&myid="+frId+"&work=accept&page="+page;
}

function sendDelete(btname,frId,page) {
	window.location = "updatefriends.jsp?friendid="+btname+"&myid="+frId+"&work=delete&page="+page;
}

function sendRequestParam(btname,frId) {
	window.location = "updatefriends.jsp?friendid="+btname+"&myid="+frId+"&work=request";
}

function showcomments(postid){
	var disp = document.getElementsByClassName('comment-div');
	var i;
	for (i = 0; i < disp.length; i++) {
		if(disp[i].title==postid){
			if(disp[i].style.display == 'none')
				disp[i].style.display = 'block';
			else if(disp[i].style.display == 'block')
				disp[i].style.display = 'none'
			else
				disp[i].style.display = 'block';
		}
	}
}

function postComm(postid,uid) {
	var xhttp;
	var cmntmsg = document.getElementsByClassName('cmnt-msg');
	var k;
	for(k=0; k<cmntmsg.length;k++){
		if(cmntmsg[k].title==postid){
			var cmsg = cmntmsg[k].value;
			if(cmntmsg[k].value!=''){
				cmntmsg[k].value = "";
				xhttp = new XMLHttpRequest();
				xhttp.onreadystatechange = function() {
					if (this.readyState == 4 && this.status == 200) {
					    var cmt = document.getElementsByClassName('singlecomment');
					    var j;
						for (j = 0; j < cmt.length; j++) {
							if(cmt[j].title==postid){
								cmt[j].innerHTML = this.responseText;
							}
						}
					}
				};
				xhttp.open("POST", "comment.jsp", true);
				xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
				xhttp.send("postid="+postid+"&myid="+uid+"&cmnt="+cmsg);
			}
		}
	}		
}

function getupdates() {
	getrequpdates();
	getmsgupdates();
	getOnlineUsers();
	setTimeout(getupdates, updateinterval);
}

function getOnlineUsers(){
	var xhttp;
	xhttp = new XMLHttpRequest;
	xhttp.onreadystatechange = function(){
		if(this.readyState == 4 && this.status == 200) {
			document.getElementById("online-box").innerHTML = this.responseText;
		}
	};
	xhttp.open("GET", "getonlineusers.jsp", true);
	xhttp.send();
}

function getrequpdates() {
	var xhttp;
	xhttp = new XMLHttpRequest;
	xhttp.onreadystatechange = function(){
		if(this.readyState == 4 && this.status == 200) {
			document.getElementById("newreq-div").innerHTML = this.responseText;
		}
	};
	xhttp.open("GET", "updatereqnotif.jsp", true);
	xhttp.send();
}


function getmsgupdates() {
	var xhttp;
	xhttp = new XMLHttpRequest;
	xhttp.onreadystatechange = function(){
		if(this.readyState == 4 && this.status == 200) {
			document.getElementById("newmsgs-div").innerHTML = this.responseText;
		}
	};
	xhttp.open("GET", "updatemsgsnotif.jsp", true);
	xhttp.send();
}