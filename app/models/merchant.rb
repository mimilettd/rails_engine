class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices

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
    sum = result[filter[:id].to_i] / 100.to_f
    {"revenue"=>sum.to_s}
  end

  def favorite_customer
    customers
    .select('customers.*, count(transactions) AS trans_count')
    .joins(:transactions)
    .merge(Transaction.unscoped.successful)
    .group('customers.id')
    .order('trans_count desc')
    .first
  end
end
