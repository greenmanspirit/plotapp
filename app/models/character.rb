class Character < ActiveRecord::Base
	has_many :vices
	has_many :virtues
	has_many :habits

	validates_presence_of :name
end
