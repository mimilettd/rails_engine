require 'rails_helper'

describe 'Invoices API' do
  context "Record Endpoints" do
    it 'sends a list of invoices' do
      create_list(:invoice, 3)

      get '/api/v1/invoices'

      expect(response).to be_success

      invoices = JSON.parse(response.body)

      expect(invoices.count).to eq(3)

    end

    it 'send a specific invocie' do
      id = create(:invoice).id

      get "/api/v1/invoices/#{id}"

      invoice = JSON.parse(response.body)

      expect(invoice["id"]).to eq(id)
    end

    it 'can find invoice by primary key' do
      inv_list = create_list(:invoice, 3)
      i1 = inv_list.first.id

      get "/api/v1/invoices/#{i1}"

      invoice = JSON.parse(response.body)

      expect(invoice["id"]).to eq(i1)

    end

    it 'can find by #customer_id' do
      inv_list = create_list(:invoice, 3)
      i1 = inv_list.first.customer_id

      get "/api/v1/invoices/find_all?customer_id=#{i1}"

      invoice = JSON.parse(response.body)

      expect(invoice.count).to eq(1)

    end

    it 'can find by #merchant_id' do
      inv_list = create_list(:invoice, 3)
      i1 = inv_list.first.merchant_id

      get "/api/v1/invoices/find_all?merchant_id=#{i1}"

      invoice = JSON.parse(response.body)

      expect(invoice.count).to eq(1)
    end

    it 'can find by #created_at' do
      inv_list = create_list(:invoice, 3)
      i1 = inv_list.first.created_at

      get "/api/v1/invoices/find_all?created_at=#{i1}"

      invoice = JSON.parse(response.body)

      expect(invoice.count).to eq(3)
    end
  end
  context "Relationship Endpoints" do
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
end
