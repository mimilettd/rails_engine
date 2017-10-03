require 'csv'

desc "Import data from csv file"
task :import => [:environment] do

#  merchants = "./db/data/merchants.csv"
#
#  CSV.foreach(merchants, :headers => :true, header_converters: :symbol) do |row|
#    m = Merchant.new
#    m.name = row['name']
#    m.created_at = row['created_at']
#    m.updated_at = row['updated_at']
#    m.save!
#  end
#
#  invoices = "./db/data/invoices.csv"
#
#  CSV.foreach(invoices, :headers => :true, header_converters: :symbol) do |row|
#    i = Invoice.new
#    i.customer_id = row['customer_id']
#    i.merchant_id = row['merchant_id']
#    i.status = row['status']
#    i.created_at = row['created_at']
#    i.updated_at = row['updated_at']
#    i.save!
#  end


end
