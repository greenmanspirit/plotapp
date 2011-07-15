class PostsController < ApplicationController
  before_filter :authenticate_author!, :except => [:index, :show]
  load_and_authorize_resource :topic
  load_and_authorize_resource :post, :through => :topic, :shallow => true

  # GET /posts/new
  # GET /posts/new.xml
  def new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @post }
    end
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.xml
  def create
    @post.author = current_author
    @topic.last_post_date = Time.now
    tt = current_author.topictracks.first(:conditions=>['topic_id = ?', params[:topic_id]])
    if tt == nil then
	tt = current_author.topictracks.new
	tt.topic_id = params[:topic_id]
    end
    tt.last_time_viewed = Time.now

    respond_to do |format|
      if @post.save && tt.save
        format.html { redirect_to(@topic, :notice => 'Post was successfully created.') }
        format.xml  { render :xml => @post, :status => :created, :location => @post }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @post.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /posts/1
  # PUT /posts/1.xml
  def update
    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html { redirect_to(@post, :notice => 'Post was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @post.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.xml
  def destroy
    @post.destroy

    respond_to do |format|
      format.html { redirect_to(posts_url) }
      format.xml  { head :ok }
    end
  end
end
