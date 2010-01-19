class InsertDefaultRoles < ActiveRecord::Migration
  def self.up
    Role.create(:title => "Admin", :description => "All", :auth_level => 20)
    Role.create(:title => "Employee", :description => "Limited", :auth_level => 10)
    Role.create(:title => "Guest", :description => "No Access", :auth_level => 0)
  end

  def self.down
  end
end
