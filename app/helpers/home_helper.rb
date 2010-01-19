
module HomeHelper
  def loop_count(contents)
    loop = (contents.size / 2) + contents.size % 2
  end 

  def check_active(page, category)
    active = ''
    active = "active" if get_category_permalink(category) == params[:category ]
  end

  def get_page_section(page, category)
    category.page_sections.for_page(page).first.display_name
  end

  def get_category_permalink(category)
    category.permalink
  end
  def get_category_permalink_with_tag(tag)
    category = Category.find_by_display_name(tag)
    return category.permalink
  end

  def get_page_for_tag(page, tag)
    category = Category.find_by_display_name(tag)
    if !category.pages.include?(page)
      page_name = category.pages.with_tag_cloud.first.name if category.pages.with_tag_cloud.first
      page_name = category.pages.first.name if !page_name
      return page_name
    end
    return page.name
  end

  def process_erb_data(content)
    data = ERB.new(content)
    return data.result(binding)
  end
end
