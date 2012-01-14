class BlenderController < ApplicationController

  def index
    
  end

  def blend
    logger.debug "** Blender::Blend"
    logger.debug "* Params: #{params.inspect}"
    
    blender = Blender.new(params[:blender])
    Rails.logger.debug "* Blender: #{blender.valid?}"
    
    
    recipe = blender.blend
    
    Rails.logger.debug "* Recipe from BLENDER: #{blender.inspect}"
    
    if blender.valid? and recipe.save # If blender form is valid     
      redirect_to recipe, :notice => 'Recipe was successfully created.'
    else  
      render :action => "index" #Renders blender form again
    end
    
  end

end
