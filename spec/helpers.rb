module Helpers
  def merchant
    @merchant = create(:merchant)
    @invoices = create_list(:invoice, 3, merchant: @merchant)
    create(:transaction,  invoice: @invoices.first)
    create(:transaction,  invoice: @invoices.first, result: "failed")
    create(:transaction,  invoice: @invoices.second, result: "failed")
    create(:transaction,  invoice: @invoices.third)
    create(:invoice_item, invoice: @invoices.first)
    create(:invoice_item, invoice: @invoices.first, quantity: 2)
    create(:invoice_item, invoice: @invoices.first, unit_price: 13635)
    create(:invoice_item, invoice: @invoices.first, quantity: 2, unit_price: 2000)
    create(:invoice_item, invoice: @invoices.second)
    create(:invoice_item, invoice: @invoices.second, quantity: 2)
    create(:invoice_item, invoice: @invoices.second, unit_price: 23324)
    create(:invoice_item, invoice: @invoices.second, quantity: 2, unit_price: 2000)
    create(:invoice_item, invoice: @invoices.third, quantity: 2)
    create(:invoice_item, invoice: @invoices.third, unit_price: 2000)
  end

  def merchants
    merchants = create_list(:merchant, 10)
    invoices = merchants.map do |merchant|
      create(:invoice, merchant: merchant)
    end
    status = ["success", "failed"]
    invoices.each do |invoice|
      create(:invoice_item, invoice: invoice, quantity: rand(1..10), unit_price: 2000)
      create(:transaction, invoice: invoice, result: status.sample)
    end
  end

  def customers
    @customer = create(:customer)
    @merchants = create_list(:merchant, 3)
    invoices = @merchants.map do |merchant|
      create(:invoice, customer: @customer, merchant: merchant)
    end
    create_list(:transaction, 2, invoice: invoices.first)
    create(:transaction,  invoice: invoices.first, result: "failed")
    create(:transaction,  invoice: invoices.second, result: "failed")
    create(:transaction,  invoice: invoices.third)
  end

  def item
    @item = create(:item)
    create_list(:invoice_item, 3, item: @item)
  end

  def revenue_set_up
    @merchant_1 = create(:merchant)
    @merchant_2 = create(:merchant)
    @merchant_3 = create(:merchant)
    invoice_1 = create(:invoice, merchant: @merchant_1)
    invoice_2 = create(:invoice, merchant: @merchant_2)
    invoice_3 = create(:invoice, merchant: @merchant_3)
    create(:transaction,  invoice: invoice_1)
    create(:transaction,  invoice: invoice_1)
    create(:transaction,  invoice: invoice_2)
    create(:transaction,  invoice: invoice_2)
    create(:transaction,  invoice: invoice_2)
    create(:transaction,  invoice: invoice_3)
    create(:invoice_item, invoice: invoice_1, unit_price: 2000)
    create(:invoice_item, invoice: invoice_1, unit_price: 2000)
    create(:invoice_item, invoice: invoice_2, unit_price: 2000)
    create(:invoice_item, invoice: invoice_2, unit_price: 2000)
    create(:invoice_item, invoice: invoice_2, unit_price: 2000)
    create(:invoice_item, invoice: invoice_3, unit_price: 2000)
  end


end
