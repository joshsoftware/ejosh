# Calendar

require "date"

module ActionView
  module Helpers
    module DepotDateHelper
      def depot_date_select(options = {})
        if(options[:id].blank?)
          options[:id] = options[:name]
        end

        options[:ifFormat] ||= "%m/%d/%Y"

        if value(object) == nil
          date = ""
        else
          date = value(object).strftime(options[:ifFormat])
        end

        error = !object.errors.nil? && !object.errors.on(options[:method]).nil?
        html  = ""
        if error
          html << %(<div class="fieldWithErrors"> \n)
        end

        html << %(<input type="text" name="#{options[:name]}" value="#{date}" class="#{options[:class]} text-input" id="#{options[:id]}" />\n)
        html << %(<img src="/images/calendar.png" id="#{options[:id]}_trigger" style="cursor: pointer;" title="Date selector" />\n)

        calendar_options = Hash.new
        calendar_options.replace(options)
        calendar_options["inputField"] ||= "#{options[:id]}"
        calendar_options["button"] ||= "#{options[:id]}_trigger"
        calendar_options.delete_if { | key, value |
          [ :name, :class, :id, :object_name, :method ].include? key
        }

        html << %(<script type="text/javascript">\n)
        html << %(    Calendar.setup\({\n)
        calendar_options.each { | key, value |
          if(key.to_s.eql?('dateStatusFunc') || !value.instance_of?(String))
            html << %(        #{key} : #{value},\n )
          else
            html << %(        #{key} : "#{value}",\n )
          end
        }
#        html << %(        inputField     :    "#{options[:id]}",     // id of the input field\n)
#        html << %(        ifFormat       :    "%m/%d/%Y",      // format of the input field\n)
#        html << %(        button         :    "#{options[:id]}_trigger",  // trigger for the calendar, button ID\n)
        html << %(        singleClick    :    true\n)
        html << %(    }\);\n)
        html << %(</script>\n)

        if error
          html << %(</div> \n)
        end

        html
      end
      
      def depot_datetime_select(options = {})
        if(options[:id].blank?)
          options[:id] = options[:name]
        end

        options[:ifFormat] ||= "%m/%d/%Y %I:%M %p"

        if value(object) == nil
          datetime = ""
        else
          datetime = value(object).strftime(options[:ifFormat])
        end

        error = !object.errors.nil? && !object.errors.on(options[:method]).nil?
        html  = ""
        if error
          html << %(<div class="fieldWithErrors"> \n)
        end

        html << %(<input type="text" name="#{options[:name]}" value="#{datetime}" class="#{options[:class]} text-input" id="#{options[:id]}" />\n)
        html << %(<img src="/images/calendar.png" id="#{options[:id]}_trigger" style="cursor: pointer;" title="Date & Time selector" />\n)

        calendar_options = Hash.new
        calendar_options.replace(options)
        calendar_options["inputField"] ||= "#{options[:id]}"
        calendar_options["button"] ||= "#{options[:id]}_trigger"
        calendar_options.delete_if { | key, value |
          [ :name, :class, :id, :object_name, :method ].include? key
        }

        html << %(<script type="text/javascript">\n)
        html << %(    Calendar.setup\({\n)
        calendar_options.each { | key, value |
          if(key.to_s.eql?('dateStatusFunc') || !value.instance_of?(String))
            html << %(        #{key} : #{value},\n )
          else
            html << %(        #{key} : "#{value}",\n )
          end
        }
        html << %(        singleClick    :    true, \n)
        html << %(        showsTime      :    true, \n)
        html << %(        time24         :    false \n)
        html << %(    }\);\n)
        html << %(</script>\n)

        if error
          html << %(</div> \n)
        end

        html
      end
    end

    module DateHelper
      def date_select(object_name, method, options = {})
        name = options[:name].nil? ? "#{object_name}[#{method}]" : options[:name]
        id = options[:id].nil? ? "#{object_name}_#{method}" : options[:id]
        options = options.merge( { :name => name, :id => id, :method => method, :object_name => object_name })
        InstanceTag.new(object_name, method, self, options.delete(:object)).to_date_select_tag(options)
      end

      def datetime_select(object_name, method, options = {})
        name = options[:name].nil? ? "#{object_name}[#{method}]" : options[:name]
        id = options[:id].nil? ? "#{object_name}_#{method}" : options[:id]
        options = options.merge( { :name => name, :id => id, :method => method, :object_name => object_name })
        InstanceTag.new(object_name, method, self, options.delete(:object)).to_datetime_select_tag(options)
      end
    end

    class InstanceTag #:nodoc:
      include DepotDateHelper

      def to_date_select_tag(options = {})
        depot_date_select options
      end

      def to_datetime_select_tag(options = {})
        depot_datetime_select options
      end
    end
  end
end


#
# The following code is adapted from Stuart Rackhman's Data Validator available here: http://snippets.dzone.com/posts/show/1548
#
ActiveRecord::Validations::ClassMethods.class_eval do
  # Validates date values, these can be dates or any formats accepted by
  # Date.parse_date.
  #
  # For example:
  #
  #   class Person < ActiveRecord::Base
  #     require_dependency 'date_validator'
  #     validates_dates :birthday,
  #                     :from => '1 Jan 1920',
  #                     :to => Date.today,
  #                     :allow_nil => true
  #   end
  #
  # Options:
  # * from - Minimum allowed date. May be a date or a string recognized
  #   by Date.parse_date.
  # * to - Maxumum allowed date. May be a date or a string recognized
  #   by Date.parse_date.
  # * allow_nil - Attribute may be nil; skip validation.
  #
  def validates_as_date(*attr_names)
    configuration =
      { :message => 'is an invalid date',
        :on => :save,
      }
    configuration.update(attr_names.pop) if attr_names.last.is_a?(Hash)
    # Don't let validates_each handle allow_nils, it checks the cast value.
    allow_nil = configuration.delete(:allow_nil)
    from = Date.parse_date(configuration.delete(:from))
    to = Date.parse_date(configuration.delete(:to))
    validates_each(attr_names, configuration) do |record, attr_name, value|
      before_cast = record.send("#{attr_name}_before_type_cast")
      next if allow_nil and (before_cast.nil? or before_cast == '')
      begin
        date = Date.parse_date(before_cast)
      rescue
        record.errors.add(attr_name, configuration[:message])
      else
        if from and date < from
          record.errors.add(attr_name,
                            "cannot be less than #{from.strftime('%e-%b-%Y')}")
        end
        if to and date > to
          record.errors.add(attr_name,
                            "cannot be greater than #{to.strftime('%e-%b-%Y')}")
        end
      end
    end
  end
end


class Date
  # Parse date string with one of the following formats:
  #
  # * mm/dd/yyyy: example: 11/28/1976
  # * mm/dd/yyyy hh:mm [A|P]M: example: 11/28/1976 3:45 PM
  #
  # The string argument is first converted to a string with #to_s.
  # Returns nil if passed nil or an empty string.
  # Raises ArgumentError if string can't be parsed.
  #
  def self.parse_date(string)
    string = string.to_s.strip.downcase
    return nil if string.empty?

#    date_regex = /^(\d{1,2})\/(\d{1,2})\/(\d{2,4})$/
#    datetime_regex = /^(\d{1,2})\/(\d{1,2})\/(\d{2,4})\s+(\d{1,2}):(\d{1,2})\s+([a|p]m)$/i
#
#    if string.match(date_regex)
#      # mm/dd/yyyy
#      (( m, d, y )) = string.scan(date_regex)
#      begin
#        result = Date.new(y.to_i, m.to_i, d.to_i)
#      rescue
#        raise ArgumentError
#      end
#    elsif string.match(datetime_regex)
#      # mm/dd/yyyy hh:mm am
#      (( m, d, y, h, min, a )) = string.scan(datetime_regex)
#      begin
#        if a == "pm"
#          h = h.to_i
#          h += 12
#        end
#        result = DateTime.new(y.to_i, m.to_i, d.to_i, h.to_i, min.to_i)
#      rescue
#        raise ArgumentError
#      end
#    else
#      raise ArgumentError
#    end
#    result

    # 
    # [davidonlaptop at gmail dot com], Commented line 182 to 207.
    # These were causing a problem when attempting to save a record with a date column
    # when in console mode. The output format of the date was not matching this code above:
    #
    result = nil
    begin
      d = Date.parse(string)
      dt = DateTime.parse(string)
      result = (d == dt) ? d : dt
    rescue
      raise ArgumentError
    end
    result
  end
end

# Override default date type cast class method to handle Date.parse_date
# formats(the default implementation returns nil if passed an unrecognized date
# format).
#
#class ActiveRecord::ConnectionAdapters::Column
#  def self.string_to_date(string)
#    return string unless string.is_a?(String)
#    Date.parse_date(string) rescue nil
#  end
#end
