class HomeController < ApplicationController
  def index
  	if author_signed_in? then
		@authorPublicStories = current_author.stories.tenPublicStories
		@authorPrivateStories = current_author.stories.privateStories
	end
	@allPublicStories = Story.publicStories;
  end
end
