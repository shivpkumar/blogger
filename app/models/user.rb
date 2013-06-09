require 'bcrypt'

class User < ActiveRecord::Base
  validates :email, :password_hash, presence: true
  validates :email, uniqueness: true
  validate :email_is_valid_format
  has_many :posts
  include BCrypt

  def self.authenticate(params)
    @user = self.find_by_email(params[:email])
    @user && (@user.password == params[:password]) ? @user : false
  end

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end

  protected

  def email_is_valid_format
    unless self.email =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
      errors.add(:email, "is not in a valid email format (e.g. name@example.com)")
    end
  end

end
