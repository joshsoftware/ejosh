class InsertDefaultUsers < ActiveRecord::Migration
  def self.up
    User.create(:login => "admin", :email => "info@joshsoftware.com", :password => "joshsoftware", :password_confirmation => "joshsoftware", :role_id => 1)
  end

  def self.down
  end
end
