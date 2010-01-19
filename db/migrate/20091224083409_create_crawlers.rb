class CreateCrawlers < ActiveRecord::Migration
  def self.up
    create_table :crawlers do |t|
      t.string :name
      t.text :script
      t.boolean :is_enabled , :default => true
      t.integer :created_by
      t.integer :updated_by
      t.timestamps
    end
  end

  def self.down
    drop_table :crawlers
  end
end
