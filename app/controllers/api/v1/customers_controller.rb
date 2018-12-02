class Api::V1::CustomersController < ApplicationController

  def index
    render json: CustomerSerializer.new(Customer.all)
  end

  def show
    if params[:id] == "random"
      id = Merchant.pluck(:id).sample
      render json: CustomerSerializer.new(Customer.find(id))
    else
      render json: CustomerSerializer.new(Customer.find(params[:id]))
    end
  end

end
