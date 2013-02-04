class Survey < ActiveRecord::Base
  attr_accessible :name, :questions_attributes
  
  has_many :questions, 
    :dependent => :destroy
  accepts_nested_attributes_for :questions, 
    :reject_if => lambda { |question| question[:content].blank? }  
end
