var id;

function selectedfriend(msgRoom,mid,fid) {
	document.getElementById('msgController').title = msgRoom;
	var selected_friend = document.getElementsByClassName('new-friend');
	var i;
	for(i = 0;i < selected_friend.length;i++){
		if(selected_friend[i].id == msgRoom){
			selected_friend[i].style.background = '#c23030';
		}
		else{
			selected_friend[i].style.background = '#44728f';
		}
	}
	id = fid;
	getMessages(mid,fid);
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

var updateinterval = 15000;

function getupdates() {
	getrequpdates();
	getmsgupdates();
	setTimeout(getupdates, updateinterval);
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

