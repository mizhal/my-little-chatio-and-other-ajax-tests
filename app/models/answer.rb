class Answer < ActiveRecord::Base
  attr_accessible :content, :question_id, :text
  
  belongs_to :question
end
