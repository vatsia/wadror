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
    return nil if ratings.empty?
    ratings.sort_by { |r| r.score}.last.beer
  end

  def favorite_style
    return nil if ratings.empty?
    ratings.joins(:beer).group(:style).order(score: :desc).limit(1).first.beer.style
  end

  def favorite_brewery
    return nil if ratings.empty?
    ratings.joins(:beer).group(:brewery_id).order(score: :desc).limit(1).first.beer.brewery
  end
end
