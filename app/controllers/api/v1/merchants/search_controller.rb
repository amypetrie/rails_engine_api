class Api::V1::Merchants::SearchController < ApplicationController

  def index
    if search_params[:name]
      render json: MerchantSerializer.new(Merchant.where("lower(name) = ?", search_params[:name].downcase))
    elsif search_params[:id]
      render json: MerchantSerializer.new(Merchant.where(id: search_params[:id]))
    elsif search_params[:created_at]
      render json: MerchantSerializer.new(Merchant.where(created_at: search_params[:created_at]))
    elsif search_params[:updated_at]
      render json: MerchantSerializer.new(Merchant.where(updated_at: search_params[:updated_at]))
    end
  end

  def show
    if search_params[:name]
      render json: MerchantSerializer.new(Merchant.find_by("lower(name) = ?", search_params[:name].downcase))
    elsif search_params[:id]
      render json: MerchantSerializer.new(Merchant.find_by(id: search_params[:id]))
    elsif search_params[:created_at]
      render json: MerchantSerializer.new(Merchant.find_by(created_at: search_params[:created_at]))
    elsif search_params[:updated_at]
      render json: MerchantSerializer.new(Merchant.find_by(updated_at: search_params[:updated_at]))
    end
  end

private
  def search_params
    params.permit(:name, :id, :created_at, :updated_at)
  end

end
