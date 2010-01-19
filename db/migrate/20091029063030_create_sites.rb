class CreateSites < ActiveRecord::Migration
  def self.up
    create_table :sites do |t|
      t.string :company_name
      t.text :tagline
      t.string :copyright_info
      t.string :logo_file_name
      t.string :logo_content_type
      t.integer :logo_file_size
      t.boolean :go_live, :default => false
      t.integer :created_by
      t.integer :updated_by
      t.timestamps
    end
  end

  def self.down
    drop_table :sites
  end
end
