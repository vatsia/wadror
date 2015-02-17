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

  def to_s
    username
  end

  def favorite_beer
    return nil if ratings.empty?
    ratings.sort_by { |r| r.score}.last.beer
  end

  def favorite_style
    return nil if ratings.empty?
    Style.find(ratings.joins(:beer).group(:style_id).order(score: :desc).limit(1).first.beer.style_id)
  end

  def favorite_brewery
    return nil if ratings.empty?
    ratings.joins(:beer).group(:brewery_id).order(score: :desc).limit(1).first.beer.brewery
  end

  def self.top(n)
    sorted_by_rating_in_desc_order = User.all.sort_by{|b| - (b.average_rating || 0)}
    sorted_by_rating_in_desc_order.take(n)
  end
end
