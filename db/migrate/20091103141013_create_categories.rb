class CreateCategories < ActiveRecord::Migration
  def self.up
    create_table :categories do |t|
      t.string :display_name
      t.string :permalink
      t.string :description
      t.boolean :is_enabled , :default => true
      t.string :image_file_name
      t.string :image_content_type
      t.integer :image_file_size
      t.integer :created_by
      t.integer :updated_by

      t.timestamps
    end
  end

  def self.down
    drop_table :categories
  end
end
