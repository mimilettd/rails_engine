class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  def self.top_earners(quantity=nil)
    select('items.*')
    .joins(invoices: :transactions)
    .merge(Transaction.successful)
    .group(:id)
    .order('SUM(invoice_items.quantity * invoice_items.unit_price) DESC')
    .limit(quantity)
  end
end
