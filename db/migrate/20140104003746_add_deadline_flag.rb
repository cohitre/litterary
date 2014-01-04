class AddDeadlineFlag < ActiveRecord::Migration
  def up
    add_column :notes, :deadline, :boolean, default: false, null: false
  end

  def down
  end
end
