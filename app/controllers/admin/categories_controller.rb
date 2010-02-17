class Admin::CategoriesController < ApplicationController
  before_filter :login_required 
  before_filter :check_go_live 
  layout 'admin/home'
  def index
    if params[:pc]
      value = params[:pc]
      @category_collect = Category.paginate(:all,
                                            :conditions => [" display_name LIKE ?", "%#{value}%"],
                                            :per_page => $LMT_PAGE, :page => params[:page])
    else
      @category_collect = Category.all.paginate(:per_page => $LMT_PAGE, :page => params[:page])
    end
  end

  def new
    @category = Category.new 
  end

  def create
    @category = Category.new(params[:category])
    @category.permalink = make_url(params[:category][:display_name]) 
    if save(@category)
      redirect_to admin_categories_path
    else
      render :action => 'new'
    end
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update 
    @category = Category.find(params[:id])
    params[:category][:permalink] = make_url(params[:category][:display_name]) 
    if update_fields(@category, params[:category])  
      redirect_to admin_categories_path
    else
      render :action => 'edit'
    end
  end

  def destroy
    Category.find(params[:id]).destroy
    redirect_to admin_categories_path
  end

  def enable
    @category = Category.find(params[:id]) 
    @category.is_enabled = params[:state]
    update_field(@category)
    redirect_to admin_categories_path
  end

end
