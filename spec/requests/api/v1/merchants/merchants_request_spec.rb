require 'rails_helper'

describe "Merchants API" do
  context "Record Endpoints" do
    it "sends a list of merchants" do
      create_list(:merchant, 3)

      get '/api/v1/merchants'

      expect(response).to be_success

      merchants = JSON.parse(response.body)

      expect(merchants.count).to eq(3)
    end

    it "can get one merchant by its id" do
      id = create(:merchant).id

      get "/api/v1/merchants/#{id}"

      merchant = JSON.parse(response.body)

      expect(response).to be_success
      expect(merchant["id"]).to eq(id)
    end

    it "can get one merchant by its name" do
      name = create(:merchant).name

      get "/api/v1/merchants/find?name=#{name}"

      merchant = JSON.parse(response.body)

      expect(response).to be_success
      expect(merchant["name"]).to eq(name)
    end

    it "can get one merchant by its date created at" do
      factory_merchant = create(:merchant)

      get "/api/v1/merchants/find?created_at=#{factory_merchant.created_at}"

      merchant = JSON.parse(response.body)

      expect(response).to be_success
      expect(merchant["id"]).to eq(factory_merchant.id)
    end

    it "can get one merchant by its date updated at" do
      factory_merchant = create(:merchant)

      get "/api/v1/merchants/find?updated_at=#{factory_merchant.updated_at}"

      merchant = JSON.parse(response.body)

      expect(response).to be_success
      expect(merchant["id"]).to eq(factory_merchant.id)
    end

    it "can get all merchants by matching id" do
      factory_merchant = create(:merchant)

      get "/api/v1/merchants/find_all?id=#{factory_merchant.id}"

      merchant = JSON.parse(response.body)

      expect(response).to be_success
      expect(merchant.first["id"]).to eq(factory_merchant.id)
      expect(merchant.count).to eq(1)
    end

    it "can get all merchants by matching name" do
      factory_merchant = create(:merchant)

      get "/api/v1/merchants/find_all?name=#{factory_merchant.name}"

      merchant = JSON.parse(response.body)

      expect(response).to be_success
      expect(merchant.first["name"]).to eq(factory_merchant.name)
      expect(merchant.count).to eq(1)
    end

    it "can get all merchants by matching created_at date" do
      create_list(:merchant, 3)

      merchant_one = Merchant.first

      get "/api/v1/merchants/find_all?created_at=#{merchant_one.created_at}"

      merchant = JSON.parse(response.body)

      expect(response).to be_success
      expect(merchant.count).to eq(3)
    end

    it "can get all merchants by matching updated_at date" do
      create_list(:merchant, 3)

      merchant_one = Merchant.first

      get "/api/v1/merchants/find_all?updated_at=#{merchant_one.updated_at}"

      merchant = JSON.parse(response.body)

      expect(response).to be_success
      expect(merchant.count).to eq(3)
    end
  end
  context "Relationship Endpoints" do
    it 'returns an invoice list for specific merchant' do
      merch = create(:merchant)
      create_list(:invoice, 3, merchant: merch)

      get "/api/v1/merchants/#{merch.id}/invoices"

      merchant_inv = JSON.parse(response.body)

      expect(merchant_inv.count).to eq(3)
    end

    it 'returns invoices for a different merchant' do
      merch = create(:merchant)
      create(:merchant)
      merch.invoices = create_list(:invoice, 3)

      get "/api/v1/merchants/#{merch.id}/invoices"

      merchant_inv = JSON.parse(response.body)

      expect(merchant_inv.first["merchant_id"]).to eq(merch.id)
      expect(merchant_inv.count).to eq(3)
    end
  end
  context "Business Intelligence" do
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
    it 'returns favorite customer' do
      merchant = create(:merchant)
      customer1 = create(:customer)
      customer2 = create(:customer)
      invoice1 = create(:invoice, merchant_id: merchant.id, customer_id: customer1.id)
      invoice2 = create(:invoice, merchant_id: merchant.id, customer_id: customer1.id)
      invoice3 = create(:invoice, merchant_id: merchant.id, customer_id: customer2.id)
      transact1 = create(:transaction, invoice_id: invoice1.id, result: "success")
      transact2 = create(:transaction, invoice_id: invoice2.id, result: "success")
      transact3 = create(:transaction, invoice_id: invoice3.id, result: "success")

      get "/api/v1/merchants/#{merchant.id}/favorite_customer"

      customer = JSON.parse(response.body)

      expect(customer["id"]).to eq(customer1.id)
    end
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
      revenue_set_up

      get "/api/v1/merchants/most_revenue?quantity=2"

      merchs = JSON.parse(response.body)

      expect(merchs.count).to eq(2)
      expect(merchs.first["id"]).to eq(@merchant_2.id)
      expect(merchs.last["id"]).to eq(@merchant_1.id)
    end
  end
end
