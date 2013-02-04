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

function render_template(template_div /* :NodoHTML */, variables /* :Dict{String -> String} */){
	var text = template_div.html();
	for(var key in variables){
		text = text.replace(new RegExp("{{"+ key +"}}", "igm"), variables[key]);
	}
	return text
}

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
		var conversation = chatroom.find("div.conversation");
		var user_list = chatroom.find("div.users");
		setInterval(function() {
			var request = $.ajax({
				url : "/chats/update_chatroom",
				type: "GET",
				data: {
					last_update : chatroom.find("div.conversation").attr("data-last-update")
				}
			});
			request.done(function(data){
				for(var i = 0; i < data.messages.length; i++){
					var msg = data.messages[i];
					conversation.append(
						"<div class='message'>" + 
						msg.nick + " &gt; " + msg.message + "</div>"
					);
				}
				user_list.html("");
				for(var i = 0; i < data.users.length; i++){
					var user = data.users[i];
					user_list.append('<div class="user">' + user.nick + '</div>')
				}
				conversation.attr("data-last-update", data.last_update);
				
				if(data.messages.length > 0)
					conversation.animate({ scrollTop: conversation.prop('scrollHeight') }, "slow");
			});
			request.fail(function(){
				alert("Error al actualizar la conversacion");
			});
		}, 
		1000);
		
		conversation.animate({ scrollTop: conversation.prop('scrollHeight') }, "slow");
	}
	
	$("button.question-new-button").on("click", function(){
		
		var template = $("div.question-template").first();
		if(template.length < 1){
			alert("No hay plantilla");
			return false;
		}
		var questions = $("div.questions");
		questions.append(
			render_template(template, 
				{pos:questions.children().length}
			)
		);
		
		return false;
	});
})
