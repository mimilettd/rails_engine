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

  it "can get all merchants by matching id" do
    factory_merchant = create(:merchant)

    get "/api/v1/merchants/find_all?id=#{factory_merchant.id}"

    merchant = JSON.parse(response.body)

    expect(response).to be_success
    expect(merchant.first["id"]).to eq(factory_merchant.id)
    expect(merchant.count).to eq(1)
  end

  it "can get all merchants by matching name" do
    factory_merchant = create(:merchant)

    get "/api/v1/merchants/find_all?name=#{factory_merchant.name}"

    merchant = JSON.parse(response.body)

    expect(response).to be_success
    expect(merchant.first["name"]).to eq(factory_merchant.name)
    expect(merchant.count).to eq(1)
  end

  it "can get all merchants by matching created_at date" do
    create_list(:merchant, 3)

    merchant_one = Merchant.first

    get "/api/v1/merchants/find_all?created_at=#{merchant_one.created_at}"

    merchant = JSON.parse(response.body)

    expect(response).to be_success
    expect(merchant.count).to eq(3)
  end

  it "can get all merchants by matching updated_at date" do
    create_list(:merchant, 3)

    merchant_one = Merchant.first

    get "/api/v1/merchants/find_all?updated_at=#{merchant_one.updated_at}"

    merchant = JSON.parse(response.body)

    expect(response).to be_success
    expect(merchant.count).to eq(3)
  end

end
