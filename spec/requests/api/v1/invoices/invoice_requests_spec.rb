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

    expect(invoice.count).to eq(3)

  end

  it 'can find by #merchant_id' do
    inv_list = create_list(:invoice, 3)
    i1 = inv_list.first.merchant_id

    get "/api/v1/invoices/find_all?merchant_id=#{i1}"

    invoice = JSON.parse(response.body)

    expect(invoice.count).to eq(3)
  end

  it 'can find by #created_at' do
    inv_list = create_list(:invoice, 3)
    i1 = inv_list.first.created_at

    get "/api/v1/invoices/find_all?created_at=#{i1}"

    invoice = JSON.parse(response.body)

    expect(invoice.count).to eq(3)

  end
end
