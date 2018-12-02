class ChangeQuantityAndPriceToIntegersInInvoiceItems < ActiveRecord::Migration[5.2]
  def change
    change_column :invoice_items, :quantity, :integer, using: 'quantity::integer'
  end
end
