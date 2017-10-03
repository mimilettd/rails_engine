FactoryGirl.define do
  factory :invoice do
    customer
    merchant
    status "MyString"
    created_at "2017-10-02 17:39:23"
    updated_at "2017-10-02 17:39:23"
  end
end
