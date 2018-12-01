class Api::V1::Merchants::SearchController < ApplicationController

  def show
    parameter = search_params.keys.first.to_sym unless search_params.keys.first == nil
    if parameter == :name
      render json: MerchantSerializer.new(Merchant.find_by("lower(name) = ?", search_params[parameter].downcase))
      #change data type of names to be downcased
    else
      render json: MerchantSerializer.new(Merchant.find_by(params)
      #changed this.
    end
  end

  def index
    binding.pry
    parameter = search_params.keys.first.to_sym unless search_params.keys.first == nil
    if parameter == :name
      render json: MerchantSerializer.new(Merchant.where("lower(name) = ?", search_params[parameter].downcase))
    else
      render json: MerchantSerializer.new(Merchant.where(parameter => search_params[parameter]))
    end
  end

private
  def search_params
    params.permit(:name, :id, :created_at, :updated_at, :random)
  end

end
