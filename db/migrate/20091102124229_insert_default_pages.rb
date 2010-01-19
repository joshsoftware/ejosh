class InsertDefaultPages < ActiveRecord::Migration
  def self.up
    Page.create(:name => "Home",:title => "Home", :description => "<p><%= render :partial => 'home_theme' + \"\#{$THEME}\"%></p>", :is_default => true)
    Page.create(:name => "Features", :title => "Features", :description => "<p><%= render :partial => 'features_theme' + \"\#{$THEME}\"%></p>", :is_default => true)
    Page.create(:name => "AboutUs", :title => "About Us", :description => "<p><%= render :partial => 'aboutus_theme' + \"\#{$THEME}\"%></p>", :is_default => true)
    Page.create(:name => "Blank", :title => "Blank", :description => "<p><%= render :partial => 'blank_theme' + \"\#{$THEME}\"%></p>", :is_default => true)
  end

  def self.down
  end
end
