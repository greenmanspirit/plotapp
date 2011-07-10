class AuthorsController < Devise::RegistrationsController
	def profile
		@author = Author.find(params[:id])
		add_breadcrumb 'Authors', authors_path
		add_breadcrumb @author.username, ''
	end
	def index
		@authors = Author.page(params[:page]).per(20)
		add_breadcrumb 'Authors', ''
	end
	def fan
		fan = Authorfan.new
		fan.author_id = params[:id]
		fan.fan_id = current_author.id
		fan.save!
		@author = Author.find(params[:id])
	end
	def defan
		fan = Authorfan.first(:conditions=>["author_id = ? AND fan_id = ?", params[:id], current_author.id])
		fan.destroy
		@author = Author.find(params[:id])
	end
end
