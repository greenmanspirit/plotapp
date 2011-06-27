class Story < ActiveRecord::Base
	has_many :plotpoints
	has_many :characters
	has_one :setting
	belongs_to :author

	validates_presence_of :title
end
