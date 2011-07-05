class Plotpoint < ActiveRecord::Base
  acts_as_list
  belongs_to :story
  validates_presence_of :summary, :details

  def parent pp
  	pp.story
  end
end
