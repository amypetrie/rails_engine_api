class Api::V1::MerchantsController < ApplicationController

  def index
    render json: MerchantSerializer.new(Merchant.all)
  end

  def show
    if params[:id] == "random"
      ids = Merchant.pluck(:id)
      render json: MerchantSerializer.new(Merchant.where(id: ids.sample))
    else
      render json: MerchantSerializer.new(Merchant.find(params[:id]))
    end
  end

end
