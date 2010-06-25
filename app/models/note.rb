class Note < ActiveRecord::Base
  belongs_to :user

  has_many :citations, :through => :versions
  has_many :note_comments
  has_many :comments, :through => :note_comments  
  has_many :versions , :order => 'created_at DESC'

  def current
    versions.first
  end
  
  def current_attributes= attributes
    self.versions.build(attributes)
  end
  
end
