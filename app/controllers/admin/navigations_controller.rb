class Admin::NavigationsController < ApplicationController
  before_filter :login_required 
  before_filter :check_go_live 
  layout 'admin/home'
  def index
    unless params[:scope].blank?
      if params[:scope] == HEADER_NAVIGATION_TYPE
        @navigation_collect = Navigation.headers.order_by_sequence
      elsif params[:scope] == QUICK_LINK_NAVIGATION_TYPE
        @navigation_collect = Navigation.quick_links.order_by_sequence
      else params[:scope] == FOOTER_NAVIGATION_TYPE
        @navigation_collect = Navigation.footers.footers.order_by_sequence  
      end
    else
      @navigation_collect = Navigation.headers.order_by_sequence  
    end
    @navigation_collect = @navigation_collect.paginate(:per_page => $LMT_PAGE, :page => params[:page])
  end

  def new
    @navigation = Navigation.new 
  end

  def create
    @navigation = Navigation.new(params[:navigation])

    if params[:scope] == HEADER_NAVIGATION_TYPE
      @navigation.navigation_type = 0
      if Navigation.headers.blank?
        @navigation.sequence = 1
      else
        @navigation.sequence = Navigation.headers.order_by_sequence.last.sequence + 1
      end
    elsif params[:scope] == QUICK_LINK_NAVIGATION_TYPE
      @navigation.navigation_type = 2
      if Navigation.quick_links.blank?
        @navigation.sequence = 1
      else
        @navigation.sequence = Navigation.quick_links.order_by_sequence.last.sequence + 1
      end
    else params[:scope] == FOOTER_NAVIGATION_TYPE
      @navigation.navigation_type = 1
      if Navigation.footers.blank?
        @navigation.sequence = 1
      else
        @navigation.sequence = Navigation.footers.order_by_sequence.last.sequence + 1
      end
    end
   
    #  call save from application_controller
    save(@navigation)
    if @navigation.errors.blank?
      redirect_to new_admin_navigation_path(:scope => params[:scope])
    elsif
      render :action => 'new'
    end
  end

  def edit
    @navigation = Navigation.find(params[:id])
  end

  def update 
    @navigation = Navigation.find(params[:id])
    update_fields(@navigation, params[:navigation])

    if @navigation.valid?
      redirect_to admin_navigations_path(:scope => params[:scope])
    else
      render :action => :edit
    end
  end

  def destroy
    Navigation.find(params[:id]).destroy
    redirect_to admin_navigations_path(:scope => params[:scope])
  end

  def enable
    @navigation = Navigation.find(params[:id]) 
    @navigation.is_enabled = params[:state]
    update_field(@navigation) 
    redirect_to admin_navigations_path(:scope => params[:scope])
  end

  def move
    @navigation = Navigation.find(params[:id])
    if params[:mv] == "up"
      @navigation_temp = Navigation.find(:last, :conditions => ["navigation_type = ? AND sequence < ?",@navigation.navigation_type, @navigation.sequence], :order => "sequence")
    else
      @navigation_temp = Navigation.find(:first, :conditions => ["navigation_type = ? AND sequence > ?",@navigation.navigation_type, @navigation.sequence], :order => "sequence")
    end

    new_sequence = @navigation_temp.sequence
    @navigation_temp.sequence = @navigation.sequence
    @navigation.sequence = new_sequence
    
    update_field(@navigation)
    update_field(@navigation_temp)

    redirect_to admin_navigations_path(:scope => params[:scope])
  end

  def apply
  end
end
