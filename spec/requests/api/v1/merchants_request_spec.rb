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
      users = create_list(:merchant, 10)
      get "/api/v1/merchants/random"
      merchant = JSON.parse(response.body)

      expect(response).to be_successful
      expect(merchant["data"].count).to eq 1
    end

  end
