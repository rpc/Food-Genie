class BlenderController < ApplicationController

  def blend
    logger.debug "** Blender::Blend"
    logger.debug "* Params: #{params.inspect}"
    
    # ISTO TEM QUE SAIR
    unless params[:blender].blank?
    blender = Blender.new(params[:blender])
    blender.blend
    end
  end

end
