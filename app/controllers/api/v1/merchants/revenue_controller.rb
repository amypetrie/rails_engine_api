class Api::V1::Merchants::RevenueController < ApplicationController

  def index
      render json: MerchantSerializer.new(Merchant.top_merchants_by_revenue(params["quantity"]))
  end

private
  def revenue_params
    params.permit(:quantity, :date, :params)
  end

end
