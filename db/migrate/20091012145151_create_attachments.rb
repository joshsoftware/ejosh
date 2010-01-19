class CreateAttachments < ActiveRecord::Migration
  def self.up
    create_table :attachments do |t|
      t.string :title
      t.string :description
      t.string :embed
      t.string :context # For future use
      t.integer :view_count, :default => 0
      t.references :user
      t.references :entity, :polymorphic => true
      t.references :resource, :polymorphic => true

      t.timestamps
    end
  end

  def self.down
    drop_table :attachments
  end
end
