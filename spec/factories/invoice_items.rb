FactoryGirl.define do
  factory :invoice_item do
    item
    invoice
    quantity 1
    unit_price 1
    created_at "2017-10-03 12:44:10"
    updated_at "2017-10-03 12:44:10"
  end
end
