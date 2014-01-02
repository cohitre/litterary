class DroppingComments < ActiveRecord::Migration
  def up
    drop_table :comments
    drop_table :note_comments
  end

  def down
  end
end
