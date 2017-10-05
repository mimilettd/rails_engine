class RevenueSerializer < ActiveModel::Serializer
  attributes :revenue

  def revenue
    sum = object / 100.to_f
    sum.to_s
  end
end
