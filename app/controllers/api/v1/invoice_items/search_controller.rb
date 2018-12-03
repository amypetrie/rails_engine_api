class Api::V1::InvoiceItems::SearchController < ApplicationController

  def show
    if search_params[:created_at]
      render json: InvoiceItemSerializer.new(InvoiceItem.find_by(created_at: search_params[:created_at]))
    elsif search_params[:updated_at]
      render json: InvoiceItemSerializer.new(InvoiceItem.find_by(updated_at: search_params[:updated_at]))
    elsif search_params[:item_id]
      render json: InvoiceItemSerializer.new(InvoiceItem.find_by(item_id: search_params[:item_id]))
    elsif search_params[:invoice_id]
      render json: InvoiceItemSerializer.new(InvoiceItem.find_by(invoice_id: search_params[:invoice_id]))
    elsif search_params[:unit_price]
      render json: InvoiceItemSerializer.new(InvoiceItem.find_by(unit_price: search_params[:unit_price]))
    elsif search_params[:quantity]
      render json: InvoiceItemSerializer.new(InvoiceItem.find_by(quantity: search_params[:quantity]))
    else
      render json: InvoiceItemSerializer.new(InvoiceItem.find_by(id: search_params[:id]))
    end
  end

  def index
    if search_params[:created_at]
      render json: InvoiceItemSerializer.new(InvoiceItem.where(created_at: search_params[:created_at]))
    elsif search_params[:updated_at]
      render json: InvoiceItemSerializer.new(InvoiceItem.where(updated_at: search_params[:updated_at]))
    elsif search_params[:invoice_id]
      render json: InvoiceItemSerializer.new(InvoiceItem.where(invoice_id: search_params[:invoice_id]))
    elsif search_params[:item_id]
      render json: InvoiceItemSerializer.new(InvoiceItem.where(item_id: search_params[:item_id]))
    elsif search_params[:unit_price]
      price = (search_params[:unit_price] * 100)
      render json: InvoiceItemSerializer.new(InvoiceItem.where(unit_price: price))
    elsif search_params[:quantity]
      render json: InvoiceItemSerializer.new(InvoiceItem.where(quantity: search_params[:quantity]))
    else
      render json: InvoiceItemSerializer.new(InvoiceItem.where(id: search_params[:id]))
    end
  end

private
  def search_params
    params.permit(:id, :created_at, :updated_at, :invoice_id, :item_id, :unit_price, :quantity)
  end
end
