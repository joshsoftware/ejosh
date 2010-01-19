class InsertDefaultUsers < ActiveRecord::Migration
  def self.up
    User.create(:login => "admin", :email => "info@joshsoftware.com", :password => "josh123", :password_confirmation => "josh123", :role_id => 1)
  end

  def self.down
  end
end
