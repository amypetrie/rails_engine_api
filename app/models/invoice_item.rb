require 'time' #is this needed?

class InvoiceItem < ApplicationRecord
  belongs_to :item
  belongs_to :invoice

  def self.revenue_for_date(date)
    InvoiceItem.joins(invoice: :transactions).where("transactions.result = ?", "success").where("transactions.created_at = ?", (date.date_start..date.date_end)).sum('invoice_items.unit_price * invoice_items.quantity')
  end

end
