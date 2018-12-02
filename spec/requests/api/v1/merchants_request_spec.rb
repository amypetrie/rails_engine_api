require 'rails_helper'

  describe 'Merchants API' do
    it 'sends all merchants' do
      create_list(:merchant, 5)
      get "/api/v1/merchants"
      merchants = JSON.parse(response.body)

      expect(response).to be_successful
      expect(merchants["data"].count).to eq 5
    end

    it 'sends a merchant by id' do
      id = create(:merchant).id
      get "/api/v1/merchants/#{id}"
      merchant = JSON.parse(response.body)

      expect(response).to be_successful
      expect(merchant["data"]["attributes"]["id"]).to eq id
    end

    it 'sends a merchant by name' do
      name = create(:merchant).name
      get "/api/v1/merchants/find?name=#{name}"
      merchant = JSON.parse(response.body)

      expect(response).to be_successful
      expect(merchant["data"]["attributes"]["name"]).to eq name
    end

    it 'sends a merchant by created at' do
      date = "2012-03-27T14:54:02.000Z"
      user = create(:merchant, created_at: date)
      get "/api/v1/merchants/find?created_at=#{date}"
      merchant = JSON.parse(response.body)

      expect(response).to be_successful
      expect(merchant["data"]["attributes"]["id"]).to eq user.id
    end

    it 'sends a merchant by updated at' do
      date = "2012-03-27T14:54:02.000Z"
      user = create(:merchant, updated_at: date)
      get "/api/v1/merchants/find?updated_at=#{date}"
      merchant = JSON.parse(response.body)

      expect(response).to be_successful
      expect(merchant["data"]["attributes"]["id"]).to eq user.id
    end

    it 'sends all merchants by id' do
      id = create(:merchant).id
      get "/api/v1/merchants/#{id}"
      merchant = JSON.parse(response.body)

      expect(response).to be_successful
      expect(merchant["data"]["attributes"]["id"]).to eq id
    end

    it 'sends all merchants by name' do
      name = create_list(:merchant, 2, name: "Amy").first.name
      create_list(:merchant, 2)
      get "/api/v1/merchants/find_all?name=#{name}"
      merchants = JSON.parse(response.body)

      expect(response).to be_successful
      expect(merchants["data"].first["attributes"]["name"]).to eq name
      expect(merchants["data"].count).to eq 2
    end

    it 'sends all merchants by created at' do
      date = "2012-03-27T14:54:02.000Z"
      id = create(:merchant, created_at: date).id.to_s
      id_1 = create(:merchant, created_at: date).id.to_s
      id_2 = create(:merchant, created_at: date).id.to_s
      create_list(:merchant, 2)
      get "/api/v1/merchants/find_all?created_at=#{date}"
      merchants = JSON.parse(response.body)

      expect(response).to be_successful
      expect(merchants["data"].count).to eq 3
      expect(merchants["data"].first["id"]).to eq id
      expect(merchants["data"][1]["id"]).to eq id_1
      expect(merchants["data"][2]["id"]).to eq id_2
    end

    it 'sends all merchants by updated at' do
      date = "2012-03-27T14:54:02.000Z"
      id = create(:merchant, updated_at: date).id.to_s
      id_1 = create(:merchant, updated_at: date).id.to_s
      id_2 = create(:merchant, updated_at: date).id.to_s
      create_list(:merchant, 2)
      get "/api/v1/merchants/find_all?updated_at=#{date}"
      merchants = JSON.parse(response.body)

      expect(response).to be_successful
      expect(merchants["data"].count).to eq 3
      expect(merchants["data"].first["id"]).to eq id
      expect(merchants["data"][1]["id"]).to eq id_1
      expect(merchants["data"][2]["id"]).to eq id_2
    end

    it 'sends a random merchant' do
      merchants = create_list(:merchant, 10)
      get "/api/v1/merchants/random"
      merchant = JSON.parse(response.body)
      expect(response).to be_successful
      expect(merchant.count).to eq 1
    end

    it 'sends top merchants by revenue for quantity' do
      customer_1, customer_2, customer_3, customer_4, customer_5, customer_6 = create_list(:customer, 6)

      merchant_1, merchant_2, merchant_3, merchant_4, merchant_5, merchant_6 = create_list(:merchant, 6)

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

      invoice_item_1 = create(:invoice_item, item: item_1, invoice: invoice_1, quantity: 10, unit_price: 100)
      invoice_item_2 = create(:invoice_item, item: item_2, invoice: invoice_2, quantity: 5, unit_price: 5)
      invoice_item_3 = create(:invoice_item, item: item_3, invoice: invoice_3, quantity: 10, unit_price: 200)
      invoice_item_4 = create(:invoice_item, item: item_4, invoice: invoice_4, quantity: 5, unit_price: 10)
      invoice_item_5 = create(:invoice_item, item: item_5, invoice: invoice_5, quantity: 10, unit_price: 500)
      invoice_item_6 = create(:invoice_item, item: item_6, invoice: invoice_6, quantity: 5, unit_price: 20)

      transaction_1 = create(:transaction, invoice: invoice_1, result: "success")
      transaction_2 = create(:transaction, invoice: invoice_2, result: "success")
      transaction_3 = create(:transaction, invoice: invoice_3, result: "success")
      transaction_4 = create(:transaction, invoice: invoice_4, result: "success")
      transaction_5 = create(:transaction, invoice: invoice_5, result: "success")
      transaction_6 = create(:transaction, invoice: invoice_6, result: "success")

      get "/api/v1/merchants/most_revenue?quantity=5"
      merchants = JSON.parse(response.body)

      expect(response).to be_successful
      expect(merchants["data"].count).to eq 5
      expect(merchants["data"].first["id"].to_i).to eq merchant_5.id
      expect(merchants["data"].last["id"].to_i).to eq merchant_4.id
    end

    it "returns items associated with merchant" do
      merchant = create(:merchant)
      items = create_list(:item, 5, merchant: merchant)

      get "/api/v1/merchants/#{merchant.id}/items"
      items = JSON.parse(response.body)

      items["data"].each do |item|
        assert_equal (item["attributes"]["merchant_id"]), merchant.id
      end

      expect(response).to be_successful
    end

  it "returns invoices associated with merchant" do
    merchant = create(:merchant)
    customer = create(:customer)
    item_1, item_2, item_3 = create_list(:item, 3, merchant: merchant)
    invoice_1 = create(:invoice, merchant: merchant, customer: customer)
    invoice_2 = create(:invoice, merchant: merchant, customer: customer)
    invoice_3 = create(:invoice, merchant: merchant, customer: customer)

    get "/api/v1/merchants/#{merchant.id}/invoices"
    invoices = JSON.parse(response.body)

    invoices["data"].each do |invoice|
      assert_equal (invoice["attributes"]["merchant_id"]), merchant.id
    end
    expect(response).to be_successful
    expect(invoices["data"].count).to eq 3
  end

  it "returns top x merchants by items sold" do
    customer_1, customer_2, customer_3, customer_4, customer_5, customer_6 = create_list(:customer, 6)

    merchant_1, merchant_2, merchant_3, merchant_4, merchant_5, merchant_6 = create_list(:merchant, 6)

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

    invoice_item_1 = create(:invoice_item, item: item_1, invoice: invoice_1, quantity: 100, unit_price: 100)
    invoice_item_2 = create(:invoice_item, item: item_2, invoice: invoice_2, quantity: 5, unit_price: 5)
    invoice_item_3 = create(:invoice_item, item: item_3, invoice: invoice_3, quantity: 200, unit_price: 200)
    invoice_item_4 = create(:invoice_item, item: item_4, invoice: invoice_4, quantity: 10, unit_price: 10)
    invoice_item_5 = create(:invoice_item, item: item_5, invoice: invoice_5, quantity: 300, unit_price: 500)
    invoice_item_6 = create(:invoice_item, item: item_6, invoice: invoice_6, quantity: 15, unit_price: 20)

    transaction_1 = create(:transaction, invoice: invoice_1, result: "success")
    transaction_2 = create(:transaction, invoice: invoice_2, result: "success")
    transaction_3 = create(:transaction, invoice: invoice_3, result: "success")
    transaction_4 = create(:transaction, invoice: invoice_4, result: "success")
    transaction_5 = create(:transaction, invoice: invoice_5, result: "success")
    transaction_6 = create(:transaction, invoice: invoice_6, result: "success")

    get "/api/v1/merchants/most_items?quantity=5"
    merchants = JSON.parse(response.body)

    expect(response).to be_successful
    expect(merchants["data"].count).to eq 5
    expect(merchants["data"].first["id"].to_i).to eq merchant_5.id
    expect(merchants["data"].last["id"].to_i).to eq merchant_4.id
  end

  it "returns total revenue for x date across all merchants" do
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

    date_one        = "2012-03-16"
    get "/api/v1/merchants/revenue?date=#{date_one}"
    revenue = JSON.parse(response.body)

    expect(response).to be_successful
  end
end

# GET /api/v1/merchants/revenue?date=x returns the total revenue for date x across all merchants
