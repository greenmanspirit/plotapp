class Forum < ActiveRecord::Base
	has_many :topics, :dependent => :destroy
	validates_presence_of :title
	validates_presence_of :description
end
