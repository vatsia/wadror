require 'rails_helper'

describe User do
  it "has the username set correctly" do
    # TODO do own test for these
    BeerClub
    BeerClubsController
    MembershipsController
    user = User.new username:"Pekka"

    expect(user.username).to eq("Pekka")
  end

  it "is not saved without a password" do
    user = User.create username:"Pekka"

    expect(user).not_to be_valid
    expect(User.count).to eq(0)
  end

  it "is not saved with too short password" do
    user = User.create username:"Pekka", password:"aaa", password_confirmation:"aaa"
    expect(user).not_to be_valid
    expect(User.count).to eq(0)
  end

  it "is not saved with password which contains only letters" do
    user = User.create username:"Pekka", password:"aaaaa", password_confirmation:"aaaaa"
    expect(user).not_to be_valid
    expect(User.count).to eq(0)
  end

  describe "with a proper password" do
    let(:user){ FactoryGirl.create(:user) }

    it "is saved" do
      expect(user).to be_valid
      expect(User.count).to eq(1)
    end

    it "and with two ratings, has the correct average rating" do

      user.ratings << FactoryGirl.create(:rating)
      user.ratings << FactoryGirl.create(:rating2)

      expect(user.ratings.count).to eq(2)
      expect(user.average_rating).to eq(15.0)
    end
  end



  describe "favorite_beer" do
    let(:user){FactoryGirl.create(:user)}

    it "has method for determining one" do
      expect(user).to respond_to(:favorite_beer)
    end

    it "without ratings does not have one" do
      expect(user.favorite_beer).to eq(nil)
    end

    it "is the only rated if only one rating" do
      beer = FactoryGirl.create(:beer)
      rating = FactoryGirl.create(:rating, beer:beer, user:user)

      expect(user.favorite_beer).to eq(beer)
    end

    it "is the one with highest rating if several rated" do
      create_beer_with_rating(10, user)
      best = create_beer_with_rating(25, user)
      create_beer_with_rating(7, user)

      expect(user.favorite_beer).to eq(best)
    end
  end

  describe "favorite style" do
    let(:user){FactoryGirl.create(:user)}

    it "has method for determining one" do
      expect(user).to respond_to(:favorite_style)
    end

    it "without ratings does not have one" do
      # oispa kaljaa
      expect(user.favorite_style).to eq(nil)
    end

    it "don't give anything else when only one rating" do
      beer = create_beer_with_rating(35, user)
      expect(user.favorite_style).to eq(beer.style)
    end

    it "is the most favorited style" do
      b1 = FactoryGirl.create :beer
      b2 = FactoryGirl.create :beer

      FactoryGirl.create(:rating, beer:b1, user:user)
      FactoryGirl.create(:rating, beer:b1, user:user)

      FactoryGirl.create(:rating, beer:b2, user:user)
      FactoryGirl.create(:rating2, beer:b2, user:user)

      expect(user.favorite_style).to eq(b2.style)
    end
  end

  describe "favorite brewery" do
    let(:user){FactoryGirl.create(:user)}

    it "has method for determining one" do
      expect(user).to respond_to(:favorite_brewery)
    end

    it "without ratings does not have one" do
      # oispa kaljaa
      expect(user.favorite_brewery).to eq(nil)
    end

    it "don't give anything else when only one rating" do
      beer = create_beer_with_rating(35, user)
      expect(user.favorite_brewery).to eq(beer.brewery)
    end

    it "is the most favorited style" do
      b1 = FactoryGirl.create :beer
      b2 = FactoryGirl.create :beer

      FactoryGirl.create(:rating, beer:b1, user:user)
      FactoryGirl.create(:rating, beer:b1, user:user)

      FactoryGirl.create(:rating, beer:b2, user:user)
      FactoryGirl.create(:rating2, beer:b2, user:user)

      expect(user.favorite_brewery).to eq(b2.brewery)
    end
  end

end

def create_beers_with_ratings(*scores, user)
  scores.each do |score|
    create_beer_with_rating(score, user)
  end
end

def create_beer_with_rating(score, user)
  beer = FactoryGirl.create(:beer)
  FactoryGirl.create(:rating, score:score, user:user, beer:beer)
  beer
end