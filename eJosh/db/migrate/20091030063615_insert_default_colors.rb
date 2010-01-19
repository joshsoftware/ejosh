class InsertDefaultColors < ActiveRecord::Migration
  def self.up
    Color.create(:name => 'green', :code => '#B3DC26')
    Color.create(:name => 'orange', :code => '#F8C301')
    Color.create(:name => 'seablue', :code => '#445C76')
    Color.create(:name => 'violet', :code => '#AB6AC8')
    Color.create(:name => 'skyblue', :code => '#57C6E1')
  end

  def self.down
  end
end
