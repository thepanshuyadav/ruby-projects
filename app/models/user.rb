# User Model
class User < ApplicationRecord
  validates :name, presence: true, length: { minimum: 4 }

  has_many :articles
  has_many :comments
  has_many :likes
end
