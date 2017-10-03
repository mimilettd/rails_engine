class InvoiceItem < ApplicationRecord
  belongs_to :item, required: false
  belongs_to :invoice, required: false
end
