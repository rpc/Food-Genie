class FoodGenieController < ApplicationController
  def index
  end

  def search
    
    # Test Strings:
    # chocolate, ovo; carne; coisas
    # ada , ddsd ; dasd ..  - fefw +err fwfe adsad egg eggs food meats chocolates
  
    logger.debug "** Controller: FoodGenie :: Action: Search"
    logger.debug "* Params: #{params}"
    errors = []
    fn = []
    search = nil
    
    @result_recipe = "my recp"
    
    watch_search

    search = Search.new(params[:search_options])
    search.preform_search(params[:search_field])
    search.valid?
    flash[:errors] = search.errors
    flash[:notice] = search.info
    logger.debug "* Errors: #{errors.inspect} :: Msg: #{fn.inspect}"      
    
  end
  
  private
  
  def watch_search
    
    unless (params[:search_options].blank? || params[:search_field].blank?)
    Watcher.create(:query => params[:search_field], 
                   :who => request.remote_ip,
                   :time => params[:search_options][:time],
                   :category => params[:search_options][:category],
                   :difficulty => params[:search_options][:difficulty],
                   :action => controller_name+":"+action_name)
    end
  end

end
