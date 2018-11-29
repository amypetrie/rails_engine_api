class ChangeQuantityAndPriceToIntegersInInvoiceItems < ActiveRecord::Migration[5.2]
  def change
    change_column :invoice_items, :quantity, :integer, using: 'quantity::integer'

    change_column :invoice_items, :unit_price, :integer, using: 'unit_price::integer'
  end
end
