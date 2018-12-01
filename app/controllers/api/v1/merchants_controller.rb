class Api::V1::MerchantsController < ApplicationController

  def index
    render json: MerchantSerializer.new(Merchant.all)
  end

  def show
    if params[:id] == "random"
      id = Merchant.pluck(:id).sample
      render json: MerchantSerializer.new(Merchant.find(id))
    else
      render json: MerchantSerializer.new(Merchant.find(params[:id]))
    end
  end

end
