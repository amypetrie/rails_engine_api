require 'rails_helper'

  describe 'Merchants API' do
    it 'sends list of merchants' do
      create_list(:merchant, 5)
      get "/api/v1/merchants"
      merchants = JSON.parse(response.body)

      expect(response).to be_successful
      expect(merchants["data"].count).to eq 5
    end

    it 'sends a merchant' do
      id = create(:merchant).id
      get "/api/v1/merchants/#{id}"
      merchant = JSON.parse(response.body)

      expect(response).to be_successful
      expect(merchant["data"]["attributes"]["id"]).to eq id
    end

    it 'sends a merchant by id' do
      id = create(:merchant).id
      get "/api/v1/merchants/find?id=#{id}"
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
      expect(merchant["data"]["attributes"]["created_at"]).to eq date
    end

    it 'sends a merchant by updated at' do
      date = "2012-03-27T14:54:02.000Z"
      user = create(:merchant, updated_at: date)
      get "/api/v1/merchants/find?updated_at=#{date}"
      merchant = JSON.parse(response.body)

      expect(response).to be_successful
      expect(merchant["data"]["attributes"]["updated_at"]).to eq date
    end

  end
