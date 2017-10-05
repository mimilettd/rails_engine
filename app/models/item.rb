class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  def self.top_earners(quantity=nil)
    select('items.*')
    .joins(invoices: :transactions)
    .merge(Transaction.unscoped.successful)
    .group(:id)
    .order('SUM(invoice_items.quantity * invoice_items.unit_price) DESC')
    .limit(quantity)
  end

  def self.most_item(limit=5)
    self.select("items.*, sum(invoice_items.quantity) as total")
    .joins(invoices: [:transactions])
    .merge(Transaction.unscoped.successful)
    .group(:id).order('total desc')
    .limit(limit)
  end
end
