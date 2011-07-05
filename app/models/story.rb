class Story < ActiveRecord::Base
	has_many :plotpoints
	has_many :characters
	has_one :setting
	belongs_to :author

	validates_presence_of :title

	def self.publicStories
		where(["private = ?", false]).all(:order => 'random()')
	end
	def self.tenPublicStories
		where(["private = ?", false]).all(:order => 'random()', :limit => 10)
	end
	def self.privateStories
		where(["private = ?", true]).all
	end
	def parent s
		s.author
	end
end
