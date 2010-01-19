class Admin::UsersController < ApplicationController
  before_filter :login_required 
  layout 'admin/home'
  def index
  end
end
