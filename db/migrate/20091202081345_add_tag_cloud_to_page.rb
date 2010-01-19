class AddTagCloudToPage < ActiveRecord::Migration
  def self.up
     add_column :pages, :tag_cloud, :boolean, :default => false
  end

  def self.down
     remove_column :pages, :tag_cloud
  end
end
