var CreateProxy = function(wsUri) {
	var websocket = null;
	var audio = null;
	var elements = null;
	
	var playSound = function() {
		if (audio == null) {
			audio = new Audio('content/sounds/beep.wav');
		}
		
		audio.play();
	};
	
	var displayMessage = function(msg) {
		var name = elements.txtMsg.name;
		var nameMsg = msg.split('-');
		
		if(nameMsg[1]=='typing'){
			if(nameMsg[0]!=name && !elements.showTyping.hasChildNodes()){
				var img = document.createElement('img');
				img.src = 'images/typing.gif';
				img.id = 'typing-gif';
	            elements.showTyping.appendChild(img);
			}
		}
		else if(nameMsg[1]=='notyping'){
			if(nameMsg[0]!=name && elements.showTyping.hasChildNodes()){
				elements.showTyping.removeChild(elements.showTyping.childNodes[0]);
			}
		}
		else{
			var div = document.createElement('div');
			var p = document.createElement('div');
			var textnode = document.createTextNode(nameMsg[1]);
			p.appendChild(textnode)
			if(nameMsg[0]==name){
				div.id = 'newmymsg';
				p.id = 'mymsg';
			}
			else{
				div.id = 'newfrndmsg';
				p.id = 'frndmsg';
			}
			div.appendChild(p);
			elements.msgContainer.appendChild(div);
			
			elements.msgContainer.scrollTop = elements.msgContainer.scrollHeight;
			if(nameMsg[0]!=name){
				playSound();
			}
		}

	};
	
	var clearMessage = function() {
		elements.msgContainer.innerHTML = '';
	};
	
	return {
		login: function() {
			this.logout();
			elements.txtMsg.focus();
			
			var room = elements.msgController.title;
			var name = elements.txtMsg.name;
			if (name == '' && room == '') { return; }
			
			// Initiate the socket and set up the events
			if (websocket == null) {
		    	websocket = new WebSocket(wsUri);
		    	
		    	websocket.onopen = function() {
		    		var message = { roomNum: room, messageType: 'LOGIN', message: name };
		    		websocket.send(JSON.stringify(message));
		        };
		        websocket.onmessage = function(e) {
		        	displayMessage(e.data);
		        };
		        websocket.onerror = function(e) {};
		        websocket.onclose = function(e) {
		        	websocket = null;
		        	clearMessage();
		        };
			}
		},
		sendMessage: function() {
			elements.txtMsg.focus();
			
			if (websocket != null && websocket.readyState == 1) {
				var input = elements.txtMsg.value.trim();
				var room = elements.msgController.title;
				if (input == '') { return; }
				
				elements.txtMsg.value = '';
				var message = {  roomNum: room, messageType: 'MESSAGE', message: input };
				
				// Send a message through the web-socket
				websocket.send(JSON.stringify(message));
			}
		},
		typing: function() {
			elements.txtMsg.focus();
			if(websocket != null && websocket.readyState == 1){
				var room = elements.msgController.title;
				var name = elements.txtMsg.name;
				var message = {roomNum: room, messageType: 'TYPING', message:name};
				
				websocket.send(JSON.stringify(message));
			}
			
		},
		notTyping: function() {
			elements.txtMsg.focus();
			if(websocket != null && websocket.readyState == 1){
				var room = elements.msgController.title;
				var name = elements.txtMsg.name;
				var message = {roomNum: room, messageType: 'NOTYPING', message:name};
				
				websocket.send(JSON.stringify(message));
			}
		},
		sendMessage_keyup: function(e) { 
			if (e.keyCode == 13) { 
				this.sendMessage(); 
			}
			setTimeout(this.notTyping(),3000);
		},
		logout: function() {
			if (websocket != null && websocket.readyState == 1) { websocket.close();}
		},
		initiate: function(e) {
			elements = e;
			elements.txtMsg.focus();
		}
	}
};