class Event < ActiveRecord::Base
	belongs_to :setting
	validates_presence_of :details

	def parent e
		e.setting
	end
end
