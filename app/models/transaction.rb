class Transaction < ApplicationRecord
  belongs_to :invoice

  def self.by_customer(customer_id)
    Transaction.joins(invoice: :customer).where('customers.id = ?', customer_id)
  end

end
