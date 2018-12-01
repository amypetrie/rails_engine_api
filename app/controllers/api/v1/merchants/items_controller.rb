class Api::V1::Merchants::ItemsController < ApplicationController

  def index
    render json: MerchantSerializer.new(Merchant.top_merchants_by_items_sold(params[:quantity]))
  end
  
end
