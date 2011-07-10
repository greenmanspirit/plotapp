class Authorfan < ActiveRecord::Base
	belongs_to :author
	belongs_to :fan, :class_name => 'Author', :foreign_key => 'fan_id'
	
	attr_accessible :fan_id
end
