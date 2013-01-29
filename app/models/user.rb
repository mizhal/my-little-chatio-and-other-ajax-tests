class User < ActiveRecord::Base
  attr_accessible :logged_in, :nick
end
