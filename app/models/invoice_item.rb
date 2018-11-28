class InvoiceItem < ApplicationRecord
  belongs_to :item
  belongs_to :invoice

  def invoice_item_revenue
    unit_price = self.unit_price.to_i
    quantity = self.quantity.to_i
    quantity * unit_price / 100
  end

  def self.successful_invoice_items
    ids = Invoice.successful_invoices.ids
    InvoiceItem.where(invoice_id: ids)
  end

end
