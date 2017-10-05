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
    merchants
    date = merchants.first.invoice_items.first.created_at
    get "/api/v1/merchants/revenue?date=#{date}"

    result = JSON.parse(response.body)

    expect(response).to be_success
    expect(result).to eq({"total_revenue" => "0.0"})
  end

  it 'returns variable list of merchants ranked by revenue' do
      merchants  = create_list(:merchant, 2)
      item1     = create(:item, merchant_id: merchants[0].id)
      item2     = create(:item, merchant_id: merchants[0].id)
      item3     = create(:item, merchant_id: merchants[1].id)
      inv1      = create(:invoice, merchant: merchants[0])
      inv2      = create(:invoice, merchant: merchants[0])
      inv3      = create(:invoice, merchant: merchants[1])
      trans1    = create(:transaction, invoice_id: inv1.id, result: 'success')
      trans2    = create(:transaction, invoice_id: inv2.id, result: 'success')
      trans3    = create(:transaction, invoice_id: inv3.id, result: 'success')
      inv_item1 = create(:invoice_item, invoice_id: inv1.id, quantity: 30, unit_price: 40)
      inv_item2 = create(:invoice_item, invoice_id: inv1.id, quantity: 20, unit_price: 30)
      inv_item3 = create(:invoice_item, invoice_id: inv1.id, quantity: 10, unit_price: 20)

      get "/api/v1/merchants/most_revenue?quantity=#{merchants.size}"

      result = JSON.parse(response.body)

      expect(response).to be_success
      expect(result.first['id']).to eq(merchants[0].id)
      expect(result.first['id']).to_not eq(merchants[1].id)


  end
end
