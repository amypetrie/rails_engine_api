require 'time'
class Api::V1::Merchants::RevenueController < ApplicationController

  def index
    # binding.pry
    render json: MerchantSerializer.new(Merchant.top_merchants_by_revenue(revenue_params[:quantity]))
  end

  def show
    # binding.pry
    if revenue_params[:date]
      render json: InvoiceItemSerializer.new(InvoiceItem.revenue_for_date(revenue_params[:date]))
    else
    end
  end

  private
  def revenue_params
    params.permit(:quantity, :date)
  end

end
