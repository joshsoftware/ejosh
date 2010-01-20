class Admin::ExtensionsController < ApplicationController
  before_filter :login_required 
  before_filter :check_go_live 
  layout 'admin/home'
  def index
    @extensions = Extension.all
  end

  def new
    @extension = Extension.new
  end

  def create
    @extension = Extension.new(params[:extension])
    @extension.installed_by = current_user
    @extension.save!

    redirect_to admin_extensions_path
  end

  def edit
    @extension = Extension.find(params[:id])
  end

  def update
    @extension = Extension.find(params[:id])
    @extension.update_attributes(params[:extension])

    redirect_to admin_extensions_path
  end

  def update_plugin
    @extension = Extension.find(params[:id])
    # install the plugin
    path = 'ruby script/plugin install --force ' + @extension.repository_path 
    system(path)

    redirect_to admin_extensions_path
  end

  def install
    @extension = Extension.find(params[:id])
    # install the plugin
    if (!File.exist?(File.join('./vendor/plugin','employee','load.rb'))
      path = 'ruby script/plugin install ' + @extension.repository_path 
      system(path)
    end

    # execute the load.rb file from installed plugin to run the generators (migration etc)
    path = 'ruby vendor/plugins/' + @extension.display_name + '/load.rb ' + @extension.id.to_s
    system(path)

    redirect_to admin_extensions_path
  end

  def destroy
    @extension = Extension.find(params[:id])
    path = 'ruby script/plugin remove ' + @extension.display_name
    system(path)
    Extension.find(params[:id]).destroy

    redirect_to admin_extensions_path
  end

end
