require 'rails_helper'

describe 'Invoices API' do
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
    i1 = inv_list.first

    get "/api/v1/invoices/#{i1.id}"

    invoice = JSON.parse(response.body)

    expect(invoice["id"]).to eq(1)

  end
end
