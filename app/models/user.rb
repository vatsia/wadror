class User < ActiveRecord::Base
  include AverageRating

  validates :username, uniqueness: true
  validates :username, length: {minimum: 3}

  has_many :ratings
end
