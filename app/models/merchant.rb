class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices


  #find sum of invoice_items by merchant
    #sum(invoice_total(invoices).group_by merchant_id)
    #sort by invoice_total


  def self.top_merchants_by_revenue(quantity)
    Merchant.joins(invoices: [:invoice_items, :transactions]).where(transactions: {result: "success"}).select("merchants.*, SUM(invoice_items.quantity*invoice_items.unit_price) as item_total_revenue").group(:id).order("item_total_revenue desc").limit(quantity)
  end


end
