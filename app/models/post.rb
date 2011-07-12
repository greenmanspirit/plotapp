class Post < ActiveRecord::Base
	belongs_to :author
	belongs_to :topic
	validates_presence_of :text
end
