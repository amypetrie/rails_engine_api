class InvoiceItemSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :quantity, :unit_price, :created_at, :updated_at
  belongs_to :invoice
  belongs_to :item
end
