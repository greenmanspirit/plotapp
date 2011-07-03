class AuthorsController < Devise::RegistrationsController
	def profile
		@author = Author.find(params[:id]);
		add_breadcrumb 'Authors', authors_path
		add_breadcrumb @author.username, ''
	end
	def index
		@authors = Author.page(params[:page]).per(20);
		add_breadcrumb 'Authors', ''
	end
end
