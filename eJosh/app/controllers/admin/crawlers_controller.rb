class Admin::CrawlersController < ApplicationController

  layout 'admin/home'

  def index
    @crawlers = Crawler.all.paginate(:per_page => $LMT_PAGE, :page => params[:page])
  end

  def new
    @crawler = Crawler.new
  end

  def create
    @crawler = Crawler.new(params[:crawler])
    save(@crawler)

    redirect_to admin_crawlers_path
  end
  
  def edit
    @crawler = Crawler.find(params[:id])
  end

  def update
    @crawler = Crawler.find(params[:id])
    update_fields(@crawler, params[:crawler])

    redirect_to admin_crawlers_path
  end

  def enable
    @crawler = Crawler.find(params[:id]) 
    @crawler.is_enabled = params[:state]
    update_field(@crawler) 
    redirect_to admin_crawlers_path(:scope => params[:scope])
  end

end
