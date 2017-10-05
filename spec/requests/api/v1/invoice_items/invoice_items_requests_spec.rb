require 'rails_helper'

describe "Invoice Items API" do
  context "Record Endpoints" do
    it "can send a list of invoice items" do
      create_list(:invoice_item, 3)

      get "/api/v1/invoice_items"

      expect(response).to be_success

      invoice_items = JSON.parse(response.body)

      expect(invoice_items.count).to eq(3)
    end

    it "can send one invoice item" do
      id = create(:invoice_item).id

      get "/api/v1/invoice_items/#{id}"

      expect(response).to be_success

      invoice_item = JSON.parse(response.body)

      expect(invoice_item["id"]).to eq(id)
    end

    it "can find first instance by item id" do
      item_id = create_list(:invoice_item, 3).first.item_id

      get "/api/v1/invoice_items/find?item_id=#{item_id}"

      expect(response).to be_success

      customer = JSON.parse(response.body)

      expect(customer["item_id"]).to eq(item_id)
    end

    it "can find first instance by invoice id" do
      invoice_id = create_list(:invoice_item, 3).first.invoice_id

      get "/api/v1/invoice_items/find?invoice_id=#{invoice_id}"

      expect(response).to be_success

      customer = JSON.parse(response.body)

      expect(customer["invoice_id"]).to eq(invoice_id)
    end

    it "can find first instance by quantity" do
      quantity = create_list(:invoice_item, 3).first.quantity

      get "/api/v1/invoice_items/find?quantity=#{quantity}"

      expect(response).to be_success

      customer = JSON.parse(response.body)

      expect(customer["quantity"]).to eq(quantity)
    end
  end
  context "Relationship Endpoints" do
    it "returns the associated invoice" do
      invoice_item = create(:invoice_item)

      get "/api/v1/invoice_items/#{invoice_item.id}/invoice"

      expect(response).to be_success

      invoice = JSON.parse(response.body)

      expect(invoice["id"]).to eq(invoice_item.invoice_id)
    end
  end
end
