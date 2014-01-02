class Note < ActiveRecord::Base
  belongs_to :user
  belongs_to :week

  has_many :citations, :through => :versions

  attr_accessible :name, :body
end
