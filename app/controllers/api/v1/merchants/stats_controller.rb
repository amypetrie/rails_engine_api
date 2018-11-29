class Api::V1::Merchants::StatsController < ApplicationController

  def index
    if params["params"].first == "most_revenue"
      render json: MerchantSerializer.new(Merchant.top_merchants_by_revenue(params["quantity"]))
    else
    end
  end

  def stats_params
    params.permit(:quantity, :date, :params)
  end

end

# /api/v1/merchants/most_revenue?quantity=x
