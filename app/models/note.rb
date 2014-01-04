class Note < ActiveRecord::Base
  belongs_to :user
  belongs_to :week

  has_many :citations

  attr_accessible :name, :body, :deadline

  scope :published, where("week_id IS NOT NULL")
  scope :draft, where(week_id: nil)

  def body
    t = super || ""
    t.gsub "\r", " "
  end

  def published?
    week? && week.published?
  end

  def to_json(options={})
    {
      deadline: self.deadline?,
      name: self.name,
      body: self.body,
      citations: self.citations.map(&:to_json)
    }
  end
end
