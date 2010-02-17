class InsertDefaultCategories < ActiveRecord::Migration
  def self.up
    Category.create(:display_name => "Submenu1", :permalink => "Submenu1", :description => "Lorem ipsum dolor sit amet con Lore", :is_enabled => true, :image_file_name => "submenu1.png", :image_content_type => "image/png", :image_file_size => 2057)
    
    Category.create(:display_name => "Submenu2", :permalink => "Submenu2", :description => "Lorem ipsum dolor sit amet con Lore", :is_enabled => true, :image_file_name => "submenu2.png", :image_content_type => "image/png", :image_file_size => 3705)

  end

  def self.down
  end
end
