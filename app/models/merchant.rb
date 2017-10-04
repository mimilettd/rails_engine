class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices

  def self.total_revenue(id)
    result = joins("INNER JOIN invoices ON invoices.merchant_id = merchants.id")
    .joins("INNER JOIN invoice_items ON invoice_items.invoice_id = invoices.id INNER JOIN transactions ON transactions.invoice_id = invoices.id")
    .where(id: id, transactions: {result: 'success'})
    .group(:id)
    .sum("quantity * unit_price")
    sum = result[id.to_i] / 100.to_f
    {"revenue"=>sum.to_s}
  end
end
