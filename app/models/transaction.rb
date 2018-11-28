class Transaction < ApplicationRecord
  belongs_to :invoice

  def self.successful_transactions
    Transaction.where(result: "success")
  end

end
