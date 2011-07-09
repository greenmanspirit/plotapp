class CharactersController < ApplicationController
	before_filter :authenticate_author!, :except => [:index, :show]
	before_filter :only => [:edit, :update, :destroy] do |controller|
		permission(Character.find(controller.params[:id]))
	end
	before_filter :only => [:new, :create] do |controller|
		permission(Story.find(controller.params[:story_id]))
	end
  # GET /characters
  # GET /characters.xml
  def index
	@story = Story.find(params[:story_id])
    @characters = Character.all
  	add_breadcrumb "Stories", stories_path
	add_breadcrumb @story.title, @story
	add_breadcrumb "Characters", ''

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @characters }
    end
  end

  # GET /characters/1
  # GET /characters/1.xml
  def show
    @character = Character.find(params[:id])
  	add_breadcrumb "Stories", stories_path
	add_breadcrumb @character.story.title, @character.story
	add_breadcrumb "Characters", story_characters_path(@character.story)
	add_breadcrumb @character.name, ''

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @character }
    end
  end

  # GET /characters/new
  # GET /characters/new.xml
  def new
  	@story = Story.find(params[:story_id])
    @character = @story.characters.new
  	add_breadcrumb "Stories", stories_path
	add_breadcrumb @story.title, @story
	add_breadcrumb "Characters", story_characters_path(@story)
	add_breadcrumb "New character", ''

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @character }
    end
  end

  # GET /characters/1/edit
  def edit
    @character = Character.find(params[:id])
  	add_breadcrumb "Stories", stories_path
	add_breadcrumb @character.story.title, @character.story
	add_breadcrumb "Characters", story_characters_path(@character.story)
	add_breadcrumb @character.name, @character
	add_breadcrumb "Edit character", ''
  end

  # POST /characters
  # POST /characters.xml
  def create
  	@story = Story.find(params[:story_id])
    @character = @story.characters.new(params[:character])
  	add_breadcrumb "Stories", stories_path
	add_breadcrumb @story.title, @story
	add_breadcrumb "Characters", story_characters_path(@story)
	add_breadcrumb "New character", ''

    respond_to do |format|
      if @character.save
        format.html { redirect_to(@character, :notice => 'Character was successfully created.') }
        format.xml  { render :xml => @character, :status => :created, :location => @character }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @character.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /characters/1
  # PUT /characters/1.xml
  def update
    @character = Character.find(params[:id])
  	add_breadcrumb "Stories", stories_path
	add_breadcrumb @character.story.title, @character.story
	add_breadcrumb "Characters", story_characters_path(@character.story)
	add_breadcrumb @character.name, @character
	add_breadcrumb "Edit character", ''

    respond_to do |format|
      if @character.update_attributes(params[:character])
        format.html { redirect_to(@character, :notice => 'Character was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @character.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /characters/1
  # DELETE /characters/1.xml
  def destroy
    @character = Character.find(params[:id])
	@story = @character.story
    @character.destroy

    respond_to do |format|
      format.html { redirect_to(story_characters_url(@story)) }
      format.xml  { head :ok }
    end
  end
end
