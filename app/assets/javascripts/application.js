// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap
//= require_tree .

$(document).ready(function() {

	// CALCULADORA
	$("a[data-type='op']").click(function() {
		var request = $.ajax({
			url : "/calculadoras/operar.json",
			type : 'GET',
			data : {
				op1 : $("input[name='op1']").val(),
				op2 : $("input[name='op2']").val(),
				op : $(this).attr("data-op")
			}
		})

		request.done(function(response) {
			$("span[data-id='res']").html(response.res);
		})

		request.fail(function() {
			alert("Error");
		});

		return false;
	});

	// CHAT
	var chatroom = $("div.chatroom");
	if (chatroom.length > 0) {
		alert("welcome to chat")
		setInterval(function() {
			var request = $.ajax({
				url : "/chats/update_chatroom",
				type: "GET",
				data: {
					last_update : chatroom.find("div.conversation").attr("data-last-update")
				}
			});
			request.done(function(data){
				var conversation = chatroom.find("div.conversation");
				for(var i = 0; i < data.messages.length; i++){
					var msg = data.messages[i]
					conversation.append("<p>"+ msg.nick + "(" + msg.created_at + ") &gt; " + msg.message + "</p>")
				}
				conversation.attr("data-last-update", data.last_update);
			});
			request.fail(function(){
				alert("Error al actualizar la conversacion");
			});
		}, 
		5000);
	}
})
