class NoteComment < ActiveRecord::Base
  belongs_to :comment
  belongs_to :note

end
