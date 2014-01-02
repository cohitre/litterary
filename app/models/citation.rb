class Citation < ActiveRecord::Base
  belongs_to :user

  attr_accessible :message, :range_begin, :range_end, :user

  def to_json
    {
      id: self.id,
      comment: message,
      range: {
        start: range_begin,
        end: range_end
      }
    }
  end
end
