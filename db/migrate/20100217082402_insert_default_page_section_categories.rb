class InsertDefaultPageSectionCategories < ActiveRecord::Migration
  def self.up
    PageSectionCategory.create(:page_id => 1,:page_section_id => 3, :category_id => nil, :sequence => 3)
    PageSectionCategory.create(:page_id => 1,:page_section_id => 2, :category_id => nil, :sequence => 1)
    PageSectionCategory.create(:page_id => 1,:page_section_id => 4, :category_id => nil, :sequence => 2)
    PageSectionCategory.create(:page_id => 1,:page_section_id => 5, :category_id => nil, :sequence => 4)
    
    PageSectionCategory.create(:page_id => 2,:page_section_id => 6, :category_id => nil, :sequence => 1)
    PageSectionCategory.create(:page_id => 2,:page_section_id => 7, :category_id => 1, :sequence => 2)
    PageSectionCategory.create(:page_id => 2,:page_section_id => 8, :category_id => 2, :sequence => 3)

    PageSectionCategory.create(:page_id => 3,:page_section_id => 9, :category_id => nil, :sequence => 1)
    PageSectionCategory.create(:page_id => 3,:page_section_id => 9, :category_id => 1, :sequence => 2)
    PageSectionCategory.create(:page_id => 3,:page_section_id => 9, :category_id => 2, :sequence => 3)
  end

  def self.down
  end
end
