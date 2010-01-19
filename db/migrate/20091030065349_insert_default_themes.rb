class InsertDefaultThemes < ActiveRecord::Migration
  def self.up
    Theme.create(:color_id => 1, :layout_id => 1, :is_default => true, :is_selected => true)
    Theme.create(:color_id => 2, :layout_id => 2, :is_default => true, :is_selected => false)
    Theme.create(:color_id => 3, :layout_id => 3, :is_default => true, :is_selected => false)
    Theme.create(:color_id => 2, :layout_id => 1)
    Theme.create(:color_id => 3, :layout_id => 1)
    Theme.create(:color_id => 4, :layout_id => 1)
    Theme.create(:color_id => 5, :layout_id => 1)
    Theme.create(:color_id => 1, :layout_id => 2)
    Theme.create(:color_id => 3, :layout_id => 2)
    Theme.create(:color_id => 4, :layout_id => 2)
    Theme.create(:color_id => 5, :layout_id => 2)
    Theme.create(:color_id => 1, :layout_id => 3)
    Theme.create(:color_id => 2, :layout_id => 3)
    Theme.create(:color_id => 4, :layout_id => 3)
    Theme.create(:color_id => 5, :layout_id => 3)
  end

  def self.down
  end
end
