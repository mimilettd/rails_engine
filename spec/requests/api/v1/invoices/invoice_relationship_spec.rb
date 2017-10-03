require 'rails_helper'

describe "Invoices API" do
  it 'returns the associated merchant' do
    id = create_list(:invoice, 3).first.id

    get "/api/v1/invoices/1/merchant"

    expect(response).to be_success

    invoices = JSON.parse(response.body)

    expect(invoices["id"]).to eq(id)
  end

  it 'returns the associated customer' do
    id = create_list(:invoice, 3).first.id

    get "/api/v1/invoices/1/customer"

    expect(response).to be_success

    invoices = JSON.parse(response.body)

    expect(invoices["id"]).to eq(id)
  end
end
