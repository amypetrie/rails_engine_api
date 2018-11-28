class Api::V1::Merchants::StatsController < ApplicationController

  def index
    render json: MerchantSerializer.new(Merchant.all)
  end

  def stats_params
    params.permit(:quantity, :date)
  end

end
