class Version < ActiveRecord::Base
  belongs_to :note
  belongs_to :user
  has_many :notes

end
