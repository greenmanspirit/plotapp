class StoriesController < ApplicationController
  add_breadcrumb 'Create new story', '', :only => [:new, :create]
  add_breadcrumb 'Edit Story', '', :only => [:edit, :update]
  before_filter :authenticate_author!, :except => [:index, :show]
  load_and_authorize_resource

  # GET /stories
  # GET /stories.xml
  def index
    @stories = Kaminari.paginate_array(Story.public_stories).page(params[:page]).per(25)
	add_breadcrumb 'Stories', ''

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @stories }
    end
  end

  # GET /stories/1
  # GET /stories/1.xml
  def show
	add_breadcrumb 'Stories', stories_path()
	add_breadcrumb @story.title, ''

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @story }
    end
  end

  # GET /stories/new
  # GET /stories/new.xml
  def new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @story }
    end
  end

  # GET /stories/1/edit
  def edit
  end

  # POST /stories
  # POST /stories.xml
  def create
	@story.author = current_author

    respond_to do |format|
      if @story.save
        format.html { redirect_to(@story, :notice => 'Story was successfully created.') }
        format.xml  { render :xml => @story, :status => :created, :location => @story }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @story.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /stories/1
  # PUT /stories/1.xml
  def update

    respond_to do |format|
      if @story.update_attributes(params[:story])
        format.html { redirect_to(@story, :notice => 'Story was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @story.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /stories/1
  # DELETE /stories/1.xml
  def destroy
    @story.destroy

    respond_to do |format|
      format.html { redirect_to(:root) }
      format.xml  { head :ok }
    end
  end

	def fan
		fan = Storyfan.new
		fan.story_id = params[:story_id]
		fan.author_id = current_author.id
		fan.save!
		@story = Story.find(params[:story_id])
	end
	def defan
		fan = Storyfan.first(:conditions=>["story_id = ? AND author_id = ?", params[:story_id], current_author.id])
		fan.destroy
		@story = Story.find(params[:story_id])
	end
end
