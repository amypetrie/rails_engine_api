class Api::V1::Merchants::RevenueController < ApplicationController

  def index
    render json: MerchantSerializer.new(Merchant.top_merchants_by_revenue(params["quantity"]))
  end

  def show
    render json: InvoiceItemSerializer.new(InvoiceItem.revenue_for_date(params["date"])

private
  def revenue_params
    params.permit(:quantity, :date)
  end

end
