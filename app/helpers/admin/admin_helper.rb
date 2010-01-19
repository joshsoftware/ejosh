module Admin::AdminHelper
 
  def get_help(type)

    if type == "page"
      help = "<span>Assign the page sections and categories to each page</span>"
    elsif type == "section"
      help = "<span>Add the page section first and then in Page menu assign the section to that page </span>"
    else
      help = "<span>Add the category and then in Page menu assign the category to the page section to that page </span>"
    end

    return help
  end


  def selected_style(selected_menu, value)
    if selected_menu == value
      return "selected"
    end
  end
end
