class BlenderController < ApplicationController

  def blend
    logger.debug "** Blender::Blend"
    logger.debug "* Params: #{params.inspect}"
    
    blender = Blender.new(params[:blender])
    blender.blend
  end

end
