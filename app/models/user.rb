class User < ActiveRecord::Base
  has_many :attended_events
  has_many :created_events

  validates :password, presence: true
  validates :email, presence: true, uniqueness: true, 
              format: { with: /\A.+@.+\..+\z/,
                        message: "must be a valid email"}

  include BCrypt

  def password=(new_password)
    return nil if new_password == ""
    @password = Password.create(new_password)
    self.password_digest = @password
  end

  def password
    return nil unless password_digest
    @password ||= Password.new(password_digest)
  end

  def self.authenticate(args)
    user = User.find_by_email(args[:email])
    return user if user && (user.password == args[:password])
    nil
  end


end
