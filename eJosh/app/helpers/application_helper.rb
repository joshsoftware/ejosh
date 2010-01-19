# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  include TagsHelper
  # TO set the flag for advanced user and provide the extra functionalites in future
  def advanced_user?
    return false
  end
  def sanitize_url(name)
    return name.gsub(' ','_').gsub('.','dot')
  end
end
