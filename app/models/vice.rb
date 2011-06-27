class Vice < ActiveRecord::Base
	belongs_to :character
	validates_presence_or :details
end
