class Admin::HomeController < ApplicationController
layout 'admin/home'
  before_filter :login_required 

  def index
    if current_user.role.title != "Admin"
      redirect_to plugins_path
    end
  end
end
