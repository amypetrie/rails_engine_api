class Api::V1::Merchants::SearchController < ApplicationController

  def show
    parameter = search_params.keys.first.to_sym unless search_params.keys.first == nil
    if parameter == :name
      render json: MerchantSerializer.new(Merchant.find_by("lower(name) = ?", search_params[parameter].downcase))
    else
      render json: MerchantSerializer.new(Merchant.find_by(parameter => search_params[parameter]))
    end
  end

  def index
    parameter = search_params.keys.first.to_sym unless search_params.keys.first == nil
    if parameter == :name
      render json: MerchantSerializer.new(Merchant.where("lower(name) = ?", search_params[parameter].downcase))
    elsif params[:params] == "random"
      ids = Merchant.pluck(:id)
      render json: MerchantSerializer.new(Merchant.where(id: ids.sample))
    else
      render json: MerchantSerializer.new(Merchant.where(parameter => search_params[parameter]))
    end
  end

private
  def search_params
    params.permit(:name, :id, :created_at, :updated_at, :random)
  end

end
