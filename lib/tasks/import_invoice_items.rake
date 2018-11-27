desc "import invoice_items from csv"

  task import_invoice_items: :environment do
    filename = File.join Rails.root, "source_files/invoice_items.csv"
    CSV.foreach(filename, headers: true) do |row|
      InvoiceItem.create! row.to_hash
    end
  end
