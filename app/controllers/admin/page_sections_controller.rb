class Admin::PageSectionsController < ApplicationController
  before_filter :login_required 
  before_filter :check_go_live 
  layout 'admin/home'
  uses_tiny_mce(:options => AppConfig.advanced_mce_options, :only => [:new, :edit])

  def index
    if params[:ps]
      value = params[:ps]
      @page_sections = PageSection.paginate(:all,
                                            :conditions => [" display_name LIKE ? or title LIKE ?", "%#{value}%", "%#{value}%" ],
                                            :per_page => $LMT_PAGE, :page => params[:page])
    else
      @page_sections = PageSection.paginate(:all, :per_page => $LMT_PAGE, :page => params[:page])
    end
  end

  def new
    @page_section = PageSection.new
    @tags = PageSection.tag_counts_on(:tags)
  end

  def show
    @page_section = PageSection.find(params[:id])
    render :layout => false 
  end

  def create
    @page_section = PageSection.new(params[:page_section])
    params[:page_section][:display_name] = make_url(params[:page_section][:display_name]) #Create a url
    params[:page_section][:content] = sanitize_description(params[:page_section][:content]) #sanitize_description
    if save(@page_section)
      redirect_to admin_page_sections_path
    else
      render :action => 'new'
    end
  end
  def edit
    @page_section = PageSection.find(params[:id])
    @tags = PageSection.tag_counts_on(:tags)
  end

  def update
    @page_section = PageSection.find(params[:id])
    params[:page_section][:display_name] = make_url(params[:page_section][:display_name]) #Create a url
    params[:page_section][:content] = sanitize_description(params[:page_section][:content]) #sanitize_description
    if update_fields(@page_section, params[:page_section])  
      redirect_to admin_page_sections_path
    else
      render :action => 'edit'
    end
  end

  def destroy
    PageSection.find( params[:id] ).destroy
    flash[:notice] = 'Page Section successfully deleted.'
    redirect_to admin_page_sections_path()
  end
  def sanitize_description(desc)
    return desc.gsub('&lt;%', '<%').gsub('%&gt;', '%>').gsub('=&gt;', '=>').gsub('&lt;','<').gsub('&gt;','>')
  end

  def search
    @page_sections = PageSection.search(params[:ps]).paginate(:per_page => $LMT_PAGE, :page => params[:page])

    render :action => :index
  end

  def preview
    @content = params[:page_section][:content]
    render :layout => false
  end

end
