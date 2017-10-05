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

    it "can send one customer" do
      id = create(:customer).id

      get "/api/v1/customers/#{id}"

      expect(response).to be_success

      customer = JSON.parse(response.body)

      expect(customer["id"]).to eq(id)
    end

    it "can find first instance by id" do
      id = create_list(:customer, 3).first.id

      get "/api/v1/customers/find?id=#{id}"

      expect(response).to be_success

      customer = JSON.parse(response.body)

      expect(customer["id"]).to eq(id)
    end

    it "can find first instance by first name" do
      first_name = create_list(:customer, 3).first.first_name

      get "/api/v1/customers/find?first_name=#{first_name}"

      expect(response).to be_success

      customer = JSON.parse(response.body)

      expect(customer["first_name"]).to eq(first_name)
    end

    it "can find first instance by last name" do
      last_name = create_list(:customer, 3).first.last_name

      get "/api/v1/customers/find?last_name=#{last_name}"

      expect(response).to be_success

      customer = JSON.parse(response.body)

      expect(customer["last_name"]).to eq(last_name)
    end

    it "can get all customers by matching first name" do
      customer = create_list(:customer, 3).first

      get "/api/v1/customers/find_all?first_name=#{customer.first_name}"

      customers = JSON.parse(response.body)

      expect(response).to be_success
      expect(customers.first["first_name"]).to eq(customer.first_name)
      expect(customers.count).to eq(3)
    end

    it "can get all customers by matching last name" do
      customer = create_list(:customer, 3).first

      get "/api/v1/customers/find_all?last_name=#{customer.last_name}"

      customers = JSON.parse(response.body)

      expect(response).to be_success
      expect(customers.first["last_name"]).to eq(customer.last_name)
      expect(customers.count).to eq(3)
    end
  end


end
