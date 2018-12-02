class Invoice < ApplicationRecord
  belongs_to :customer
  belongs_to :merchant
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :transactions

  # def invoice_total
  #   total = invoice_items.map do |ii|
  #     ii.invoice_item_revenue
  #   end
  #   total.sum
  # end
  #
  # def self.successful_invoices
  #   ids = Transaction.successful_transactions.successful_invoice_ids
  #   Invoice.where(id: ids)
  # end
  #
  # def self.successful_merchant_ids
  #   Invoice.successful_invoices.map {|i| i.merchant_id}
  # end

end
