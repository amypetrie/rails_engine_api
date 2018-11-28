class Transaction < ApplicationRecord
  belongs_to :invoice

  def self.successful_transactions
    Transaction.where(result: "success")
  end

  def self.successful_invoice_ids
    Transaction.successful_transactions.map {|t| t.invoice_id}
  end


end
