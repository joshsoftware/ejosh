class Admin::SitesController < ApplicationController
  before_filter :login_required 
  before_filter :check_go_live 
  layout 'admin/home'
  def index
    @site = Site.first
    if @site.blank?
      redirect_to new_admin_site_path
    end
  end

  def new
    @site = Site.new
  end

  def create
    @site = Site.new(params[:site])
    save(@site)
    redirect_to admin_sites_path
  end

  def edit
    @site = Site.find(params[:id])
  end

  def update
    @site = Site.find(params[:id])
    update_fields(@site, params[:site])

    redirect_to admin_sites_path
  end

  def go_live
    site = Site.first
    $GO_LIVE = site.go_live = true
    site.save!
    redirect_to admin_sites_path
  end

end
