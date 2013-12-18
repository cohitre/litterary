require 'digest/sha1'

class User < ActiveRecord::Base
  has_many :notes
  has_many :citations

  has_many :version

  has_many :note_comments

  validates_length_of :login, :within => 3..40
  validates_length_of :password, :within => 5..40

  validates_presence_of :login, :password
  validates_uniqueness_of :login, :on => :create
  validates_confirmation_of :password

  validates_format_of :login, :with => /\A[A-Za-z0-9_]*\Z/ , :on => :create , :message => 'The login name must be compossed of letters, numbers or underscore characters.'

  attr_protected :password, :login, :created_at

  def self.authenticate(login, pass)
    self.where(
      login: login,
      password: sha1(pass)
    ).first
  end

  def change_password(pass)
    update_attribute "password", self.class.sha1(pass)
  end

  def password=(pass)
    @password = self.class.sha1(pass)
  end

  def password_confirmation=(pass)
    @password_confirmation = self.class.sha1(pass)
  end

  def password?( pass )
    return self.password == self.class.sha1(pass)
  end

  protected

  def self.sha1(pass)
    if Settings[:authentication] && Settings[:authentication][:salt]
      salt = Settings[:authentication][:salt]
    else
      salt = ENV['PASSWORD_SALT']
    end
    Digest::SHA1.hexdigest("#{salt}--#{pass}")
  end
end
