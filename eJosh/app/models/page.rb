class Page < ActiveRecord::Base
  has_many :navigations, :dependent => :destroy
  has_many :page_section_categories, :dependent => :destroy 
  has_many :categories, :through => :page_section_categories
  has_many :page_sections, :through => :page_section_categories
  named_scope :default_pages, :conditions=> ["is_default= ?", true]
  named_scope :with_tag_cloud, :conditions=> ["tag_cloud= ?", true]

  validates_presence_of :name, :title
  validates_uniqueness_of :name, :title

  # Add pages to sitemap
  sitemap do |xml|
    Navigation.active.each do |c|
      xml.url do
        xml.loc "http://#{SitemapGenerator::Options.domain}/#{c.page.name}"
        xml.lastmod SitemapGenerator::Helpers.instance.w3c_date(c.page.updated_at)
        xml.changefreq 'weekly'
        xml.priority '0.7'
      end  
    end  
  end
end
