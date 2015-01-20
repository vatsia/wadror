class Beer < ActiveRecord::Base
  belongs_to :brewery
  has_many :ratings

  def average_rating
    #amount = 0
    #ratings.each do |rate|
    #  amount += rate.score
    #end
    #amount / ratings.count
    ratings.average(:score)
  end

  def to_s
    "#{name}, panimo: #{brewery.name}"
  end
end
