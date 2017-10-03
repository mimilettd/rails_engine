require 'rails_helper'

describe 'Merchant Invoices API' do
  it 'returns an invoice list for specific merchant' do
    merch = create(:merchant)
    create_list(:invoice, 3)

    get "/api/v1/merchants/#{merch.id}/invoices"

    merchant_inv = JSON.parse(response.body)

    expect(merchant_inv.count).to eq(3)
  end

  it 'returns invoices for a different merchant' do
    merch = create(:merchant)
    merch_2 = create(:merchant)
    create_list(:invoice, 3)

    get "/api/v1/merchants/#{merch.id}/invoices"

    merchant_inv = JSON.parse(response.body)

    expect(merchant_inv.first["merchant_id"]).to eq(1)
    expect(merchant_inv.count).to eq(3)
  end
end
