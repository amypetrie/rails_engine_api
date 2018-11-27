# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative 'config/application'
require 'csv' #added

Rails.application.load_tasks

#added
# namespace :import do
#   desc "import customers from csv"
#   task customers: :environment do
#     filename = File.join Rails.root, "customers.csv"
#     CSV.foreach(filename, headers: true) do |row|
#       Customer.create! row.to_hash
#     end
#   end
# end
