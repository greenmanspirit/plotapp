class Story < ActiveRecord::Base
	has_many :plotpoints
	has_many :characters
	has_one :setting
	belongs_to :author
end
