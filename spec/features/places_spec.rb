require 'rails_helper'

describe "Places" do
  it "if one is returned by the API, it is shown on the page" do
    allow(BeermappingApi).to receive(:places_in).with("kumpula").and_return(
      [Place.new(name:"Oljenkorsi", id: 1)]
    )

    visit places_path
    fill_in('city', with: 'kumpula')
    click_button('Search')
    expect(page).to have_content("Oljenkorsi")
  end

  it "if many are returned by API, are shown on the page" do
    allow(BeermappingApi).to receive(:places_in).with("kumpula").and_return(
      [Place.new(name:"Oljenkorsi", id: 1),
       Place.new(name:"Olotila", id: 2),
       Place.new(name:"Pub Magneetti", id: 3)]
    )


    visit places_path
    fill_in('city', with: 'kumpula')
    click_button('Search')

    expect(page).to have_content("Oljenkorsi")
    expect(page).to have_content("Olotila")
    expect(page).to have_content("Pub Magneetti")
  end

  it "if none returned by API, error is shown on the page" do
    allow(BeermappingApi).to receive(:places_in).with("kumpula").and_return([])

    visit places_path
    fill_in('city', with: 'kumpula')
    click_button('Search')

    expect(page).to have_content("No locations in kumpula")
  end
end