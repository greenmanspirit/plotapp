class AuthorsController < ApplicationController
	load_and_authorize_resource

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

	def edit
	end
	
	def update
		params[:author].delete(:password) if params[:author][:password].blank?
		params[:author].delete(:password_confirmation) if params[:author][:password].blank? and params[:author][:password_confirmation].blank?
		if @author.update_attributes(params[:author])
		  flash[:notice] = "Successfully updated User."
		  redirect_to root_path
		else
		  render :action => 'edit'
		end
	end
	
	def destroy
		if @author.destroy
		  flash[:notice] = "Successfully deleted User."
		  redirect_to root_path
		end
	end
end
