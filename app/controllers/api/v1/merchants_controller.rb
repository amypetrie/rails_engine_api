class Api::V1::MerchantsController < ApplicationController

  def index
    if params["random"] == "random"
    ids = Merchant.pluck(:id)
    render json: MerchantSerializer.new(Merchant.where(id: ids.sample))
    else
    render json: MerchantSerializer.new(Merchant.all)
    end
  end

  def show
    render json: MerchantSerializer.new(Merchant.find(params[:id]))
  end

end
