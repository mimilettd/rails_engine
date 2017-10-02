require 'rails_helper'

describe 'Invoices API' do
  context 'sends a list of invoices' do
    create_list(:invoice, 3)

    get '/api/v1/invoices'

    expect(response).to be_success
  end
end
