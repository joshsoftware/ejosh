class BbFormBuilder < ActionView::Helpers::FormBuilder  
  
  def self.create_tagged_field(method_name)

    define_method(method_name) do |name, *args|      
      errors = object.errors.on(name.to_sym)
      
      # initialize some local variables
      klass = []
      label = ''      
      
      if args.last.is_a?(Hash)
        arg_label = args.last[:label].to_s
        arg_klass = args.last[:class].to_s
        arg_required = args.last[:required].to_s
      end

      label = arg_label unless arg_label.blank?#Label text, titlize field name if a custom label isn't passed
      
      klass << arg_klass unless arg_klass.nil? #store custom class if it exists
      klass << 'check_box' if method_name == 'check_box'
      klass << 'text_field' if method_name == 'text_field'
      klass << 'text_area' if method_name == 'text_area'
      klass << 'select' if method_name == 'select'
      klass << 'f' #A default selector to indicate the contents are a form field
      klass << 'error' unless errors.blank?
      klass = klass.join(' ') #turn all the class selectors into a string
      
      # Required Field Notations
      # all: add required notation for all form methods
      # new: only for 'create new' forms, using the form in 'edit' mode should disregard
      if arg_required == true || (arg_required == 'new' && object.new_record?)
        label << @template.content_tag("span", "*", :class => 'required')
      end
      
      reverse = true if method_name == 'check_box'

      # CLEAN UP
      # cleanup arbitrary html_options used to pass information to this form builder
      if args.last.is_a?(Hash)
        args.last[:label] = nil
        args.last[:required] = nil
      end      
      if errors
        error_message = "Error: #{errors.to_s}"
      end
      
      if reverse
          @template.content_tag("div", super + " " + @template.content_tag("label", "#{label.to_s} ", :for => "#{@object_name}_#{name}") + " " + @template.content_tag("strong", error_message, :class => 'alert'), :class => klass)
      else        
          @template.content_tag("div",  super + " " + @template.content_tag("strong", error_message, :class => 'alert'), :class => klass)
      end
    end
  end

  field_helpers.push('select').each do |name|
    create_tagged_field(name)
  end
  
  

end
