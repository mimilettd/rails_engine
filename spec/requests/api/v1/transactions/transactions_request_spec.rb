require 'rails_helper'

describe "Transactions API" do
  it "sends a list of transactions" do
    create_list(:transaction, 3, result: 'success')

    get '/api/v1/transactions'

    expect(response).to be_success

    transactions = JSON.parse(response.body)

    expect(transactions.count).to eq(3)
  end

  it "can get one transaction by its id" do
    id = create(:transaction).id

    get "/api/v1/transactions/#{id}"

    expect(response).to be_success

    transaction = JSON.parse(response.body)

    expect(transaction["id"]).to eq(id)
  end

  it "find first instance by id" do
    id = create_list(:transaction, 3, result: 'success').first.id
    get "/api/v1/transactions/find?id=#{id}"

    transaction = JSON.parse(response.body)

    expect(response).to be_success
    expect(transaction["id"]).to eq(id)
  end

  it "find first instance by invoice id" do
    id = create_list(:transaction, 3, result: 'success').first.invoice_id

    get "/api/v1/transactions/find?invoice_id=#{id}"

    transaction = JSON.parse(response.body)

    expect(response).to be_success
    expect(transaction["invoice_id"]).to eq(id)
  end
end
