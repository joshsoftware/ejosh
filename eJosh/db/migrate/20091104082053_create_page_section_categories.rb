class CreatePageSectionCategories < ActiveRecord::Migration
  def self.up
    create_table :page_section_categories do |t|
      t.references :page
      t.references :page_section
      t.references :category
      t.integer :sequence
      t.integer :created_by
      t.integer :updated_by
      t.timestamps
    end
  end

  def self.down
    drop_table :page_section_categories
  end
end
