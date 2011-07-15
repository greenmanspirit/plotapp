class ApplicationController < ActionController::Base
  protect_from_forgery

  def current_ability
    @current_ability ||= Ability.new(current_author)
  end

  protected
    def add_breadcrumb name, url = ''
      @breadcrumbs ||= []
      url = eval(url) if url =~ /_path|_url|@/
      @breadcrumbs << [name, url]
	end
 
	def self.add_breadcrumb name, url, options = {}
	  before_filter options do |controller|
		controller.send(:add_breadcrumb, name, url)
	  end
	end
  
  	def permission object
		while !object.kind_of? Author do
			object = object.parent(object)
		end
		if object != current_author then
			flash[:error] = "You don't have permission to do that."
			redirect_to(:root)
		end
	end
  add_breadcrumb 'Home', '/'
end
