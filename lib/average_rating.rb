module AverageRating
  def average_rating
    ratings.average(:score)
  end
end