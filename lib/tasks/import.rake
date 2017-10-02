require 'csv'

desc "Import data from csv file"
task :import => [:environment] do

  customers = "db/data/customer.csv"
  invoice_items = "db/data/invoice_items.csv"
  invoices = "db/data/invoices.csv"
  items = "db/data/items.csv"
  merchants = "db/data/merchants.csv"
  transactions = "db/data/transactions.csv"

  # CSV.foreach(customers, :headers => :true, header_converters: :symbol) do |row|
  #   Customer.create {
  #     :first_name => row[1],
  #     :last_name => row[2],
  #     :created_at => row[3],
  #     :updated_at => row[4]
  #   }
  # end

end
