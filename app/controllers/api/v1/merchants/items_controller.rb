class Api::V1::Merchants::ItemsController < ApplicationController

  def index
    render json: MerchantSerializer.new(Merchant.top_merchants_by_items_sold(quantity_params))
  end

  private
  def quantity_params
    params.require(:quantity)
  end
end
