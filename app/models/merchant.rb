class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices

  #find successful transactions
  #find invoices that have succssful transactions
  #find invoice total for invoice(invoice)
  #find sum of invoice_items by merchant
    #sum(invoice_total(invoices).group_by merchant_id)
    #sort by invoice_total


  #merchants with the most successful invoices
  def self.top_merchants_by_revenue(quantity)
    Invoice.invoices_with_successful_transactions
  end
end
