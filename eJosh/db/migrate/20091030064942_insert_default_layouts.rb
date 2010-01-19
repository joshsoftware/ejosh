class InsertDefaultLayouts < ActiveRecord::Migration
  def self.up
    Layout.create(:name => 'ejoshweb1', :image_file_name => "ejoshweb1.jpg", :image_content_type => "image/jpeg", :image_file_size => 6088)
    Layout.create(:name => 'ejoshweb2', :image_file_name => "ejoshweb2.jpg", :image_content_type => "image/jpeg", :image_file_size => 4973)
    Layout.create(:name => 'ejoshweb3', :image_file_name => "ejoshweb3.jpg", :image_content_type => "image/jpeg", :image_file_size => 4843)
  end

  def self.down
  end
end
