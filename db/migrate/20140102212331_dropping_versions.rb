class DroppingVersions < ActiveRecord::Migration
  class Version < ActiveRecord::Base
  end

  class Note < ActiveRecord::Base
    has_many :versions
  end

  def up
    add_column :notes, :body, :text
    Note.find_each do |note|
      note.update_attributes!(body: note.versions.last.body)
    end
    drop_table :versions
  end

  def down
  end
end
