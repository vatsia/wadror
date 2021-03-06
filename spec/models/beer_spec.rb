require 'rails_helper'

RSpec.describe Beer, :type => :model do
  it "is saved if beer has name and style" do
    beer = Beer.create name:"oispa", style:Style.create(name:"Lager")
    expect(beer).to be_valid
    expect(Beer.count).to eq(1)
  end

  it "is not saved if it has no name" do
    beer = Beer.create name:"", style:Style.create(name:"Lager")
    expect(beer).not_to be_valid
    expect(Beer.count).to eq(0)
  end

  it "is not saved if it has no style" do
    beer = Beer.create name:"oispa", style:nil
    expect(beer).not_to be_valid
    expect(Beer.count).to eq(0)
  end
end
