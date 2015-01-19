class Beer < ActiveRecord::Base
  belongs_to :brewery
  has_many :ratings

  def average_rating
    amount = 0

    ratings.each do |rate|
      amount += rate.score
    end

    amount / ratings.count
  end
end
