class InvoiceSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :status, :customer_id, :merchant_id
  has_many :invoice_items
  has_many :items, through: :invoice_items
end
