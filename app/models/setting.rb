class Setting < ActiveRecord::Base
	belongs_to :story
	validates_presence_of :summary
end
