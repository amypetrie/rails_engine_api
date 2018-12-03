require 'time'
class Api::V1::Merchants::RevenueController < ApplicationController

  def index
    if quantity_params
    render json: MerchantSerializer.new(Merchant.top_merchants_by_revenue(quantity_params))
    end
  end

  def show
    if date_params
      render json: InvoiceItemSerializer.new(InvoiceItem.revenue_for_date(date_params))
    end
  end

  private
    def quantity_params
      params.require(:quantity)
    end

    def date_params
      params.require(:date)
    end

end
