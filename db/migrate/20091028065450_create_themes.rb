class CreateThemes < ActiveRecord::Migration
  def self.up
    create_table :themes do |t|
      t.references :color
      t.references :layout
      t.boolean :is_default , :default => false
      t.boolean :is_selected, :default => false
      t.integer :created_by
      t.integer :updated_by
      t.timestamps
    end
  end

  def self.down
    drop_table :themes
  end
end
