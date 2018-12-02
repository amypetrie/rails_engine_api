class Api::V1::Merchants::SearchController < ApplicationController

  def show
    if search_params[:name]
      render json: MerchantSerializer.new(Merchant.find_by("lower(name) = ?", search_params[:name].downcase))
    elsif
      render json: MerchantSerializer.new(Merchant.find_by(params[:id]))
    end
  end

  def index
    if search_params[:name]
      render json: MerchantSerializer.new(Merchant.where("lower(name) = ?", search_params[:name].downcase))
    else
      render json: MerchantSerializer.new(Merchant.where(search_params))
    end
  end

private
  def search_params
    params.permit(:name, :id, :created_at, :updated_at, :random)
  end

end
