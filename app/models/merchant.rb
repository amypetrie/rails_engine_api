class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices


  #find sum of invoice_items by merchant
    #sum(invoice_total(invoices).group_by merchant_id)
    #sort by invoice_total


  def self.merchants_by_revenue(quantity)
    Merchant.successful_merchants.join('invoices').order('invoices.invoice_total').group(:id)
  end

  def self.successful_merchants
    ids = Invoice.successful_merchant_ids
    Merchant.where(id: ids)
  end

end
