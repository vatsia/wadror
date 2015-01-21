class Brewery < ActiveRecord::Base
  include AverageRating

  has_many :beers, dependent: :destroy
  has_many :ratings, through: :beers

  def print_report
    puts name
    puts "established at year #{year}"
    puts "number of beer #{beers.count}"
  end

  def restart
    self.year = 2015
    puts "changed to year #{year}"
  end

  def to_s
    name
  end

  #def average_rating
  #  ratings.average(:score)
  #end
end
