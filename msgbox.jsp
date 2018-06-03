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