class ApplicationController < ActionController::Base
  protect_from_forgery
  
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
  
  add_breadcrumb 'Home', '/'
end
