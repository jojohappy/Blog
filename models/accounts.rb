class Accounts < ActiveRecord::Base

  before_save :encrypt_password

  def self.authenticate(name, password_in)
    account = where(:name => name).first if name.present?
    account && account.has_password?(password_in) ? account : nil
  end

  def has_password?(password_in)
    ::BCrypt::Password.new(password) == password_in
  end

  def encrypt_password
    self.password = ::BCrypt::Password.create(password) unless password.blank?
  end
end