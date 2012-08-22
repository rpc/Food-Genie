class GenieSearchFormsController < ApplicationController

  def new
    @genie_search_form = GenieSearchForm.new
  end

  def create
    @genie_search_form = GenieSearchForm.new(params[:genie_search_form])
    if @genie_search_form.valid?
      redirect_to @genie_search_form, notice: 'Genie search form was successfully created.'
    else
      render :new
    end
  end 
  
end
