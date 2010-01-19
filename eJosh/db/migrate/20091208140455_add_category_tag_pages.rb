class AddCategoryTagPages < ActiveRecord::Migration
  def self.up
     add_column :pages, :category_tag_cloud, :boolean, :default => false
  end

  def self.down
     remove_column :pages, :category_tag_cloud
  end
end
