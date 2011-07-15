class PlotpointsController < ApplicationController
	before_filter :authenticate_author!, :except => [:index, :show]
  load_and_authorize_resource :story
  load_and_authorize_resource :plotpoint, :through => :story, :shallow => true

  # GET /plotpoints
  # GET /plotpoints.xml
  def index
    @plotpoints = @story.plotpoints.all(:order => "position")
	add_breadcrumb 'Stories', stories_path
	add_breadcrumb @story.title, @story
	add_breadcrumb 'Plot Designer', ''

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @plotpoints }
    end
  end

  # GET /plotpoints/1
  # GET /plotpoints/1.xml
  def show
	add_breadcrumb 'Stories', stories_path
	add_breadcrumb @plotpoint.story.title, @plotpoint.story
	add_breadcrumb 'Plot Designer', story_plotpoints_path(@plotpoint.story)
	add_breadcrumb @plotpoint.summary, ''

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @plotpoint }
    end
  end

  # GET /plotpoints/new
  # GET /plotpoints/new.xml
  def new
	add_breadcrumb 'Stories', stories_path
	add_breadcrumb @story.title, @story
	add_breadcrumb 'Plot Designer', story_plotpoints_path(@plotpoint.story)
    add_breadcrumb 'Create new plot point', ''

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @plotpoint }
    end
  end

  # GET /plotpoints/1/edit
  def edit
	add_breadcrumb 'Stories', stories_path
	add_breadcrumb @plotpoint.story.title, @plotpoint.story
	add_breadcrumb 'Plot Designer', story_plotpoints_path(@plotpoint.story)
	add_breadcrumb @plotpoint.summary, @plotpoint
    add_breadcrumb 'Edit plot point', ''
  end

  # POST /plotpoints
  # POST /plotpoints.xml
  def create
	add_breadcrumb 'Stories', stories_path
	add_breadcrumb @plotpoint.story.title, @plotpoint.story
	add_breadcrumb 'Plot Designer', story_plotpoints_path(@plotpoint.story)
    add_breadcrumb 'Create new plot point', ''

    respond_to do |format|
      if @plotpoint.save
        format.html { redirect_to(@plotpoint, :notice => 'Plotpoint was successfully created.') }
        format.xml  { render :xml => @plotpoint, :status => :created, :location => @plotpoint }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @plotpoint.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /plotpoints/1
  # PUT /plotpoints/1.xml
  def update
	add_breadcrumb 'Stories', stories_path
	add_breadcrumb @plotpoint.story.title, @plotpoint.story
	add_breadcrumb 'Plot Designer', story_plotpoints_path(@plotpoint.story)
    add_breadcrumb 'Edit plot point', ''

    respond_to do |format|
      if @plotpoint.update_attributes(params[:plotpoint])
        format.html { redirect_to(@plotpoint, :notice => 'Plotpoint was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @plotpoint.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /plotpoints/1
  # DELETE /plotpoints/1.xml
  def destroy
	@story = @plotpoint.story;
    @plotpoint.destroy

    respond_to do |format|
      format.html { redirect_to(story_plotpoints_path(@story)) }
      format.xml  { head :ok }
    end
  end

  def sort
    params[:plotpoint].each_with_index do |id, index|
      Plotpoint.update_all(['position=?', index+1], ['id=?', id])
    end
    render :nothing => true
  end
end
