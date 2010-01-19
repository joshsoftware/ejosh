class Admin::CustomLayoutsController < ApplicationController
  before_filter :login_required 
  before_filter :check_go_live 
  
  layout 'admin/home'
  def index
    @colors = Color.all
    @layouts = Layout.all
    @theme = Theme.selected.first
  end

  def new
      @layout = Layout.new
  end

  def create
    @layout = Layout.new(params[:layout])
    save(@layout)
    redirect_to admin_custom_layouts_path
  end
  
  def apply
    @theme_old = Theme.selected.first
    if !@theme_old.blank?
      @theme_old.is_selected = false
      update_field(@theme_old)  
    end
    @theme = Theme.select_theme(params[:theme][:color_id], params[:theme][:layout_id]).first 
    @theme.is_selected = true
    update_field(@theme)  
    $THEME = Theme.selected.first.layout_id
    $COLOR = Theme.selected.first.color.name

    redirect_to admin_custom_layouts_path
  end

end
