class CreateNavigations < ActiveRecord::Migration
  def self.up
    create_table :navigations do |t|
      t.string :display_name
      t.references :page
      t.boolean :is_enabled , :default => true
      t.string :link
      t.integer :sequence
      t.integer :navigation_type, :default=> 0
      t.integer :created_by
      t.integer :updated_by
      t.timestamps
    end
  end

  def self.down
    drop_table :navigations
  end
end
