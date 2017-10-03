class Item < ApplicationRecord
  belongs_to :merchant, required: false
  has_many :invoice_items
end
