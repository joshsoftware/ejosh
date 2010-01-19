class PageSectionCategory < ActiveRecord::Base
  belongs_to :page
  belongs_to :category
  belongs_to :page_section
  named_scope :order_by_sequence, :order => 'sequence'
  named_scope :for_page, lambda { |page| { :conditions => ["page_id = ?",page] } }
  named_scope :no_category,  { :conditions => ["category_id is null" ] }
end
