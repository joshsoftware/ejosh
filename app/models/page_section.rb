class PageSection < ActiveRecord::Base
  acts_as_taggable_on :tags
  has_many :attachments
  has_many :page_section_categories, :dependent => :destroy
  has_many :categories, :through => :page_section_categories
  has_many :pages, :through => :page_section_categories

  named_scope :for_page, lambda { |page| { :conditions => ["page_id = ?",page] } }
  validates_presence_of :display_name

  #define_index do
  #  indexes title, :sortable => true
  #  indexes content, :sortable => true
  #  indexes display_name, :sortable => true
  #end
end
