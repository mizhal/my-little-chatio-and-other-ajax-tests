class User < ActiveRecord::Base
  attr_accessible :logged_in, :nick
  
  def session_expired
    return (Time::now - self.created_at) > 60 ## la diferencia sale en segundos
  end
  
  before_save :update_heartbeat
  def update_heartbeat
    self.heartbeat = DateTime::now
  end
end
