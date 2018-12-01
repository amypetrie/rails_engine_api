class Api::V1::Merchants::ItemsController < ApplicationController

  def index
    render json: MerchantSerializer.new(Merchant.top_merchants_by_items_sold(params["quantity"].to_i))
  end

  def item_params
    params.permit(:quantity, :date, :params)
  end

end
