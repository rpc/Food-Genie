class BlenderFormsController < ApplicationController

  def index
    redirect_to :new
  end

  def new
    @blender_form = BlenderForm.new
  end

  def create
    @blender_form = BlenderForm.new(params[:blender_form])
   
    if @blender_form.valid?
      blender = Blender.new(@blender_form)
      @recipe = blender.blend

      if @recipe.save        
        redirect_to edit_recipe_path(@recipe), :notice => 'This what your recipe will look like, please check it :)'
      else
        render :new
      end
    else
      render :new
    end  
  end
end
