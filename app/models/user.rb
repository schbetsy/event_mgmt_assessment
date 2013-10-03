class User < ActiveRecord::Base
  has_many :event_attendances
  has_many :attended_events, through: :event_attendances, source: :event
  has_many :created_events, class_name: "Event", foreign_key: "user_id"

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

  def name
    "#{self.first_name} #{self.last_name}"
  end

end
