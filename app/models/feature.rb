class Feature < ActiveRecord::Base
	belongs_to :setting
	validates_presence_of :detail
end
