class Api::V1::MerchantsController < ApplicationController

  def index
    render json: MerchantSerializer.new(Merchant.all)
  end

  def show
    if merchant_params[:id] == "random"
      id = Merchant.pluck(:id).sample
      render json: MerchantSerializer.new(Merchant.find(id))
    elsif merchant_params[:invoice_id]
      render json: MerchantSerializer.new(Merchant.joins(:invoices).find_by("invoices.id = ?", merchant_params[:invoice_id]))
    else
      render json: MerchantSerializer.new(Merchant.find(params[:id]))
    end
  end

private
  def merchant_params
    params.permit(:name, :id, :created_at, :updated_at, :random, :invoice_id)
  end
end
