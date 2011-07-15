class TopicsController < ApplicationController
  before_filter :authenticate_author!, :except => [:index, :show] 
  load_and_authorize_resource :forum
  load_and_authorize_resource :topic, :through => :forum, :shallow => true

  # GET /topics/1
  # GET /topics/1.xml
  def show
    @topic = Topic.find(params[:id])
    tt = current_author.topictracks.for_topic(@topic)
    @posts = Kaminari.paginate_array(@topic.posts).page(params[:page]).per(15)
    if tt == nil then
    	tt = current_author.topictracks.new({'topic_id' => @topic.id})
	tt.last_time_viewed = @posts.last.updated_at
	tt.save
    elsif @posts.last.updated_at > tt.last_time_viewed then
	tt.last_time_viewed = @posts.last.updated_at
	tt.save
    end

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @topic }
    end
  end

  # GET /topics/new
  # GET /topics/new.xml
  def new
	@forum = Forum.find(params[:forum_id])
    @topic = @forum.topics.new 
	@topic.posts.build({"author_id" => current_author.id})

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @topic }
    end
  end

  # GET /topics/1/edit
  def edit
    @topic = Topic.find(params[:id])
  end

  # POST /topics
  # POST /topics.xml
  def create
	@forum = Forum.find(params[:forum_id])
    @topic = @forum.topics.new(params[:topic])
	@topic.author_id = current_author.id
    @topic.last_post_date = Time.now
    @topic.save
    tt = current_author.topictracks.new
    tt.topic_id = @topic.id
    tt.last_time_viewed = Time.now

    respond_to do |format|
      if @topic.save && tt.save
        format.html { redirect_to(@topic, :notice => 'Topic was successfully created.') }
        format.xml  { render :xml => @topic, :status => :created, :location => @topic }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @topic.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /topics/1
  # PUT /topics/1.xml
  def update
    @topic = Topic.find(params[:id])

    respond_to do |format|
      if @topic.update_attributes(params[:topic])
        format.html { redirect_to(@topic, :notice => 'Topic was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @topic.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /topics/1
  # DELETE /topics/1.xml
  def destroy
    @topic = Topic.find(params[:id])
    @topic.destroy
	forum = @topic.forum

    respond_to do |format|
      format.html { redirect_to(forum) }
      format.xml  { head :ok }
    end
  end
end
