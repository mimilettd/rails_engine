require 'rails_helper'

describe "Invoices API" do
  it 'returns a collection of associated merchants' do
    id = create_list(:invoice, 3).first.id

    get "/api/v1/invoices/1/merchants"

    expect(response).to be_success

    invoices = JSON.parse(response.body)

    expect(invoices["id"]).to eq(id)
  end
end
