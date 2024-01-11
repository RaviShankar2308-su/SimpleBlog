class User < ApplicationRecord
  has_secure_password
  has_many :posts

  validates :password_digest, :email, :username, presence: true
end
