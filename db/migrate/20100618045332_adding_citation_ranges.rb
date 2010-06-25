class AddingCitationRanges < ActiveRecord::Migration
  def self.up
    add_column :citations, :range_end, :integer
    add_column :citations, :range_begin, :integer
  end

  def self.down
    drop_column :citations, :range_begin
    drop_column :citations, :range_end
  end
end
