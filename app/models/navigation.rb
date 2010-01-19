class Navigation < ActiveRecord::Base
   named_scope :headers, :conditions => {:navigation_type => 0}
   named_scope :footers, :conditions => {:navigation_type => 1}
   named_scope :quick_links, :conditions => {:navigation_type => 2}
  
   named_scope :active, :conditions => {:is_enabled => true}
   named_scope :order_by_sequence, :order => "sequence"

   belongs_to :page
  
   validates_presence_of   :display_name, :page_id
end
