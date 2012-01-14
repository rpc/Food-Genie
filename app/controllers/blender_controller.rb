class BlenderController < ApplicationController


  def index
    
  end

  def blend
    logger.debug "** Blender::Blend"
    logger.debug "* Params: #{params.inspect}"
    
    blender = Blender.new(params[:blender])
    blender.blend
    
    #redirect_to :index
  end

end
