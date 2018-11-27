require 'rails_helper'

  describe 'Merchants API' do
    it 'sends list of merchants' do
      create_list(:merchant, 5)

      get "/api/v1/merchants.json"
      merchants = JSON.parse(response.body)

      expect(response).to be_successful
      expect(merchants.count).to eq 5
    end

    it 'sends a merchant' do
      id = create(:merchant).id

      get "/api/v1/merchants/#{id}"
      merchant = JSON.parse(response.body)

      expect(response).to be_successful
      expect(merchant["id"]).to eq id
    end

    it 'sends a merchant by id' do
      id = create(:merchant).id

      get "/api/v1/merchants/find?id=#{id}"
      merchant = JSON.parse(response.body)

      expect(response).to be_successful
      expect(merchant["id"]).to eq id
    end

  end
