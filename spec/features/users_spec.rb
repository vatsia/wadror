require 'rails_helper'

describe "User" do
  before :each do
    FactoryGirl.create :user
  end

  describe "who has signed up" do
    it "can signin with right credentials" do
      visit signin_path

      fill_in 'username', with:'Pekka'
      fill_in 'password', with: 'Foobar1'

      click_button('Log In')

      expect(page).to have_content("Welcome back!")
      expect(page).to have_content("Pekka")
    end

    it "is redirected to signin form if wrong credentials given" do
      visit signin_path

      fill_in 'username', with:'Pekka'
      fill_in 'password', with:'wrong'

      click_button('Log In')

      expect(current_path).to eq(signin_path)
      expect(page).to have_content("Username and/or password mismatch")
    end
  end
end