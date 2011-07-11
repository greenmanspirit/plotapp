class Message < ActiveRecord::Base
	belongs_to :sender, :class_name => 'Author', :foreign_key => 'sender_id'
	belongs_to :recipient, :class_name => 'Author', :foreign_key => 'recipient_id'
	validates_presence_of :body
	validates_presence_of :subject
end
