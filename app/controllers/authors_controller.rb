class AuthorsController < Devise::RegistrationsController
	def profile
		@author = Author.find(params[:id]);
	end
end
