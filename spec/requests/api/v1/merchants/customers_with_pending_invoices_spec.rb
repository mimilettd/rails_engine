require 'rails_helper'

describe 'Merchants Customers' do
  context '/api/v1/merchants/:id/customers_with_pending_invoices' do
    it 'returns list of customers with pending invoices' do
      customers = create_list(:customer, 4)
      merchant  = create(:merchant)
      invoice1  = create(:invoice, merchant: merchant, customer: customers[0])
      invoice2  = create(:invoice, merchant: merchant, customer: customers[1])
      invoice3  = create(:invoice, merchant: merchant, customer: customers[2])
      invoice4  = create(:invoice, merchant: merchant, customer: customers[3])
      transaction1 = create(:transaction, invoice: invoice1, result: 'success')
      transaction2 = create(:transaction, invoice: invoice1, result: 'failed')
      transaction3 = create(:transaction, invoice: invoice2, result: 'success')
      transaction4 = create(:transaction, invoice: invoice2, result: 'failed')
      transaction5 = create(:transaction, invoice: invoice3, result: 'success')
      transaction6 = create(:transaction, invoice: invoice4, result: 'failed')


      get "/api/v1/merchants/#{merchant.id}/customers_with_pending_invoices"

      customer = JSON.parse(response.body)

      expect(customer.first["id"]).to eq(customers[3].id)
      expect(customer.size).to eq(1)
      expect(customer.first['id']).to_not eq(customers[2].id)
      expect(response).to be_success
    end
  end
end
