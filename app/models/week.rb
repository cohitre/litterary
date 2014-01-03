class Week < ActiveRecord::Base
  has_many :notes

  def published?
    published_at.past?
  end
end
