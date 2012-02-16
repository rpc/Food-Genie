class Watcher < ActiveRecord::Base

  def build_watcher(search_options, search_field, request, controller_name, action_name)
   unless (search_options.blank? || search_field.blank?)
    Watcher.create(:query => search_field, 
                   :who => request.remote_ip,
                   :time => search_options[:time],
                   :category => search_options[:category],
                   :difficulty => search_options[:difficulty],
                   :action => controller_name+":"+action_name)
    end
  end
end
