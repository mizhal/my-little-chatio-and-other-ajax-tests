class ChatsController < ApplicationController
  ## pantalla de entrada
  def login

  end

  ## accion en segundo plano que verifica que el nick no esta en uso
  def check_user
    user = User.find_by_nick params[:nick]
    
    if user and user.session_expired
      user.destroy
      user = nil
    end
    
    if user == nil
      user = User.new :nick => params[:nick]
      if user.save
        render :template => "chats/check_user_proceed"
      else
        flash[:error] = "Error al registrar al nuevo usuario"
        redirect_to chats_login_path
      end
    else
      render :template => "chats/check_user_error"
    end
  end

  ## pantalla de la sala de chat
  def chatroom
    @user = User.find_by_nick params[:nick]
    if @user
      @current_messages = Message.order("created_at desc").limit(15)
      @current_messages.reverse!
      @current_users = User.order("heartbeat desc")
        .where("heartbeat > ?", (Time::now - 5 * 60))
    else
      redirect_to chats_login_path
    end
  end

  ## accion en segundo plano de refresco de la pantalla de la sala de chat
  def update_chatroom
    last_update = DateTime.parse params[:last_update]
    @messages = Message.where("created_at > ?", last_update)
    if @messages.empty?
      next_update = last_update
    else
      next_update = @messages.last.created_at
    end
    
    @users = User.order("heartbeat desc")
        .where("heartbeat > ?", (Time::now - 5 * 60))
    render json: {messages: @messages, last_update: next_update, users: @users}
  end

  ## accion en segundo plano que sube el mensaje al servidor
  def post_message
    user = User.find_by_nick params[:nick]
    if params[:message].strip() != "\\leave"
      Message.create :nick => params[:nick], :message => params[:message]
      @salir = false
      user.update_attribute(:heartbeat, DateTime::now)
    else
      user = User.find_by_nick params[:nick]
      user.destroy if user
      @salir = true
    end
  end

end
