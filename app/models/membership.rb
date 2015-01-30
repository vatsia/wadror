class Membership < ActiveRecord::Base
  belongs_to :user
  belongs_to :beer_club

  validates :beer_club_id, uniqueness: {scope: :user_id, message: "You're already member of this beer club!"}
end
