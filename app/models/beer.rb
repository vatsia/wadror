class Beer < ActiveRecord::Base
  include AverageRating

  belongs_to :brewery
  has_many :ratings, dependent: :destroy

  #def average_rating
    #amount = 0
    #ratings.each do |rate|
    #  amount += rate.score
    #end
    #amount / ratings.count
    #ratings.average(:score)
  #end

  def to_s
    "#{name}, panimo: #{brewery.name}"
  end
end
