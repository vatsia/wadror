class Brewery < ActiveRecord::Base
  include AverageRating

  validates :name, presence: true
  validates :year, numericality: {greater_than_or_equal_to: 1042}
  validate :year_cannot_be_in_future

  scope :active, -> { where active:true }
  scope :retired, -> { where active:[nil,false] }

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

  def year_cannot_be_in_future
    if year > Time.now.year
      errors.add(:year, "can't be in the future :(")
    end
  end

  def self.top(n)
    sorted_by_rating_in_desc_order = Brewery.all.sort_by{|b| - (b.average_rating || 0)}
    sorted_by_rating_in_desc_order.take(n)
  end
end
