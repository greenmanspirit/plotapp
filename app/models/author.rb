class Author < ActiveRecord::Base
  has_many :stories
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :confirmable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :username, :bio, :photo

  has_attached_file :photo, :default_url => "/images/missing.png",
			    :styles => {:profile => "200x200>"}
  validates_attachment_size :photo, :less_than => 5.megabytes
  validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/png']

  def update_with_password(params={})
  	params.delete(:current_password)
	self.update_without_password(params)
  end
end
