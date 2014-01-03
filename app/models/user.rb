class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :trackable, :authentication_keys => [:login]

  attr_accessible :password, :password_confirmation, :login

  has_one :draft, conditions: { week_id: nil }, class_name: "Note"
  has_many :notes, conditions: ["week_id IS NOT NULL"]
  has_many :citations

  validate :login,
    format: /\A[A-Za-z0-9_]*\Z/,
    uniqueness: {
      case_sensitive: false
    },
    length: {
      within: 3..40
    }

  validates_presence_of     :password, :if => :password_required?
  validates_confirmation_of :password, :if => :password_required?
  validates_length_of       :password, :minimum => 3, :allow_blank => true

  def full_name?
    !full_name.blank?
  end

  def full_name
    fields = []
    fields.push(name) if name?
    fields.push(lastname) if lastname?
    fields.join(" ")
  end

  def draft?
    self.notes.where(week_id: nil).any?
  end

  def draft
    if self.draft?
      super
    else
      self.build_draft
    end
  end

  protected

  def password_required?
    !persisted? || !password.nil? || !password_confirmation.nil?
  end
end
