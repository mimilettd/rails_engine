class ItemSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :unit_price, :merchant_id

  def unit_price
    sum = object.unit_price / 100.to_f
    object.unit_price = sum.to_s
  end
end
