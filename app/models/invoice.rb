class Invoice < ApplicationRecord
  belongs_to :customer, class_name: 'Customer', foreign_key: 'customer_id'
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items
end
