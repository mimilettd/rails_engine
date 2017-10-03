class Invoice < ApplicationRecord
  belongs_to :customer, required: false
  belongs_to :merchant, required: false
  has_many :transactions
  has_many :invoices
end
