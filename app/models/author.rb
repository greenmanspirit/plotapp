class Author < ActiveRecord::Base
  has_many :stories, :dependent => :destroy
  has_many :authorfans
  has_many :fans, :through => :authorfans
  has_many :messages, :dependent => :destroy
  has_many :posts
  has_many :topictracks

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :confirmable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :username, :bio, :photo, :roles

  has_attached_file :photo, :default_url => "/images/:style/missing.png",
			    :styles => {:profile => "200x200>", :thumb => "150x150>"}
  validates_attachment_size :photo, :less_than => 5.megabytes
  validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/png']

  validates_length_of :username, :within => 6..16
  validates_uniqueness_of :username, :id

  scope :with_role, lambda { |role| {:conditions => "roles_mask & #{2**ROLES.index(role.to_s)} > 0"} }
  
  ROLES = %w[admin moderator author]
	  
  def roles=(roles)
    self.roles_mask = (roles & ROLES).map { |r| 2**ROLES.index(r) }.sum
  end
			    
  def roles
    ROLES.reject { |r| ((roles_mask || 0) & 2**ROLES.index(r)).zero? }
  end

  def roles?(role)
  	roles.include? role.to_s
  end

  def update_with_password(params={})
  	params.delete(:current_password)
	self.update_without_password(params)
  end

  def fave_authors
  	Authorfan.all(:conditions=>['fan_id = ?', id])
  end
  def fave_stories
  	Storyfan.all(:conditions=>['author_id = ?', id])
  end
end
