class InvoiceItem < ApplicationRecord
  belongs_to :item
  belongs_to :invoice

  def self.revenue_for_date(date)
    date = date.to_datetime
    day = (date.beginning_of_day..date.end_of_day)
    InvoiceItem.select("invoice_items.*, SUM(invoice_items.unit_price * invoice_items.quantity) as total_revenue").joins(invoice: :transactions).where("transactions.result = ? AND transactions.created_at = ?", 'success', day).group(:id).pluck('invoice_items.total_revenue')
  end

end
