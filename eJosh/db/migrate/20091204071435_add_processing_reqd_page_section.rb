class AddProcessingReqdPageSection < ActiveRecord::Migration
  def self.up
    add_column :page_sections, :is_processing_reqd, :boolean, :default => false
  end

  def self.down
    remove_column :page_sections, :is_processing_reqd
  end
end
