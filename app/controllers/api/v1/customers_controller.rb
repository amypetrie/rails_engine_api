class Api::V1::CustomersController < ApplicationController

  def index
    render json: CustomerSerializer.new(Customer.all)
  end

  def show
    if params[:id] == "random"
      id = Merchant.pluck(:id).sample
      render json: CustomerSerializer.new(Customer.find(id))
    elsif customer_params[:invoice_id]
      render json: CustomerSerializer.new(Customer.joins(:invoices).find_by("invoices.id = ?", customer_params[:invoice_id].to_i))
    else
      render json: CustomerSerializer.new(Customer.find(params[:id]))
    end
  end

  def customer_params
    params.permit(:first_name, :last_name, :created_at, :updated_at, :customer_id, :invoice_id)
  end

end
