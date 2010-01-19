# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  include AuthenticatedSystem

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  #

  # save the data by updating the user id
  def save(table_name)
    table_name.created_by = current_user
    table_name.save
  end

  
  def update_fields(table_name,attributes)
    table_name.updated_by = current_user
    table_name.update_attributes(attributes)
  end

  def update_field(table_name)
    table_name.updated_by = current_user
    table_name.save
  end

  def check_go_live 
    if current_user
       return if current_user.role.title == "Admin"
    end
    redirect_to :controller => 'site_under_construction' if !$GO_LIVE 
  end

  def make_url(name)
    return name.gsub(' ','_').gsub('.','dot')
  end

  def remake_sanitized_url(name)
    return name.gsub('dot','.').gsub('_',' ')
  end
end
