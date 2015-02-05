require 'rails_helper'

describe "Beers page" do
  let!(:brewery){FactoryGirl.create :brewery}

  it "should have one when created with valid credentials" do
    visit new_beer_path
    fill_in 'beer_name', with:"Validibisse"
    select 'Weizen', from:'beer_style'
    select 'anonymous', from:'beer_brewery_id'
    click_button 'Create Beer'
    
    expect(page).to have_content('Beer was successfully created.')
  end

  it "should get back to beer creation page if name is not valid" do
    visit new_beer_path
    fill_in 'beer_name', with:""
    select 'Weizen', from:'beer_style'
    select 'anonymous', from:'beer_brewery_id'
    click_button 'Create Beer'

    expect(page).to have_content('Name can\'t be blank')
    expect(current_path).to eq(beers_path)
    expect(Beer.count).to eq(0)
  end
end