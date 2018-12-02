class Api::V1::InvoicesController < ApplicationController

  def index
    if invoice_params[:merchant_id]
      render json: InvoiceSerializer.new(Invoice.where(merchant_id: invoice_params[:merchant_id]))
    else
      render json: InvoiceSerializer.new(Invoice.all)
    end
  end

  def show
    render json: InvoiceSeriaizer.new(Invoice.find(params[:id]))
  end

  def invoice_params
    params.permit(:id, :quantity, :created_at, :updated_at:, :merchant_id)
  end

end
