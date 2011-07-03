class FeaturesController < ApplicationController
	def show
		@feature = Feature.find(params[:id])
		add_breadcrumb 'Stories', stories_path
		add_breadcrumb @feature.setting.story.title, @feature.setting.story
		add_breadcrumb 'Setting', @feature.setting
		add_breadcrumb @feature.summary, ''
	end
	
	def new
		@setting = Setting.find(params[:setting_id])
		@feature = @setting.features.new
		add_breadcrumb 'Stories', stories_path
		add_breadcrumb @setting.story.title, @setting.story
		add_breadcrumb 'Setting', @setting
		add_breadcrumb 'New Feature', ''
	end
	
	def edit
		@feature = Feature.find(params[:id])
		add_breadcrumb 'Stories', stories_path
		add_breadcrumb @feature.setting.story.title, @feature.setting.story
		add_breadcrumb 'Setting', @feature.setting
		add_breadcrumb @feature.summary, @feature
		add_breadcrumb 'Edit Feature', ''
	end

	def create	
  		@setting = Setting.find(params[:setting_id])
    	@feature = @setting.features.new(params[:feature])
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
		@feature = Feature.find(params[:id])
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
		@feature = Feature.find(params[:id])
		@setting = @feature.setting
		@feature.destroy

		respond_to do |format|
		  format.html { redirect_to(@setting) }
		end
	end
end
