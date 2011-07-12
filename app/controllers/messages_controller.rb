class MessagesController < ApplicationController
  before_filter :authenticate_author!
	before_filter :only => [:show, :destroy] do |controller|
		permission(Message.find(controller.params[:id]))
	end
	before_filter :only => [:new, :create] do |controller|
		permission(current_author)
	end
  # GET /messages
  # GET /messages.xml
  def index
  	add_breadcrumb "Messages", ''
  	if params[:outbox]
    	@messages = current_author.messages.outbox current_author
		@type = :outbox
	else
    	@messages = current_author.messages.inbox current_author
		@type = :inbox
	end

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @messages }
    end
  end

  # GET /messages/1
  # GET /messages/1.xml
  def show
  	add_breadcrumb "Messages", :back
    @message = Message.find(params[:id])
	if @message.read == false then
		@message.read = true;
		@message.save
	end

	add_breadcrumb	@message.subject, ''
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @message }
    end
  end

  # GET /messages/new
  # GET /messages/new.xml
  def new
    @message = Message.new
	@author = Author.find(params[:recipient_id])
	add_breadcrumb @author.username, view_author_profile_path(@author)
	add_breadcrumb 'Compose', ''
	@message.recipient = @author
	@message.sender = current_author

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @message }
    end
  end

  # POST /messages
  # POST /messages.xml
  def create
    @message, @message2 = Message.new(params[:message]), Message.new(params[:message])
	@message.owner_id = current_author.id
	@message2.owner_id = params[:message][:recipient_id]
	@author = Author.find(params[:message][:recipient_id])
	add_breadcrumb @author.username, view_author_profile_path(@author)
	add_breadcrumb 'Compose', ''

    respond_to do |format|
      if @message.save && @message2.save
        format.html { redirect_to(view_author_profile_path(Author.find(params[:message][:recipient_id])), :notice => 'Message sent.') }
        format.xml  { render :xml => @message, :status => :created, :location => @message }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @message.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /messages/1
  # DELETE /messages/1.xml
  def destroy
    @message = Message.find(params[:id])
    @message.destroy

    respond_to do |format|
      format.html { redirect_to(:back) }
      format.xml  { head :ok }
    end
  end
end
