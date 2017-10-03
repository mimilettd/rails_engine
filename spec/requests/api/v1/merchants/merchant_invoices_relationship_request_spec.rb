require 'rails_helper'

describe 'Merchant Invoices API' do
  it 'returns an invoice list for specific merchant' do
    merch = create(:merchant)
    create_list(:invoice, 3)

    get "/api/v1/merchants/#{merch.id}/invoices"

    merchant_inv = JSON.parse(response.body)

    expect(merchant_inv.count).to eq(3)
  end
end
