class PlotpointsController < ApplicationController
  # GET /plotpoints
  # GET /plotpoints.xml
  def index
    @plotpoints = Plotpoint.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @plotpoints }
    end
  end

  # GET /plotpoints/1
  # GET /plotpoints/1.xml
  def show
    @plotpoint = Plotpoint.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @plotpoint }
    end
  end

  # GET /plotpoints/new
  # GET /plotpoints/new.xml
  def new
    @plotpoint = Plotpoint.new
    @plotpoint.story = Story.find(params[:id])

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @plotpoint }
    end
  end

  # GET /plotpoints/1/edit
  def edit
    @plotpoint = Plotpoint.find(params[:id])
  end

  # POST /plotpoints
  # POST /plotpoints.xml
  def create
    @plotpoint = Plotpoint.new(params[:plotpoint])

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
    @plotpoint = Plotpoint.find(params[:id])

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
    @plotpoint = Plotpoint.find(params[:id])
    @plotpoint.destroy

    respond_to do |format|
      format.html { redirect_to(plotpoints_url) }
      format.xml  { head :ok }
    end
  end
end
