class Character < ActiveRecord::Base
	has_many :vices, :dependent => :destroy
	has_many :virtues, :dependent => :destroy
	has_many :habits, :dependent => :destroy
	belongs_to :story

	accepts_nested_attributes_for :virtues, :allow_destroy=>true, :reject_if => proc { |attr| attr['detail'].blank? }
	accepts_nested_attributes_for :vices, :allow_destroy=>true, :reject_if => proc { |attr| attr['detail'].blank? }
	accepts_nested_attributes_for :habits, :allow_destroy=>true, :reject_if => proc { |attr| attr['detail'].blank? }

	validates_presence_of :name
	validates_numericality_of :age, 
				:only_integer => true, 
				:greater_than_or_equal_to => 0,
				:message => "must be 0 or a positive whole number."
	
	has_attached_file :photo, :default_url => "/images/:style/missing.png",
			    :styles => {:profile => "200x200>", :thumb => "150x150>"}
  	validates_attachment_size :photo, :less_than => 5.megabytes
  	validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/png']

	def parent ch
		ch.story
	end
end
