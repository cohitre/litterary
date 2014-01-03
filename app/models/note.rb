class Note < ActiveRecord::Base
  belongs_to :user
  belongs_to :week

  has_many :citations

  attr_accessible :name, :body

  def body
    t = super || ""
    t.gsub /\r/, " "
  end
end
