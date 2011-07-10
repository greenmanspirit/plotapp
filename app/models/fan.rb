class Fan < ActiveRecord::Base
	belongs_to :author
	belongs_to :fan, :class_name => "Author", :foreign_key => "fan_id"
end
