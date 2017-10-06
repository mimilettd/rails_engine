class Customer < ApplicationRecord
  has_many :invoices
  has_many :transactions, through: :invoices
  has_many :merchants, through: :invoices

  def favorite_merchant
    merchants
    .select("merchants.*, count(transactions) as total")
    .joins(invoices: [:transactions])
    .where(transactions: {result: 'success'})
    .group(:id)
    .order('total desc')
    .first
  end
end
