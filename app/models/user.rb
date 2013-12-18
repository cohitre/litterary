require 'digest/sha1'

class User < ActiveRecord::Base
  has_many :notes
  has_many :citations

  has_many :version

  has_many :note_comments

  before_create :crypt_password

  validates_length_of :login, :within => 3..40
  validates_length_of :password, :within => 5..40

  validates_presence_of :login, :password
  validates_uniqueness_of :login, :on => :create
  validates_confirmation_of :password, :on => :create

  validates_format_of :login, :with => /\A[A-Za-z0-9_]*\Z/ , :on => :create , :message => 'The login name must be compossed of letters, numbers or underscore characters.'

  attr_protected :password, :login, :created_at

  def self.authenticate(login, pass)
    self.find(:first , :conditions => ["login = ? AND password = ?", login, sha1(pass)])
  end

  def change_password(pass)
    update_attribute "password", self.class.sha1(pass)
  end

  def password?( pass )
    return self.password == self.class.sha1(pass)
  end

  protected

  def self.sha1(pass)
    Digest::SHA1.hexdigest("#{Settings[:authentication][:salt]}--#{pass}--")
  end

  def crypt_password
    write_attribute("password", self.class.sha1(password))
  end
end
