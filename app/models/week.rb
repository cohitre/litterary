class Week < ActiveRecord::Base
  has_many :notes

  def published?
    publishing_date.past?
  end

  def claim_posts!
    self.notes = Note.where(week_id: nil, deadline: true)
  end
end
