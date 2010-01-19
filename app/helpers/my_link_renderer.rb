class MyLinkRenderer < WillPaginate::LinkRenderer
    def prepare( collection, options, template )
      @url = options[:url]
      @prev_class = options[:previous_class]
      @next_class= options[:next_class]
      super
    end
  
    def to_html
      links = @options[:page_links] ? windowed_links : []
      # previous/next buttons
      first = page_link_or_span(@collection.previous_page, @prev_class || 'disabled left al-normal', @options[:previous_label])
      last = page_link_or_span(@collection.next_page,     @next_class || 'disabled right ar-normal', @options[:next_label])
      html = first<<"<ul>"<<links.join<<"</ul>"<<last
      @options[:container] ? @template.content_tag(:div, html, html_attributes) : html
    end  

    protected
    
    def page_link( page, text, attributes = {} )
      @template.link_to( text, @url ? @url+"?#{url_for( page ).split('?').last}" : url_for( page ), attributes )
    end
    
    def page_link_or_span(page, span_class, text = nil)
      text ||= page.to_s
      
      if page and page != current_page
        classnames = span_class && span_class.index(' ') && span_class.split(' ', 2).last
        link = page_link page, text, :rel => rel_value(page), :class => classnames
	return "<li>#{link}</li>" if span_class == "current"
	link
      elsif page == current_page
        "<li class='selected'>#{page_span page, text }</li>"
      else
	page_span page, text, :class => span_class
      end
    end
    
    def page_span(page, text, attributes = {})
      @template.link_to text, "javascript:void(0)", attributes
    end
end