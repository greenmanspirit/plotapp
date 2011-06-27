class Virtue < ActiveRecord::Base
	belongs_to :character
	validates_presence_of :details
end
