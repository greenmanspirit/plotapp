class Feature < ActiveRecord::Base
	belongs_to :setting
	validates_presence_of :detail

	def parent f
		f.setting
	end
end
