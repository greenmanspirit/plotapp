class Message < ActiveRecord::Base
	belongs_to :sender, :class_name => 'Author', :foreign_key => 'sender_id'
	belongs_to :recipient, :class_name => 'Author', :foreign_key => 'recipient_id'
	belongs_to :author
	validates_presence_of :body
	validates_presence_of :subject
	
	def self.inbox author_id
		where(['recipient_id = ?', author_id])
	end
	def self.outbox author_id
		where(['sender_id = ?', author_id])
	end
	def parent m
		m.author
	end
end
