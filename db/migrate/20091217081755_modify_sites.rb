class ModifySites < ActiveRecord::Migration
  def self.up
    add_column  :sites, :description, :string
  end

  def self.down
  end
end
