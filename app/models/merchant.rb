class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices
  has_many :invoice_items, through: :invoices

# default_scope { order(:id) }

  def self.total_revenue(filter=nil)
    if filter[:date].nil?
      result = joins(invoices: [:invoice_items, :transactions])
      .where(id: filter[:id], transactions: {result: 'success'})
      .group(:id)
      .sum("quantity * unit_price")
    else
      result = joins(invoices: [:invoice_items, :transactions])
      .where(transactions: {result: "success"}, invoices: {created_at: filter[:date]})
      .group(:id)
      .sum("quantity * unit_price")
    end
    result[filter[:id].to_i]
  end

  # def total_revenue(filter=nil)
  #   merchant.invoices.joins(:invoice_items, :transactions)
  # end

  def favorite_customer
    customers
    .select('customers.*, count(transactions) AS trans_count')
    .joins(:transactions)
    .merge(Transaction.unscoped.successful)
    .group('customers.id')
    .order('trans_count desc')
    .first
  end

  def self.most_items(limit)
    joins(invoices: [:invoice_items, :transactions])
    .where(transactions: {result: 'success'})
    .group(:id)
    .order("sum(invoice_items.quantity) DESC")
    .limit(limit)
  end

  def self.top_earners(quantity=nil)
    select('merchants.*, SUM(invoice_items.quantity * invoice_items.unit_price) as revenue')
      .joins(invoices: [:transactions, :invoice_items])
      .merge(Transaction.unscoped.successful)
      .group(:id)
      .order('revenue DESC')
      .limit(quantity)
  end

  def self.revenue_by_date(date=nil)
    joins(invoices: [:invoice_items, :transactions])
    .merge(Transaction.unscoped.successful)
    .where(invoices: {created_at: "#{date}"})
    .sum('quantity * unit_price')
  end
end
