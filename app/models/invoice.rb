class Invoice < ApplicationRecord
  belongs_to :merchant, require: false
  belongs_to :customer, require: false
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items
end
