class UsersController < ApplicationController
  before_filter :login_required 
  before_filter :check_go_live 
  # Be sure to include AuthenticationSystem in Application Controller instead
  include AuthenticatedSystem
  layout 'admin/home'

  def index
    @users = User.all.paginate(:per_page => $LMT_PAGE, :page => params[:page])
  end

  # render new.rhtml
  def new
    @user = User.new
    select_employee
  end

  def create
    cookies.delete :auth_token
    # protects against session fixation attacks, wreaks havoc with 
    # request forgery protection.
    # uncomment at your own risk
    # reset_session
    @user = User.new(params[:user])
    save(@user)
    if params[:employee]
      update_employee(params[:employee][:id], @user.id)
    end
    if @user.errors.empty?
      # the user loggen in is set as the current user
      #self.current_user = @user
      if params[:scope].blank?
        redirect_to users_path
      elsif
        redirect_to employee_path
      end
    else
      render :action => 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
    select_employee
  end

  def update
    @user = User.find(params[:id])
    update_fields(@user, params[:user])
    if params[:employee]
      emp_id = params[:employee][:id]
      update_employee(emp_id, params[:id])
    end
    redirect_to users_path
  end

  def update_employee(emp_id, user_id)
    if emp_id != ""
      @employee = Employee.find(emp_id)
      @employee.user_id = user_id
      @employee.save!
    end
  end

  def destroy
    if params[:id].to_i != 1
      User.find(params[:id]).destroy
      redirect_to session_path(:method => 'delete') if params[:id] == current_user.id 
      redirect_to users_path
    else
      flash[:notice] = "Admin user can not be deleted"
      render :action => "index"
    end
  end

  def activate
    @user = User.find(params[:id])
    @user.is_active = params[:scope]

    update_field(@user)
    redirect_to users_path
  end

  def select_employee
    if Extension.find_extension(EM_EXTENSION).blank?
      @employees = nil
    elsif
      @employees = Employee.all.collect { |employee| ["#{employee.first_name + ' ' + employee.last_name }", employee.id ] }
    end
  end
end
