class Citation < ActiveRecord::Base
  belongs_to :version
  belongs_to :user

  attr_accessible :message, :range_begin, :range_end, :user

  def to_json
    {
      comment: message,
      range: {
        start: range_begin,
        end: range_end
      }
    }
  end
end
