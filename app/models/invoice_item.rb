class InvoiceItem < ApplicationRecord
  belongs_to :item
  belongs_to :invoice

  def self.revenue_for_date(date)
    date = date.to_datetime
    day = (date.beginning_of_day..date.end_of_day)
    InvoiceItem.select("SUM(invoice_items.unit_price * invoice_items.quantity) AS total_revenue, transactions.created_at").joins(invoice: :transactions).where("transactions.result = ? AND transactions.created_at = ?", "success", day).group("transactions.created_at")
  end

end
