class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices

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
