class InvoiceItemSerializer < ActiveModel::Serializer
  attributes :id, :item_id, :invoice_id, :quantity, :unit_price

  def unit_price
    sum = object.unit_price / 100.to_f
    object.unit_price = sum.to_s
  end
end
