class FeaturesController < ApplicationController
	before_filter :authenticate_author!, :except => [:show]
	load_and_authorize_resource :setting
	load_and_authorize_resource :feature, :through => :setting, :shallow => true

	def show
		add_breadcrumb 'Stories', stories_path
		add_breadcrumb @feature.setting.story.title, @feature.setting.story
		add_breadcrumb 'Setting', @feature.setting
		add_breadcrumb @feature.summary, ''
	end
	
	def new
		add_breadcrumb 'Stories', stories_path
		add_breadcrumb @setting.story.title, @setting.story
		add_breadcrumb 'Setting', @setting
		add_breadcrumb 'New Feature', ''
	end
	
	def edit
		add_breadcrumb 'Stories', stories_path
		add_breadcrumb @feature.setting.story.title, @feature.setting.story
		add_breadcrumb 'Setting', @feature.setting
		add_breadcrumb @feature.summary, @feature
		add_breadcrumb 'Edit Feature', ''
	end

	def create	
		add_breadcrumb 'Stories', stories_path
		add_breadcrumb @setting.story.title, @setting.story
		add_breadcrumb 'Setting', @setting
		add_breadcrumb 'New Feature', ''
		
    	respond_to do |format|
    		if @feature.save
        		format.html { redirect_to(@feature, :notice => 'Feature was successfully created.') }
      		else
        		format.html { render :action => "new" }
			end
		end
	end 

	def update
		add_breadcrumb 'Stories', stories_path
		add_breadcrumb @feature.setting.story.title, @feature.setting.story
		add_breadcrumb 'Setting', @feature.setting
		add_breadcrumb @feature.summary, @feature
		add_breadcrumb 'Edit Feature', ''

		respond_to do |format|
			if @feature.update_attributes(params[:feature])
				format.html { redirect_to(@feature, :notice => 'Feature was successfully updated.') }
			else
				format.html { render :action => "edit" }
			end
		end
    end
	
	def destroy
		@setting = @feature.setting
		@feature.destroy

		respond_to do |format|
		  format.html { redirect_to(@setting) }
		end
	end
end
