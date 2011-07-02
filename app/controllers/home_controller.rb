class HomeController < ApplicationController
  def index
	@authorPublicStories = current_author.stories.select do |v|
		v.private == false;
	end

	@authorPrivateStories = current_author.stories.select do |v|
		v.private == true;
	end

	@allPublicStories = Story.all(:conditions => ["private = ?", false]);

  end

end
