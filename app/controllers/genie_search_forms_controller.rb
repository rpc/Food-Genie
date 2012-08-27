class GenieSearchFormsController < ApplicationController

  def new
    @genie_search_form = GenieSearchForm.new
  end

  def show
    
  end

  def create
    @genie_search_form = GenieSearchForm.new(params[:genie_search_form])
    if @genie_search_form.valid?
      search = Search.new(params[:genie_search_form])
      @result = search.preform_search
      render :show
    else
      render :new
    end
  end 
  
end
