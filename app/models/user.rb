require 'digest/sha1'

class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :trackable, :authentication_keys => [:login]

  # Setup accessible (or protected) attributes for your model
  attr_accessible :password, :password_confirmation, :remember_me, :login
  has_many :notes
  has_many :citations

  has_many :version

  has_many :note_comments

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
