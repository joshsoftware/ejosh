namespace :update_tags do

  desc <<-DESC
    Update the category tags created for the page Sections 
    Usage: rake update_tags:category
  DESC
  task :category => :environment do
    PageSectionCategory.find(:all, :conditions => ["category_id != 'nil'"]).each do |psc|
      psc.page_section.set_tag_list_on(psc.page.name, psc.page.name)
      psc.category.tag(psc.page_section, :with => psc.category.display_name, :on => psc.page.name)
      GC.start
    end
  end
end

