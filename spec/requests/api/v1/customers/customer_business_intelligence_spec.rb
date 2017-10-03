require 'rails_helper'

RSpec.describe Customer, type: :model do
  it 'returns #favorite_customer' do
    id = create_list(:customer, 10).first.id
    create_list(:invoice_item, 30)

    get "/api/v1/merchants/:id/favorite_customer"

    customer = JSON.parse(responce.body)

    expect(customer["id"]).to eq(id)
  end
end
