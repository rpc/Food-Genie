class BlenderFormsController < ApplicationController

  def index
    redirect_to action: "new"
  end

  # GET /blender_forms/1
  def show
  end

  # GET /blender_forms/new
  def new
    @blender_form = BlenderForm.new
  end

  # POST /blender_forms
  def create
    @blender_form = BlenderForm.new(params[:blender_form])
    #recipe = @blender.blend
    
    #Rails.logger.debug "* Recipe from BLENDER: #{@blender.inspect}"
    
    if@blender_form.valid? #&& recipe.save
      #redirect_to recipe, :notice => 'Recipe was blended successfully.' 
      put "ada"
    else
      render action: "new"
    end  
  end
end
