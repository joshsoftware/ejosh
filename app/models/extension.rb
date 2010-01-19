class Extension < ActiveRecord::Base
  named_scope :find_extension, lambda { |extension| { :conditions => "entry_point = '#{extension}'" } }
end
