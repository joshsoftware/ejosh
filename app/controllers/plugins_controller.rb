class PluginsController < ApplicationController
  layout 'admin/home'
  def index
    extension = Extension.first;

    redirect_to extension.entry_point if extension.entry_point
  end

  
end
