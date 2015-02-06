require 'rails_helper'

describe "User" do
  before :each do
    FactoryGirl.create :user
  end

  it "page shows oly users own ratings" do
    #create another user for testing
    user1 = FactoryGirl.create :user, username:"ekauseri"
    user2 = FactoryGirl.create :user, username:"tokauseri"
    beer = FactoryGirl.create :beer

    firstuserratings = [11, 33, 49, 23]
    seconduserratings = [12, 34, 50, 24]

    firstuserratings.each do |score|
      FactoryGirl.create :rating, score:score, beer:beer, user:user1
    end
    seconduserratings.each do |score|
      FactoryGirl.create :rating, score:score, beer:beer, user:user2
    end

    visit user_path(user1)

    firstuserratings.each do |score|
      expect(page).to have_content(score)
    end
    seconduserratings.each do |score|
      expect(page).not_to have_content(score)
    end
  end

  describe "who has signed up" do
    it "can signin with right credentials" do
      sign_in(username:'Pekka', password:'Foobar1')

      expect(page).to have_content("Welcome back!")
      expect(page).to have_content("Pekka")
    end

    it "is redirected to signin form if wrong credentials given" do
      sign_in(username:'Pekka', password:'wrong')

      expect(current_path).to eq(signin_path)
      expect(page).to have_content("Username and/or password mismatch")
    end

    it "when sined up with good credentials, is added to system" do
      visit signup_path
      fill_in 'user_username', with:'Brian'
      fill_in 'user_password', with:'Secret55'
      fill_in 'user_password_confirmation', with:'Secret55'

      expect{click_button('Create User')}.to change{User.count}.by(1)
    end
  end
  it "site has favorite brewery and favourite beer style" do
    user = User.first
    beer = FactoryGirl.create :beer

    ratinglist = [12, 33, 21, 34, 50]
    ratinglist.each do |score|
      FactoryGirl.create :rating, score:score, beer:beer, user:user
    end

    visit user_path(user)

    expect(page).to have_content "Favorite beer style is #{user.favorite_style}"
    expect(page).to have_content "Favorite brewery is #{user.favorite_brewery}"
  end

end