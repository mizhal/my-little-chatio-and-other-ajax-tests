class ChatsController < ApplicationController
  ## pantalla de entrada
  def login
    
  end

  ## accion en segundo plano que verifica que el nick no esta en uso
  def check_user
    user = User.find_by_nick params[:nick]
    unless user
      render :template => "chats/check_user_proceed"
    else
      render :template => "chats/check_user_error"
    end
  end

  ## pantalla de la sala de chat
  def chatroom
    @user = User.new :nick => params[:nick]
    unless @user.save
      flash[:error] = "Error al registrar al nuevo usuario"
      redirect_to chats_login_path
    else
      @current_messages = Message.order("created_at desc").limit(15)
      @current_messages.reverse!
    end
  end

  ## accion en segundo plano de refresco de la pantalla de la sala de chat
  def update_chatroom
    last_update = DateTime.parse params[:last_update]
    @messages = Message.where("created_at > ?", last_update)
    render json: {messages: @messages, last_update: DateTime::now}
  end

  ## accion en segundo plano que sube el mensaje al servidor
  def post_message
    Message.create :nick => params[:nick], :message => params[:message]
  end
  
end
