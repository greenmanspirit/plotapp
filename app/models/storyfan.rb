class Storyfan < ActiveRecord::Base
	belongs_to :story
	belongs_to :fan, :class_name => 'Author', :foreign_key => 'author_id'
end
