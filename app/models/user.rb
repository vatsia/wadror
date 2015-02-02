class User < ActiveRecord::Base
  include AverageRating

  validates :username, uniqueness: true
  validates :username, length: {minimum: 3, maximum: 15}
  validates :password, length: {minimum: 4}
  validates :password, format: { with: /(?=.*[A-Z])(?=.*[0-9])/, message: "should contain atleast one capital letter and one number!"}

  has_many :ratings, dependent: :destroy
  has_many :beers, through: :ratings
  has_many :beer_clubs, through: :memberships
  has_many :memberships, dependent: :destroy

  has_secure_password

  def favorite_beer
  end
end
