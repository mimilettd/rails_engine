require 'rails_helper'

describe "Merchant Transactions API" do
  it "returns the total revenue for that merchant across successful transactions" do
    merchant = create(:merchant)
    invoices = create_list(:invoice, 3, merchant: merchant)
    create(:transaction,  invoice: invoices.first)
    create(:transaction,  invoice: invoices.first, result: "failed")
    create(:transaction,  invoice: invoices.second, result: "failed")
    create(:transaction,  invoice: invoices.third)
    create(:invoice_item, invoice: invoices.first)
    create(:invoice_item, invoice: invoices.first, quantity: 2)
    create(:invoice_item, invoice: invoices.first, unit_price: 13635)
    create(:invoice_item, invoice: invoices.first, quantity: 2, unit_price: 2000)
    create(:invoice_item, invoice: invoices.second)
    create(:invoice_item, invoice: invoices.second, quantity: 2)
    create(:invoice_item, invoice: invoices.second, unit_price: 23324)
    create(:invoice_item, invoice: invoices.second, quantity: 2, unit_price: 2000)
    create(:invoice_item, invoice: invoices.third, quantity: 2)
    create(:invoice_item, invoice: invoices.third, unit_price: 2000)

    get "/api/v1/merchants/#{merchant.id}/revenue"

    result = JSON.parse(response.body)

    expect(response).to be_success
    expect(result).to eq({"revenue"=>"196.4"})
  end

  it "returns the total revenue for that merchant for a specific invoice date" do
    merchant = create(:merchant)
    invoices = create_list(:invoice, 3, merchant: merchant)
    create(:transaction,  invoice: invoices.first)
    create(:transaction,  invoice: invoices.first, result: "failed")
    create(:transaction,  invoice: invoices.second, result: "failed")
    create(:transaction,  invoice: invoices.third)
    create(:invoice_item, invoice: invoices.first)
    create(:invoice_item, invoice: invoices.first, quantity: 2)
    create(:invoice_item, invoice: invoices.first, unit_price: 13635)
    create(:invoice_item, invoice: invoices.first, quantity: 2, unit_price: 2000)
    create(:invoice_item, invoice: invoices.second)
    create(:invoice_item, invoice: invoices.second, quantity: 2)
    create(:invoice_item, invoice: invoices.second, unit_price: 23324)
    create(:invoice_item, invoice: invoices.second, quantity: 2, unit_price: 2000)
    create(:invoice_item, invoice: invoices.third, quantity: 2)
    create(:invoice_item, invoice: invoices.third, unit_price: 2000)

    get "/api/v1/merchants/#{merchant.id}/revenue?date=#{invoices.first.created_at}"

    result = JSON.parse(response.body)

    expect(response).to be_success
    expect(result).to eq({"revenue"=>"196.4"})
  end
end
