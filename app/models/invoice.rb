class Invoice < ApplicationRecord
  belongs_to :customer
  belongs_to :merchant
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :transactions

  def invoice_total
    total = invoice_items.map do |ii|
      ii.invoice_item_revenue
    end
    total.sum
  end

  #havent tried in console
  def self.invoices_with_successful_transactions

  end

end
