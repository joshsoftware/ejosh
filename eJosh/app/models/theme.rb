class Theme < ActiveRecord::Base
  belongs_to :layout
  belongs_to :color
  named_scope :selected, { :conditions=> ["is_selected = ?", true ] }
  named_scope :select_theme, lambda {|color, layout|{:conditions => ["color_id = ? and layout_id = ?",color, layout]}}
end
