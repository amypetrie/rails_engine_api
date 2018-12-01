class CustomerSerializer
  include FastJsonapi::ObjectSerializer
  attributes :first_name, :last_name, :id
  has_many :invoices
end
