class Api::V1::Invoices::SearchController < ApplicationController

  def show
    if search_params[:created_at]
      render json: InvoiceSerializer.new(Invoice.find_by(created_at: search_params[:created_at]))
    elsif search_params[:updated_at]
      render json: InvoiceSerializer.new(Invoice.find_by(updated_at: search_params[:updated_at]))
    elsif search_params[:merchant_id]
      render json: InvoiceSerializer.new(Invoice.find_by(merchant_id: search_params[:merchant_id]))
    elsif search_params[:customer_id]
      render json: InvoiceSerializer.new(Invoice.find_by(customer_id: search_params[:customer_id]))
    elsif search_params[:status]
      render json: InvoiceSerializer.new(Invoice.find_by(status: search_params[:status]))
    else
      render json: InvoiceSerializer.new(Invoice.find_by(id: search_params[:id]))
    end
  end

  def index
    if search_params[:created_at]
      render json: InvoiceSerializer.new(Invoice.where(created_at: search_params[:created_at]))
    elsif search_params[:updated_at]
      render json: InvoiceSerializer.new(Invoice.where(updated_at: search_params[:updated_at]))
    elsif search_params[:customer_id]
      render json: InvoiceSerializer.new(Invoice.where(customer_id: search_params[:customer_id]))
    elsif search_params[:merchant_id]
      render json: InvoiceSerializer.new(Invoice.where(merchant_id: search_params[:merchant_id]))
    elsif search_params[:status]
      render json: InvoiceSerializer.new(Invoice.where(status: search_params[:status]))
    else
      render json: InvoiceSerializer.new(Invoice.where(id: search_params[:id]))
    end
  end

private
  def search_params
    params.permit(:id, :created_at, :updated_at, :status, :customer_id, :merchant_id, :random)
  end
end
