desc "import invoices from csv"

  task import_invoices: :environment do
    filename = File.join Rails.root, "source_files/invoices.csv"
    CSV.foreach(filename, headers: true) do |row|
      Invoice.create! row.to_hash
    end
  end
