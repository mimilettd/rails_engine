class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  default_scope {order(:id)}

  def self.top_earners(quantity=nil)
    unscoped.select('items.*')
    .joins(invoices: :transactions)
    .merge(Transaction.unscoped.successful)
    .group(:id)
    .order('SUM(invoice_items.quantity * invoice_items.unit_price) DESC')
    .limit(quantity)
  end

  def self.most_item(limit=5)
    unscoped.select("items.*, sum(invoice_items.quantity) as total")
    .joins(invoices: [:transactions])
    .merge(Transaction.unscoped.successful)
    .group(:id).order('total desc')
    .limit(limit)
  end

  def best_day
    invoice_items
    .joins(invoice: :transactions)
    .merge(Transaction.unscoped.successful)
    .group(:id)
    .order('invoice_items.quantity desc')
    .first
    .invoice
    .created_at
  end
end
