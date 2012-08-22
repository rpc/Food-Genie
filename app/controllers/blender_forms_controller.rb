class BlenderFormsController < ApplicationController

  def index
    redirect_to :new
  end

  def show
  end

  def new
    @blender_form = BlenderForm.new
  end

  def create
    @blender_form = BlenderForm.new(params[:blender_form])
    #recipe = @blender.blend
    
    #Rails.logger.debug "* Recipe from BLENDER: #{@blender.inspect}"
    
    if @blender_form.valid? #&& recipe.save
      #redirect_to recipe, :notice => 'Recipe was blended successfully.' 
      put "ada"
    else
      render :new
    end  
  end
end
