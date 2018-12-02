require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do
  describe "validations" do
    it {is_expected.to belong_to(:item)}
    it {is_expected.to belong_to(:invoice)}
  end

  describe "class methods" do
    xit ".revenue_for_date" do
      customer_1, customer_2, customer_3, customer_4, customer_5, customer_6 = create_list(:customer, 6)

      merchant_1, merchant_2, merchant_3, merchant_4, merchant_5, merchant_6 = create_list(:merchant, 6)

      date_2 = Date.today - 10.days

      invoice_1 = create(:invoice, merchant: merchant_1, customer: customer_1)
      invoice_2 = create(:invoice, merchant: merchant_2, customer: customer_2)
      invoice_3 = create(:invoice, merchant: merchant_3, customer: customer_3)
      invoice_4 = create(:invoice, merchant: merchant_4, customer: customer_4)
      invoice_5 = create(:invoice, merchant: merchant_5, customer: customer_5)
      invoice_6 = create(:invoice, merchant: merchant_6, customer: customer_6)

      item_1 = create(:item, merchant: merchant_1, unit_price: 100)
      item_2 = create(:item, merchant: merchant_2, unit_price: 5)
      item_3 = create(:item, merchant: merchant_3, unit_price: 200)
      item_4 = create(:item, merchant: merchant_4, unit_price: 10)
      item_5 = create(:item, merchant: merchant_5, unit_price: 500)
      item_6 = create(:item, merchant: merchant_6, unit_price: 20)

      transaction_1 = create(:transaction, invoice: invoice_1, result: "success", created_at: Date.today)
      transaction_2 = create(:transaction, invoice: invoice_2, result: "success", created_at: date_2)
      transaction_3 = create(:transaction, invoice: invoice_3, result: "success", created_at: date_2)
      transaction_4 = create(:transaction, invoice: invoice_4, result: "success", created_at: date_2)
      transaction_5 = create(:transaction, invoice: invoice_5, result: "success", created_at: Date.today)
      transaction_6 = create(:transaction, invoice: invoice_6, result: "success", created_at: Date.today)

      invoice_item_1 = create(:invoice_item, item: item_1, invoice: invoice_1, quantity: 1, unit_price: 100)
      invoice_item_2 = create(:invoice_item, item: item_2, invoice: invoice_2, quantity: 1, unit_price: 5)
      invoice_item_3 = create(:invoice_item, item: item_3, invoice: invoice_3, quantity: 1, unit_price: 200)
      invoice_item_4 = create(:invoice_item, item: item_4, invoice: invoice_4, quantity: 1, unit_price: 10)
      invoice_item_5 = create(:invoice_item, item: item_5, invoice: invoice_5, quantity: 1, unit_price: 500)
      invoice_item_6 = create(:invoice_item, item: item_6, invoice: invoice_6, quantity: 1, unit_price: 20)

      revenue = InvoiceItem.revenue_for_date(Date.today)

      expect(revenue).to eq 620
    end
  end
end
