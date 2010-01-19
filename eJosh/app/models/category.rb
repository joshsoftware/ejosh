class Category < ActiveRecord::Base
  acts_as_tagger
  has_many :page_section_categories, :dependent => :destroy
  has_many :pages, :through => :page_section_categories
  has_many :page_sections, :through => :page_section_categories
  validates_presence_of :display_name

  has_attached_file :image,
    :styles => { :small_thumb => [ "37x37", :jpg ],  
                  :thumb => [ "50x50", :jpg ] } 
  validates_attachment_content_type :image, :content_type => ['image/pjpeg','image/jpeg', 'image/png','image/x-png','image/gif'], :message=>"Invalid file format "  

  named_scope :active, :conditions => {:is_enabled => true}
  named_scope :order_by_sequence, :order => 'sequence'
  # Add pages to sitemap
  sitemap do |xml|
    Navigation.active.each do |nav|
      nav.page.categories.active.order_by_sequence.uniq.each do |c|
        xml.url do
          xml.loc "http://#{SitemapGenerator::Options.domain}/#{nav.page.name}/#{c.permalink}"
          xml.lastmod SitemapGenerator::Helpers.instance.w3c_date(c.updated_at)
          xml.changefreq 'weekly'
          xml.priority '0.7'
        end  
      end  
    end  
  end  
end
