require 'rails_helper'

describe "Transactions API" do
  context "Record Endpoints" do
    it "can send a list of transactions" do
      create_list(:transaction, 3, result: 'success')

      get '/api/v1/transactions'

      expect(response).to be_success

      transactions = JSON.parse(response.body)

      expect(transactions.count).to eq(3)
    end

    it "can get one transaction" do
      id = create(:transaction).id

      get "/api/v1/transactions/#{id}"

      expect(response).to be_success

      transaction = JSON.parse(response.body)

      expect(transaction["id"]).to eq(id)
    end

    it "can find first instance by id" do
      id = create_list(:transaction, 3, result: 'success').first.id
      get "/api/v1/transactions/find?id=#{id}"

      transaction = JSON.parse(response.body)

      expect(response).to be_success
      expect(transaction["id"]).to eq(id)
    end

    it "can find first instance by invoice id" do
      id = create_list(:transaction, 3, result: 'success').first.invoice_id

      get "/api/v1/transactions/find?invoice_id=#{id}"

      transaction = JSON.parse(response.body)

      expect(response).to be_success
      expect(transaction["invoice_id"]).to eq(id)
    end

    it "can find first instance by credit card number" do
      id = create_list(:transaction, 3, result: 'success').first.credit_card_number

      get "/api/v1/transactions/find?credit_card_number=#{id}"

      transaction = JSON.parse(response.body)

      expect(response).to be_success
      expect(transaction["credit_card_number"]).to eq(id)
    end

    it "can find first instance by result" do
      result = create_list(:transaction, 3).first.result

      get "/api/v1/transactions/find?result=#{result}"

      transaction = JSON.parse(response.body)

      expect(response).to be_success
      expect(transaction["result"]).to eq(result)
    end

    it "can get all transactions by matching id" do
      id = create(:transaction).id

      get "/api/v1/transactions/find_all?id=#{id}"

      transactions = JSON.parse(response.body)

      expect(response).to be_success
      expect(transactions.first["id"]).to eq(id)
      expect(transactions.count).to eq(1)
    end

    it "can get all transactions by matching invoice id" do
      id = create_list(:transaction, 3).first.invoice_id

      get "/api/v1/transactions/find_all?invoice_id=#{id}"

      transactions = JSON.parse(response.body)

      expect(response).to be_success
      expect(transactions.first["invoice_id"]).to eq(id)
      expect(transactions.count).to eq(1)
    end

    it "can get all transactions by matching invoice id" do
      id = create_list(:transaction, 3).first.invoice_id

      get "/api/v1/transactions/find_all?invoice_id=#{id}"

      transactions = JSON.parse(response.body)

      expect(response).to be_success
      expect(transactions.first["invoice_id"]).to eq(id)
      expect(transactions.count).to eq(1)
    end

    it "can get all transactions by matching credit card number" do
      credit_card_number = create_list(:transaction, 3).first.credit_card_number

      get "/api/v1/transactions/find_all?credit_card_number=#{credit_card_number}"

      transactions = JSON.parse(response.body)

      expect(response).to be_success
      expect(transactions.first["credit_card_number"]).to eq(credit_card_number)
      expect(transactions.count).to eq(3)
    end

    it "can get all transactions by matching result" do
      result = create_list(:transaction, 3, result: 'success').first.result

      get "/api/v1/transactions/find_all?result=#{result}"

      transactions = JSON.parse(response.body)

      expect(response).to be_success
      expect(transactions.first["result"]).to eq(result)
      expect(transactions.count).to eq(3)
    end
  end
  context "Relationship Endpoints" do
    it "returns the associated invoice" do
      transaction = create(:transaction)

      get "/api/v1/transactions/#{transaction.id}/invoice"

      invoice = JSON.parse(response.body)

      expect(response).to be_success
      expect(invoice["id"]).to eq(transaction.invoice_id)
    end
  end
end
