require 'rails_helper'

describe "Merchant Transactions API" do
  it "returns the total revenue for that merchant across successful transactions" do
    merchant

    get "/api/v1/merchants/#{@merchant.id}/revenue"

    result = JSON.parse(response.body)

    expect(response).to be_success
    expect(result).to eq({"revenue"=>"196.4"})
  end

  it "returns the total revenue for that merchant for a specific invoice date" do
    merchant

    get "/api/v1/merchants/#{@merchant.id}/revenue?date=#{@invoices.first.created_at}"

    result = JSON.parse(response.body)

    expect(response).to be_success
    expect(result).to eq({"revenue"=>"196.4"})
  end

  it "returns the top x merchants ranked by total number of items sold" do
    merchants

    get "/api/v1/merchants/most_items?quantity=3"

    result = JSON.parse(response.body)

    expect(response).to be_success
    expect(result.count).to eq(3)
  end
end
