class FoodGenieController < ApplicationController



  def index
  end

  def search
    # Test Strings:
    # chocolate, ovo; carne; coisas
    # ada , ddsd ; dasd ..  - fefw +err fwfe adsad egg eggs food meats chocolates
  
    logger.debug "** Controller: FoodGenie :: Action: Search\n* Params: #{params}"
    watch_search

    search = Search.new(params[:search_options])
    @result_find = search.preform_search(params[:ingredient][:food_item_name])
    Rails.logger.debug "* @Result Find #{@result_find.inspect}"
    search.valid?  
  end
  
  private  
  def watch_search    
    watcher = Watcher.new
    watcher.build_watcher(params[:search_options],params[:ingredient][:food_item_name], request, controller_name, action_name)
  end

end
