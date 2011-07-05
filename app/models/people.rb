class People < ActiveRecord::Base
	belongs_to :setting
	validates_presence_of :details

	def parent p
		p.setting
	end
end
