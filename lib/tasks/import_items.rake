desc "import items from csv"

  task import_items: :environment do
    filename = File.join Rails.root, "source_files/items.csv"
    CSV.foreach(filename, headers: true) do |row|
      Item.create! row.to_hash
    end
  end
