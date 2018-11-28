class Api::V1::Merchants::SearchController < ApplicationController

  def show
    parameter = search_params.keys.first.to_sym
    if parameter == :name
      render json: MerchantSerializer.new(Merchant.find_by("lower(name) = ?", search_params[parameter].downcase))
    else
      render json: MerchantSerializer.new(Merchant.find_by(parameter => search_params[parameter]))
    end
  end

  def index

  end

  def search_params
    params.permit(:name, :id, :created_at, :updated_at)
  end

end
