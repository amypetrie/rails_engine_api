desc "import merchants from csv"

  task import_merchants: :environment do
    filename = File.join Rails.root, "source_files/merchants.csv"
    CSV.foreach(filename, headers: true) do |row|
      Merchant.create! row.to_hash
    end
  end
