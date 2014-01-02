class Note < ActiveRecord::Base
  belongs_to :user
  belongs_to :week

  has_many :citations, :through => :versions
  has_many :note_comments
  has_many :comments, :through => :note_comments
  has_one :version

  attr_accessible :name, :version_attributes

  accepts_nested_attributes_for :version

  def body
    version.body
  end
end
