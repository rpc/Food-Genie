class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :debug_print

  def debug_print
  	Rails.logger.debug "** #{controller_name}::#{action_name}"
  	Rails.logger.debug "* Params: #{params.inspect}"
  end
end
