require 'rails_helper'

describe "Merchants API" do
  it "sends a list of merchants" do
    create_list(:merchant, 3)

    get '/api/v1/merchants'

    expect(response).to be_success

    merchants = JSON.parse(response.body)

    expect(merchants.count).to eq(3)
  end

  it "can get one merchant by its id" do
    id = create(:merchant).id

    get "/api/v1/merchants/#{id}"

    merchant = JSON.parse(response.body)

    expect(response).to be_success
    expect(merchant["id"]).to eq(id)
  end

  it "can get one merchant by its name" do
    name = create(:merchant).name

    get "/api/v1/merchants/find?name=#{name}"

    merchant = JSON.parse(response.body)

    expect(response).to be_success
    expect(merchant["name"]).to eq(name)
  end

  it "can get one merchant by its date created at" do
    factory_merchant = create(:merchant)

    get "/api/v1/merchants/find?created_at=#{factory_merchant.created_at}"

    merchant = JSON.parse(response.body)

    expect(response).to be_success
    expect(merchant["id"]).to eq(factory_merchant.id)
  end

  it "can get one merchant by its date updated at" do
    factory_merchant = create(:merchant)

    get "/api/v1/merchants/find?updated_at=#{factory_merchant.updated_at}"

    merchant = JSON.parse(response.body)

    expect(response).to be_success
    expect(merchant["id"]).to eq(factory_merchant.id)
  end
end
