class Crawler < ActiveRecord::Base
   validates_presence_of   :name, :script
   named_scope :active, :conditions => {:is_enabled => true}
end
