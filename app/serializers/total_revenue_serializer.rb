class TotalRevenueSerializer < ActiveModel::Serializer
  attributes :total_revenue

  def total_revenue
    sum = object / 100.to_f
    sum.to_s
  end
end
