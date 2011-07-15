class Ability
  include CanCan::Ability

  def initialize(user)
    alias_action :defan, :to => :fan
    user ||= Author.new # guest user (not logged in)

	#General permisions regardless of role
    can :read, :all
	can :profile, :all
	can [:read, :update, :destroy], Story, :author_id => user.id
	can :manage, Plotpoint do |pp|
		pp.story.author == user
	end
	can :manage, Character do |c|
		c.story.author == user
	end
	can :manage, Setting do |s|
		s.story.author == user
	end
	can :manage, Feature do |f|
		f.setting.story.author == user
	end
	can [:read, :update], Topic, :author_id => user.id
	can :manage, Post, :author_id => user.id
	can :manage, Message, :author_id => user.id

	#permissions specific to the author role
	if user.roles? :author
		can :create, Story
		can :fan, Story do |s|
			s.author.id != user.id
		end
		can :fan, Author do |a|
			a.id != user.id
		end
	end

	#permissions specific to the moderator role
	if user.roles? :moderator
		can :manage, Forum
		can :manage, Topic
		can :manage, Post
	end

	#permissions specific to the admin role
    if user.roles? :admin
    	can :manage, :all
	end
    #
    # The first argument to `can` is the action you are giving the user permission to do.
    # If you pass :manage it will apply to every action. Other common actions here are
    # :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. If you pass
    # :all it will apply to every resource. Otherwise pass a Ruby class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details: https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
end
