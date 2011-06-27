class People < ActiveRecord::Base
	belongs_to :setting
	validates_presence_of :details
end
