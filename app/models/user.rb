require 'digest/sha1'

class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :trackable, :authentication_keys => [:login]

  # Setup accessible (or protected) attributes for your model
  attr_accessible :password, :password_confirmation, :remember_me, :login

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

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(login) = :value", {
        :value => login.downcase
      }]).first
    else
      where(conditions).first
    end
  end

  def self.authenticate(login, pass)
    self.where(
      login: login,
      password: sha1(pass)
    ).first
  end

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
    !self.draft.nil?
  end

  protected

  def password_required?
    !persisted? || !password.nil? || !password_confirmation.nil?
  end

  def self.sha1(pass)
    if Settings[:authentication] && Settings[:authentication][:salt]
      salt = Settings[:authentication][:salt]
    else
      salt = ENV['PASSWORD_SALT']
    end
    Digest::SHA1.hexdigest("#{salt}--#{pass}")
  end
end
