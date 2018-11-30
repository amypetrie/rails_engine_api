class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices


  #find sum of invoice_items by merchant
    #sum(invoice_total(invoices).group_by merchant_id)
    #sort by invoice_total


  def self.top_merchants_by_revenue(quantity)
    Merchant
    .select("merchants.*, SUM(invoice_items.quantity*invoice_items.unit_price) as revenue")
    .joins(invoices: [:invoice_items, :transactions])
    .where(transactions: {result: "success"})
    .group(:id)
    .order("revenue desc")
    .limit(quantity)
  end

  def self.top_merchants_by_items_sold(quantity)
    Merchant
      .select("merchants.*, SUM(invoice_items.quantity) as total_items")
      .joins(invoices: [:invoice_items, :transactions])
      .where(transactions: {result: "success"})
      .group(:id)
      .order("total_items desc")
      .limit(quantity)
  end

end
