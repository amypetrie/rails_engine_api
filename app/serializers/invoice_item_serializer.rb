class InvoiceItemSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :quantity, :unit_price, :created_at, :updated_at, :invoice_id, :item_id
end
