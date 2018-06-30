function popup_post_send(){
    document.getElementById('overlay').style.display = 'block';
    document.getElementById('overlay').style.top = '0px';
    document.getElementById('post-send').style.display = 'block';
    document.getElementById('hide-on-popup').style.display = 'none';
    document.getElementById('sendpost').style.height = '180px';
    document.getElementById('popup-postsendmsg').focus();
    document.documentElement.style.overflow = 'hidden';
}

function close_popup(){
    document.getElementById('overlay').style.display = 'none';
    document.getElementById('post-send').style.display = 'none';
    document.getElementById('post-edit').style.display = 'none';
    document.getElementById('hide-on-popup').style.display = 'block';
    document.documentElement.style.overflow = 'scroll';
}

function popup_post_edit(postId){
    var getPost = document.getElementsByClassName(postId);
    var postMsg = getPost[0].innerHTML;
    var scrollTop = (window.pageYOffset !== undefined) ? window.pageYOffset : (document.documentElement || document.body.parentNode || document.body).scrollTop;
    document.getElementById('overlay').style.display = 'block';
    document.getElementById('overlay').style.top = scrollTop + 'px';
    document.getElementById('post-edit').style.display = 'block';
    document.getElementById('popup-posteditmsg').innerHTML = postMsg;
    document.documentElement.style.overflow = 'hidden';
    document.getElementById('popup-post-upbtn').title = postId;
    document.getElementById('popup-posteditmsg').focus();
}

function updatePost(postId){
    var pmsg = document.getElementById('popup-posteditmsg').value;
    var xhttp;
    xhttp = new XMLHttpRequest();
    xhttp.onreadystatechange = function(){
        if(this.readyState == 4 && this.status == 200){
            window.location = "homepage.jsp";
        }
    }
    xhttp.open("POST", "posts.jsp", true);
    xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    xhttp.send("pid="+postId+"&pmsg="+pmsg+"&work=update");
}

function popup_post_delete(postId){
    var xhttp;
    xhttp = new XMLHttpRequest();
    xhttp.onreadystatechange = function(){
        if(this.readyState == 4 && this.status == 200){
            window.location = "homepage.jsp";
        }
    }
    xhttp.open("POST", "posts.jsp", true);
    xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    xhttp.send("pid="+postId+"&work=delete");
}

function sendpostmsg(){
    var pmsg = document.getElementById('popup-postsendmsg').value;
    var xhttp;
    xhttp = new XMLHttpRequest();
    xhttp.onreadystatechange = function(){
        if(this.readyState == 4 && this.status == 200){
            window.location = "homepage.jsp";
        }
    }
    xhttp.open("POST", "posts.jsp", true);
    xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    xhttp.send("pmsg="+pmsg+"&work=create");
}