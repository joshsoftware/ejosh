# This controller handles the login/logout function of the site.  
class SessionsController < ApplicationController
layout 'admin/home'
  # Be sure to include AuthenticationSystem in Application Controller instead
  include AuthenticatedSystem

  # render new.rhtml
  def new
  end

  def create
    self.current_user = User.authenticate(params[:login], params[:password])

    if logged_in? 
      if params[:remember_me] == "on"
        current_user.remember_me unless current_user.remember_token?
        cookies[:auth_token] = { :value => self.current_user.remember_token , :expires => self.current_user.remember_token_expires_at }
      end
      redirect_user
      flash[:notice] = error_messages(1) 
    else
      flash[:notice] = error_messages(2) 
      render :action => 'new'
    end
  end

  def destroy
    self.current_user.forget_me if logged_in?
    cookies.delete :auth_token
    reset_session
    #flash[:notice] = "You have been logged out."
    redirect_back_or_default('/')
  end

  def redirect_user
    if self.current_user.role == Role.find_by_title("Admin")
      if User.activated?(self.current_user)
        redirect_to admin_home_index_path
        return
      else
        flash[:notice] = error_messages(3)
      end
    else
      #flash[:notice] = error_messages(4) 
      redirect_to plugins_path
      return
    end
      self.current_user = nil
      render :action => 'new'
  end

  def error_messages(error_id)
    case error_id
    when 1 : "Logged in successfully"
    when 2 : "Please enter correct password"
    when 3 : "User is not activated."
    else "Comming soon"
    end
  end
  
end
