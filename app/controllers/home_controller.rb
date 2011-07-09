class HomeController < ApplicationController
  def index
  	if author_signed_in? then
		@authorPublicStories = current_author.stories.ten_public_stories
		@authorPrivateStories = current_author.stories.private_stories
	end
	@allPublicStories = Story.public_stories;
  end
end
