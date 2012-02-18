class BlendersController < ApplicationController

layout "blender"

  def index
     redirect_to :action => "new"
  end 

  def new
    @blender = Blender.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @blender }
    end
  end

  def create
    logger.debug "** Blender::Blend"
    logger.debug "* Params: #{params.inspect}"
    
    @blender = Blender.new(params[:blender])
    recipe = @blender.blend
    
    Rails.logger.debug "* Recipe from BLENDER: #{@blender.inspect}"
    
    if @blender.valid? && recipe.save
      redirect_to recipe, :notice => 'Recipe was blended successfully.' 
    else
      render :action => "new"
    end   
  end
  
end
