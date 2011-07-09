class HomeController < ApplicationController
  def index
  	if author_signed_in? then
		@authorPublicStories = current_author.stories.public_stories(@current_author)
		@authorPrivateStories = current_author.stories.private_stories
	end
	@allPublicStories = Story.public_stories;
  end
end
