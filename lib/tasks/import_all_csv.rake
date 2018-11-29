desc "import all model csv files"
task import_all_csv: :environment do
  Rake::Task["import_merchants"].invoke
  Rake::Task["import_customers"].invoke
  Rake::Task["import_items"].invoke
  Rake::Task["import_invoices"].invoke
  Rake::Task["import_invoice_items"].invoke
  Rake::Task["import_transactions"].invoke
end
