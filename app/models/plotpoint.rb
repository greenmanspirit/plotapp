class Plotpoint < ActiveRecord::Base
  belongs_to :story
  validates_presence_of :summary, :details
end
