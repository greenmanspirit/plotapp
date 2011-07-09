class Setting < ActiveRecord::Base
	belongs_to :story
	has_many :features, :dependent => :destroy
	validates_presence_of :summary

	def parent s
		s.story
	end
end
