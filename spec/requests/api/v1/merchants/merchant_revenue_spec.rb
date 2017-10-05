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

  it "returns the total revenue for all merchants for a given date" do
    m1, m2 = create_list(:merchant, 2)
    i1 = create(:invoice, merchant_id: m1.id, created_at: '2012-03-16 11:55:05')
    i2 = create(:invoice, merchant_id: m2.id, created_at: '2012-03-16 11:55:05')
    ii1 = create_list(:invoice_item, 3, invoice_id: i1.id)
    ii2 = create_list(:invoice_item, 2, invoice_id: i2.id)

    get "/api/v1/merchants/revenue?date='2012-03-16 11:55:05"

    result = JSON.parse(response.body)

    expect(response).to be_success
    expect(result).to eq({"total_revenue" => "0.0"})
  end

  it 'returns variable list of merchants ranked by revenue' do
    merchants

    get "/api/v1/merchants/most_revenue?quantity=2"

    merchs = JSON.parse(response.body)

    expect(merchs.count).to eq(2)
    expect(merchs.first["id"]).to eq(60)
    expect(merchs.last["id"]).to eq(61)
  end
end
