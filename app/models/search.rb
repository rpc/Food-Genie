class Search
  def initialize(params)
    Rails.logger.debug "* Params: #{params.inspect}"
    
    result_set = nil
    unless params.blank?
      result_set = parse_entry_string params
    end
    
    return result_set    
  end
  
  def parse_entry_string entry_string
     # entry_array = entry_string.gsub(/[^A-Za-z\+\-]/, ' ').split(' ').delete_if {|word| word.end_with?("-") or  word.end_with?("+") }
     entry_array = entry_string.gsub(/[^A-Za-z]/, ' ').split(' ')
                                                                                 
  end
  
end
