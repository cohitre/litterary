class Note < ActiveRecord::Base
  belongs_to :user
  belongs_to :week

  attr_accessible :name, :body
end
