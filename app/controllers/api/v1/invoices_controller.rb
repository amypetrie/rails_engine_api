class Api::V1::InvoicesController < ApplicationController

  def index
    if invoice_params[:merchant_id]
      render json: InvoiceSerializer.new(Invoice.where(merchant_id: invoice_params[:merchant_id]))
    elsif invoice_params[:customer_id]
      render json: InvoiceSerializer.new(Invoice.where(customer_id: invoice_params[:customer_id]))
    else
      render json: InvoiceSerializer.new(Invoice.all)
    end
  end

  def show
    if invoice_params[:transaction_id]
      render json: InvoiceSerializer.new(Invoice.joins(:transactions).find_by("transactions.id = ?", invoice_params[:transaction_id]))
    else
      render json: InvoiceSeriaizer.new(Invoice.find(params[:id]))
    end
  end

  def invoice_params
    params.permit(:id, :quantity, :created_at, :updated_at, :merchant_id, :customer_id, :transaction_id)
  end

end
