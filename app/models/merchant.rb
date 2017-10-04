class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices

  def self.total_revenue(filter=nil)
    if filter[:date].nil?
      result = joins(invoices: [:invoice_items, :transactions])
      .where(id: filter[:id], transactions: {result: 'success'})
      .group(:id)
      .sum("quantity * unit_price")
      sum = result[filter[:id].to_i] / 100.to_f
      {"revenue"=>sum.to_s}
    else
      result = joins(invoices: [:invoice_items, :transactions])
      .where(transactions: {result: "success"}, invoices: {created_at: filter[:date]})
      .group(:id)
      .sum("quantity * unit_price")
      sum = result[filter[:id].to_i] / 100.to_f
      {"revenue"=>sum.to_s}
    end
  end
end
