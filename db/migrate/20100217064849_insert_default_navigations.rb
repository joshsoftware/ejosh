class InsertDefaultNavigations < ActiveRecord::Migration
  def self.up
    Navigation.create(:display_name => "Home", :page_id => 1, :is_enabled => true , :sequence => 1, :navigation_type => 0)
    Navigation.create(:display_name => "Services", :page_id => 2, :is_enabled => true , :sequence => 2, :navigation_type => 0)
    Navigation.create(:display_name => "About Us", :page_id => 3, :is_enabled => true , :sequence => 3, :navigation_type => 0)
  end

  def self.down
  end
end
