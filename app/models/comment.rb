class Comment < ActiveRecord::Base
  belongs_to :user
  has_one :note_comment
  has_one :note, :through => :note_comment
  
end