desc "import customers from csv"

  task import_customers: :environment do
    filename = File.join Rails.root, "source_files/customers.csv"
    CSV.foreach(filename, headers: true) do |row|
      Customer.create! row.to_hash
    end
  end
