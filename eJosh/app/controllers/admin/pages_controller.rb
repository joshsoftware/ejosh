class Admin::PagesController < ApplicationController
  before_filter :login_required 
  before_filter :check_go_live 
  layout 'admin/home'
#  require 'erb'
#  uses_tiny_mce(:options => AppConfig.default_mce_options, :only => [:new, :edit])
  before_filter :load_categories, :only => [:new, :edit, :update]

  def index
    if params[:s]
      value = params[:s]
        @pages = Page.paginate(:all, :conditions => [" name LIKE ? or title LIKE ?", "%#{value}%", "%#{value}%" ],
                                            :per_page => $LMT_PAGE, :page => params[:page])
     else 
       @pages = Page.all.paginate(:per_page => $LMT_PAGE, :page => params[:page])
     end
    @page = Page.new
  end

  def new
    @page = Page.new
    load_page_section_categories
  end

  def create
    # To replace the &lt; and &gt; with < and > respectively
    params[:page][:description] ? params[:page][:description] = sanitize_description(params[:page][:description]):
    params[:page][:name] = make_url(params[:page][:name]) #Create a url
    @page = Page.new(params[:page])
    if save(@page)
      redirect_to admin_pages_path
    else
      render :action => 'new'
    end
  end
  
  def show
    @page = Page.find(params[:id]) 
    @page_sections = PageSection.for_page(@page)
    @data = ERB.new(@page.description)
    render :layout => 'home'
  end

  def edit
    @page = Page.find(params[:id])
    load_page_section_categories
  end

  def update 
    @page = Page.find(params[:id])
    # To replace the &lt; and &gt; with < and > respectively
    params[:page][:description] ? params[:page][:description] = sanitize_description(params[:page][:description]):
    params[:page][:name] = make_url(params[:page][:name]) #Create a url
    if update_fields(@page, params[:page])  
      redirect_to admin_pages_path
    else
      load_page_section_categories
      render :action => 'edit'
    end
  end

  def add
    #index
    @page = Page.find(params[:id]).clone
    @page.is_default = false
    @page.title = params[:page][:title]
    @page.name =  make_url(params[:page][:title]) #Create a url
    if save(@page)
      redirect_to admin_pages_path
    else
      render :index
    end
  end

  def add_section
    @page = Page.find(params[:page])
    if params[:page_section]
    page_section = PageSection.find(params[:page_section])
    if params[:category][:selected] != ""
      category = Category.find(params[:category][:selected])
      page_section.set_tag_list_on(@page.name, @page.name)
      category.tag(page_section, :with => category.display_name, :on => @page.name)
    end
    psc = PageSectionCategory.new
    psc.page_id = @page.id 
    psc.category_id = params[:category][:selected]
    psc.page_section_id = params[:page_section]
    psc.sequence = @page.page_section_categories.count + 1
    psc.save!
    load_page_section_categories 
    if request.xhr?
      render :update do |page|
        page.replace_html "page_section_category", :partial => "admin/pages/page_section_category"
      end
    end
    else 
      if request.xhr?
        render :update do |page|
          page.replace_html "alert_message", "Please select a 'Page Section'."
        end
      end
    end
  end

  def destroy
    Page.find( params[:id] ).destroy
    flash[:notice] = 'Page successfully deleted.'
    redirect_to admin_pages_path
  end

  def load_categories
    @categories = Category.find(:all, :order => 'display_name')
    @page_sections = PageSection.find(:all, :order => 'title')
  end

  def load_page_section_categories
    @page_section_categories = @page.page_section_categories.order_by_sequence
  end

  def sanitize_description(desc)
    return desc.gsub('&lt;%', '<%').gsub('%&gt;', '%>').gsub('=&gt;', '=>')
  end


  def move
    psc = PageSectionCategory.find(params[:id])
    @page = psc.page
    if params[:mv] == "up"
      psc_temp = PageSectionCategory.find(:last, :conditions => ["sequence < ?", psc.sequence], :order => "sequence")
    else
      psc_temp = PageSectionCategory.find(:first, :conditions => ["sequence > ?", psc.sequence], :order => "sequence")
    end

    new_sequence = psc_temp.sequence
    psc_temp.sequence = psc.sequence
    psc.sequence = new_sequence
    update_field(psc)
    update_field(psc_temp)
    load_page_section_categories
    if request.xhr?
      render :update do |page|
        page.replace_html "page_section_category", :partial => "admin/pages/page_section_category"
      end
    end
  end

  def delete_psc
    psc = PageSectionCategory.find(params[:id])
    @page = psc.page
    tag = Tagging.find(:all, :conditions => ['taggable_id = ? and tagger_id = ? and context = ?', psc.page_section, psc.category, @page.name]).first
    tag.destroy if tag
    psc.destroy
    load_page_section_categories
    if request.xhr?
      render :update do |page|
        page.replace_html "page_section_category", :partial => "admin/pages/page_section_category"
        page.replace_html "alert_message", 'Page Section deleted successfully'
      end
    end
  end

  def search
    #@pages = Page.search(params[:s]).paginate(:per_page => $LMT_PAGE, :page => params[:page])
    @pages = Page.search(params[:s]).paginate(:per_page => $LMT_PAGE, :page => params[:page])
    @page = Page.new
    render :action => :index
  end
end
