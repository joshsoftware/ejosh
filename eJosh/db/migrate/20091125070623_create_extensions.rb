class CreateExtensions < ActiveRecord::Migration
  def self.up
    create_table :extensions do |t|
      t.string :display_name
      t.string :title
      t.string :entry_point
      t.string :repository_path
      t.boolean :visible_only_on_login, :default => true
      t.integer :installed_by

      t.timestamps
    end
  end

  def self.down
    drop_table :extensions
  end
end
