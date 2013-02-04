class Question < ActiveRecord::Base
  attr_accessible :content, :survey_id, :answers_attributes
  
  belongs_to :survey
  has_many :answers, :dependent => :destroy
  accepts_nested_attributes_for :answers, 
    :reject_if => lambda {|answer| answer[:content].blank?},
    :allow_destroy => true
end
