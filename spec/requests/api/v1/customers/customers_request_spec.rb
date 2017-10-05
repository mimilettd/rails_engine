require 'rails_helper'

describe "Customers API" do
  context "Record Endpoints" do
    it "can send a list of customers" do
      create_list(:customer, 3)

      get "/api/v1/customers"

      expect(response).to be_success

      customers = JSON.parse(response.body)

      expect(customers.count).to eq(3)
    end
  end

  it "can send one customer" do
    id = create(:customer).id

    get "/api/v1/customers/#{id}"

    expect(response).to be_success

    customer = JSON.parse(response.body)

    expect(customer["id"]).to eq(id)
  end
end
