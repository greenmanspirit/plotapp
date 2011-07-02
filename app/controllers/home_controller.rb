class HomeController < ApplicationController
  def index
  	if author_signed_in? then
		@authorPublicStories = current_author.stories.select do |v|
			v.private == false;
		end

		@authorPrivateStories = current_author.stories.select do |v|
			v.private == true;
		end
	end

	@allPublicStories = Story.all(:conditions => ["private = ?", false]);

  end

end
