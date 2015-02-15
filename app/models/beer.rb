class Beer < ActiveRecord::Base
  include AverageRating

  validates :name, presence: true
  validates :style_id, presence: true

  belongs_to :brewery
  belongs_to :style

  has_many :ratings, dependent: :destroy
  has_many :raters, -> {uniq}, through: :ratings, source: :user

  def to_s
    "#{name}, panimo: #{brewery.name}"
  end
end
