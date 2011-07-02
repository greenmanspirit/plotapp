class Setting < ActiveRecord::Base
	belongs_to :story
	has_many :features
	validates_presence_of :summary
end
