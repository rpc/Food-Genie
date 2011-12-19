class FoodGenieController < ApplicationController
  def index
  end

  def search
  
    logger.debug "** Controller: FoodGenie :: Action: Search"
    logger.debug "* Params: #{params}"
    
    @result_recipe = "my recp"
    search = Search.new params    
    
    
  end

end
