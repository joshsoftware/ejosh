class HomeController < ApplicationController
  before_filter :check_go_live
  before_filter :load_page
  before_filter :load_headers
  before_filter :load_footers
  before_filter :load_categories
  before_filter :load_page_sections
  before_filter :load_crawler_scripts
  layout 'home'

  def general
    @data = ERB.new(@page.description)
  end

  def load_headers
    @headers = Navigation.headers.active.order_by_sequence
    @quicklinks = Navigation.quick_links.active.order_by_sequence
    @site = Site.first
  end

  def load_categories
    @categories = @page.categories.active.order_by_sequence.uniq
    @category = Category.find_by_permalink(params[:category]) if params[:category]
#    params[:category] ?  @category = Category.find_by_permalink(params[:category]) : @category = @page.categories.first
    load_page_tags
  end

  def load_page
    @page = Page.find_by_name(params[:page]) 
  end

  def load_crawler_scripts
    @crawlers = Crawler.active
  end

  def load_page_sections
  @page_sections = Array.new 
  if params[:category] 
    @category.page_section_categories.for_page(@page).order_by_sequence.each do |p|
      @page_sections << p.page_section
    end
  elsif params[:tag]
    @page_sections = PageSection.tagged_with( remake_sanitized_url(params[ :tag ]), :on => :tags )
  else
    @page.page_section_categories.no_category.order_by_sequence.each do |p|
      @page_sections << p.page_section
    end
  end
  end

  def load_page_tags
    @category_tags = PageSection.tag_counts_on(@page.name) if @page.category_tag_cloud
    @tags = PageSection.tag_counts_on(:tags) if @page.tag_cloud
  end

  def load_footers
    @footers = Navigation.footers.active.order_by_sequence
  end

end
