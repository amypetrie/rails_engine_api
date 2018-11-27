desc "import transactions from csv"

  task import_transactions: :environment do
    filename = File.join Rails.root, "source_files/transactions.csv"
    CSV.foreach(filename, headers: true) do |row|
      Transaction.create! row.to_hash
    end
  end
