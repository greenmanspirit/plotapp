class Story < ActiveRecord::Base
	has_many :plotpoints, :dependent => :destroy
	has_many :characters, :dependent => :destroy
	has_one :setting, :dependent => :destroy
	belongs_to :author

	validates_presence_of :title

	def self.public_stories(user = nil)
		if(user == nil) then
			where(["private = ?", false]).all(:order => 'random()')
		else
			where(["private = ?", false])
		end
	end
	def self.ten_public_stories
		where(["private = ?", false]).all(:order => 'random()', :limit => 10)
	end
	def self.private_stories
		where(["private = ?", true]).all
	end
	def parent s
		s.author
	end
end
