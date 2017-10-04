require 'rails_helper'

describe "Invoices API" do
  it 'returns a collection of associated transactions' do
    item = create_list(:transaction, 3).first
    invoice = Invoice.find(item.invoice_id)

    get "/api/v1/invoices/#{invoice.id}/transactions"

    expect(response).to be_success

    transactions = JSON.parse(response.body)

    expect(transactions.count).to eq(1)
    expect(transactions.first["id"]).to eq(invoice.transactions.first.id)
  end

  it 'returns a collection of associated invoice items' do
    ii = create_list(:invoice_item, 3).first
    invoice = Invoice.find(ii.invoice_id)

    get "/api/v1/invoices/#{invoice.id}/invoice_items"

    expect(response).to be_success

    invoice_items = JSON.parse(response.body)

    expect(invoice_items.count).to eq(1)
    expect(invoice_items.first["id"]).to eq(invoice.invoice_items.first.id)
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

    items = JSON.parse(response.body)

    expect(items.count).to eq(1)
    expect(items.first["id"]).to eq(invoice.items.first.id)
  end

  it 'returns the associated merchant' do
    invoice = create_list(:invoice, 3).first

    get "/api/v1/invoices/#{invoice.id}/merchant"

    expect(response).to be_success

    merchant = JSON.parse(response.body)

    expect(merchant["id"]).to eq(invoice.merchant.id)
  end

  it 'returns the associated customer' do
    invoice = create_list(:invoice, 3).first

    get "/api/v1/invoices/#{invoice.id}/customer"

    expect(response).to be_success

    customer = JSON.parse(response.body)

    expect(customer["id"]).to eq(invoice.customer.id)
  end
end
