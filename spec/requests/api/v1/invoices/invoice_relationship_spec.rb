require 'rails_helper'

describe "Invoices API" do
  it 'returns a collection of associated transactions' do
    id = create_list(:transaction, 3).first.invoice_id

    get "/api/v1/invoices/#{id}/transactions"

    expect(response).to be_success

    invoices = JSON.parse(response.body)

    expect(invoices.count).to eq(1)
  end

  it 'returns a collection of associated invoice items' do
    id = create_list(:invoice_item, 3).first.invoice_id

    get "/api/v1/invoices/#{id}/invoice_items"

    expect(response).to be_success

    invoices = JSON.parse(response.body)

    expect(invoices.count).to eq(1)
  end

  it 'returns a collection of associated items' do
    invoice = create_list(:invoice, 3).first
    merchant = create(:merchant).id
    item = Item.create(name: "MyString",
                      description: "MyString",
                      unit_price: 1,
                      merchant_id: merchant,
                      created_at: "2017-10-03 12:31:15",
                      updated_at: "2017-10-03 12:31:15")
    InvoiceItem.create(item_id: item.id,
                       invoice_id: invoice.id,
                       quantity: 4,
                       unit_price: 1400,
                       created_at: "2017-10-03 12:31:15",
                       updated_at: "2017-10-03 12:31:15")

    get "/api/v1/invoices/#{invoice.id}/items"

    expect(response).to be_success

    invoices = JSON.parse(response.body)

    expect(invoices.count).to eq(1)
  end

  it 'returns the associated merchant' do
    id = create_list(:invoice, 3).first.id

    get "/api/v1/invoices/#{id}/merchant"

    expect(response).to be_success

    invoices = JSON.parse(response.body)

    expect(invoices["id"]).to eq(id)
  end

  it 'returns the associated customer' do
    id = create_list(:invoice, 3).first.id

    get "/api/v1/invoices/#{id}/customer"

    expect(response).to be_success

    invoices = JSON.parse(response.body)

    expect(invoices["id"]).to eq(id)
  end
end
