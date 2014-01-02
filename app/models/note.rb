class Note < ActiveRecord::Base
  belongs_to :user
  belongs_to :week

  has_many :citations, :through => :versions
  has_many :note_comments
  has_many :comments, :through => :note_comments

  attr_accessible :name, :body
end
