class FeaturesController < ApplicationController
	def show
		@feature = Feature.find(params[:id])
	end
	
	def new
		@setting = Setting.find(params[:setting_id])
		@feature = @setting.features.new
	end

	def create	
  		@setting = Setting.find(params[:setting_id])
    	@feature = @setting.features.new(params[:feature])
    	respond_to do |format|
    		if @feature.save
        		format.html { redirect_to(@feature, :notice => 'Feature was successfully created.') }
      		else
        		format.html { render :action => "new" }
			end
		end
	end 

end
