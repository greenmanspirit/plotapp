class Character < ActiveRecord::Base
	has_many :vices
	has_many :virtues
	has_many :habits
end
