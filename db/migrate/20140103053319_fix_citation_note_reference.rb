class FixCitationNoteReference < ActiveRecord::Migration
  def up
    add_column :citations, :note_id, :integer, null: false, default: 1
    remove_column :citations, :version_id
  end

  def down
  end
end
