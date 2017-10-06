require 'rails_helper'

describe 'Items API' do
  context 'Business Intelligence' do
    it 'returns top ranked item' do
      merchant  = create(:merchant)
      item1     = create(:item, merchant_id: merchant.id)
      item2     = create(:item, merchant_id: merchant.id)
      item3     = create(:item, merchant_id: merchant.id)
      inv1      = create(:invoice)
      inv2      = create(:invoice)
      inv3      = create(:invoice)
      trans1    = create(:transaction, invoice_id: inv1.id, result: 'success')
      trans2    = create(:transaction, invoice_id: inv2.id, result: 'success')
      trans3    = create(:transaction, invoice_id: inv3.id, result: 'success')
      inv_item1 = create(:invoice_item, invoice_id: inv1.id, quantity: 30, unit_price: 40)
      inv_item2 = create(:invoice_item, invoice_id: inv1.id, quantity: 20, unit_price: 30)
      inv_item3 = create(:invoice_item, invoice_id: inv1.id, quantity: 10, unit_price: 20)

      get '/api/v1/items/most_revenue?quantity=2'
      top_items = JSON.parse(response.body)

      # expect(top_items.first['id']).to eq(4)
      expect(top_items.count).to eq(2)
    end
    it "returns the date with the most sales for the given item using the invoice date" do

    end
  end
  context 'Record Endpoints' do
    it "can send a list of items" do
      create_list(:item, 3)

      get '/api/v1/items'

      expect(response).to be_success

      items = JSON.parse(response.body)

      expect(items.count).to eq(3)
    end
    it "can send one item" do
      id = create(:item).id

      get "/api/v1/items/#{id}"

      expect(response).to be_success

      item = JSON.parse(response.body)

      expect(item["id"]).to eq(id)
    end

    it "can find first instance by id" do
      id = create_list(:item, 3).first.id

      get "/api/v1/items/find?id=#{id}"

      expect(response).to be_success

      item = JSON.parse(response.body)

      expect(item["id"]).to eq(id)
    end

    it "can find first instance by name" do
      name = create_list(:item, 3).first.name

      get "/api/v1/items/find?name=#{name}"

      expect(response).to be_success

      item = JSON.parse(response.body)

      expect(item["name"]).to eq(name)
    end

    it "can find first instance by description" do
      description = create_list(:item, 3).first.description

      get "/api/v1/items/find?description=#{description}"

      expect(response).to be_success

      item = JSON.parse(response.body)

      expect(item["description"]).to eq(description)
    end

    it "can find first instance by unit price" do
      item = create_list(:item, 3).first

      get "/api/v1/items/find?unit_price=#{item.unit_price}"

      expect(response).to be_success

      result = JSON.parse(response.body)

      expect(result["id"]).to eq(item.id)
    end

    it "can find first instance by merchant" do
      merchant_id = create_list(:item, 3).first.merchant_id

      get "/api/v1/items/find?merchant_id=#{merchant_id}"

      expect(response).to be_success

      item = JSON.parse(response.body)

      expect(item["merchant_id"]).to eq(merchant_id)
    end

    it "can get all items by matching name" do
      item = create_list(:item, 3).first

      get "/api/v1/items/find_all?name=#{item.name}"

      items = JSON.parse(response.body)

      expect(response).to be_success
      expect(items.first["name"]).to eq(item.name)
      expect(items.count).to eq(3)
    end

    it "can get all items by matching description" do
      item = create_list(:item, 3).first

      get "/api/v1/items/find_all?description=#{item.description}"

      items = JSON.parse(response.body)

      expect(response).to be_success
      expect(items.first["description"]).to eq(item.description)
      expect(items.count).to eq(3)
    end

    it "can get all items by matching unit price" do
      item = create_list(:item, 3).first

      get "/api/v1/items/find_all?unit_price=#{item.unit_price}"

      items = JSON.parse(response.body)

      expect(response).to be_success
      expect(items.count).to eq(3)
    end

    it "can get all items by matching merchant_id" do
      item = create_list(:item, 3).first

      get "/api/v1/items/find_all?merchant_id=#{item.merchant_id}"

      items = JSON.parse(response.body)

      expect(response).to be_success
      expect(items.first["merchant_id"]).to eq(item.merchant_id)
      expect(items.count).to eq(1)
    end
  end
  context "Relationship Endpoints" do
    it "returns a collection of associated invoice items" do
      item

      get "/api/v1/items/#{@item.id}/invoice_items"

      ii = JSON.parse(response.body)

      expect(response).to be_success
      expect(ii.count).to eq(3)
    end
    it "returns the associated merchant" do
      item

      get "/api/v1/items/#{@item.id}/merchant"

      merchant = JSON.parse(response.body)

      expect(response).to be_success
      expect(merchant["id"]).to eq(@item.merchant.id)
    end
  end
end
