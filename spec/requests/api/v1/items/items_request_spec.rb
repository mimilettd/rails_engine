require 'rails_helper'

describe "Items API" do
  it "returns list of items" do
    i = create_list(:item, 3)

    get '/api/v1/items'

    items = JSON.parse(response.body)

    expect(items.count).to eq(3)
    expect(items.first["id"]).to eq(i.first.id)
  end

  it "returns specific item" do
    i = create_list(:item, 3)
    id = i.first.id
    get "/api/v1/items/#{id}"

    items = JSON.parse(response.body)

    expect(items["id"]).to eq(id)
  end
end
