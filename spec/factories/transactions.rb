FactoryGirl.define do
  factory :transaction do
    invoice
    credit_card_number "MyString"
    result "success"
    created_at "2017-10-03 12:54:33"
    updated_at "2017-10-03 12:54:33"
  end
end
