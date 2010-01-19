class CreatePages < ActiveRecord::Migration
  def self.up
    create_table :pages do |t|
      t.string :name
      t.string :title
      t.string :path
      t.text :description
      t.text :keywords
      t.string :language, :default => 'English'
      t.boolean :is_default, :default => false
      t.integer :created_by
      t.integer :updated_by
      t.timestamps
    end
  end

  def self.down
    drop_table :pages
  end
end
