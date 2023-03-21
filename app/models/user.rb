# User Model
class User < ApplicationRecord
  has_secure_password
  validates :name, presence: true, length: { minimum: 4 }

  has_many :articles
  has_many :comments
  has_many :likes
end
