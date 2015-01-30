class BeerClub < ActiveRecord::Base
  has_many :memberships, :foreign_key => 'beer_club_id'
  has_many :users, through: :memberships

  def to_s
    self.name
  end
end
