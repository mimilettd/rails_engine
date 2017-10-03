require 'csv'
require './app/models/merchant.rb'

desc "Import data from csv file"
task :import => [:environment] do

  merchants = "./db/data/merchants.csv"

  CSV.foreach(merchants, :headers => :true, header_converters: :symbol) do |row|
    m = Merchant.new
    m.name = row['name']
    m.created_at = row['created_at']
    m.updated_at = row['updated_at']
    m.save!
  end
end
