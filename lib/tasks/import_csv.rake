require 'csv'


CSV.foreach(filename, :headers => true) do |row|
  Customer.create!(row.to_hash)
end
