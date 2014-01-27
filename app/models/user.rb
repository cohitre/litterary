class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :trackable, authentication_keys: [:login]

  attr_accessible :password, :password_confirmation, :login, :full_name

  has_many :notes
  has_many :citations
  has_many :weeks, through: :notes, uniq: true

  validate :login,
    format: /\A[A-Za-z0-9_]*\Z/,
    presence: true,
    uniqueness: {
      case_sensitive: false
    },
    length: {
      within: 3..40
    }

  validates_presence_of :password, :if => :password_required?
  validates_confirmation_of :password, :if => :password_required?
  validates_length_of       :password, :minimum => 3, :allow_blank => true

  def draft?
    self.notes.drafts.any?
  end

  def draft
    self.notes.draft.first || self.notes.build
  end

  protected

  def password_required?
    !persisted? || !password.nil? || !password_confirmation.nil?
  end
end
