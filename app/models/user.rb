class User < ActiveRecord::Base
  validates :password, presence: true
  validates :email, presence: true, uniqueness: true, 
              format: { with: /\A.+@.+\..+\z/
                        message: "must be a valid email"}
end
