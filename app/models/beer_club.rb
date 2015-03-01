class BeerClub < ActiveRecord::Base
  has_many :memberships, :foreign_key => 'beer_club_id'
  has_many :users, through: :memberships

  def confirmed_memberships
    memberships.where :confirmed => true
  end

  def unconfirmed_memberships
    memberships.where :confirmed => [false, nil]
  end

  def to_s
    self.name
  end
end
