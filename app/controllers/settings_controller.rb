class SettingsController < ApplicationController
  # GET /settings/1
  # GET /settings/1.xml
  def show
    @setting = Setting.find(params[:id])
	@features = Kaminari.paginate_array(@setting.features).page(params[:page]).per(15)
	add_breadcrumb 'Stories', stories_path
	add_breadcrumb @setting.story.title, @setting.story
	add_breadcrumb 'Setting', ''

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @setting }
	  format.js
    end
  end

  # GET /settings/new
  # GET /settings/new.xml
  def new
  	@story = Story.find(params[:story_id])
    @setting = Setting.new
	add_breadcrumb 'Stories', stories_path
	add_breadcrumb @story.title, @story
	add_breadcrumb 'Create new setting', ''

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @setting }
    end
  end

  # GET /settings/1/edit
  def edit
    @setting = Setting.find(params[:id])
	add_breadcrumb 'Stories', stories_path
	add_breadcrumb @setting.story.title, @setting.story
	add_breadcrumb 'Edit setting', ''
  end

  # POST /settings
  # POST /settings.xml
  def create
  	@story = Story.find(params[:story_id])
    @setting = Setting.new(params[:setting])	
	@setting.story = @story
	add_breadcrumb 'Stories', stories_path
	add_breadcrumb @story.title, @story
	add_breadcrumb 'Create new setting', ''

    respond_to do |format|
      if @setting.save
        format.html { redirect_to(@setting, :notice => 'Setting was successfully created.') }
        format.xml  { render :xml => @setting, :status => :created, :location => @setting }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @setting.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /settings/1
  # PUT /settings/1.xml
  def update
    @setting = Setting.find(params[:id])
	add_breadcrumb 'Stories', stories_path
	add_breadcrumb @setting.story.title, @setting.story
	add_breadcrumb 'Edit setting', ''

    respond_to do |format|
      if @setting.update_attributes(params[:setting])
        format.html { redirect_to(@setting, :notice => 'Setting was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @setting.errors, :status => :unprocessable_entity }
      end
    end
  end
end
