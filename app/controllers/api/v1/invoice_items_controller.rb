class Api::V1::InvoiceItemsController < ApplicationController

  def index
    if invoice_item_params[:invoice_id]
      render json: InvoiceItemSerializer.new(InvoiceItem.where(invoice_id: invoice_item_params[:invoice_id]))
    elsif invoice_item_params[:item_id]
      render json: InvoiceItemSerializer.new(InvoiceItem.where(item_id: invoice_item_params[:item_id]))
    else
    render json: InvoiceItemSerializer.new(InvoiceItem.all)
    end
  end

  def show
    if invoice_item_params[:id] == "random"
      id = InvoiceItem.pluck(:id).sample
      render json: InvoiceItemSerializer.new(InvoiceItem.find(id))
    else
      render json: InvoiceItemSerializer.new(InvoiceItem.find(params[:id]))
    end
  end

private
  def invoice_item_params
    params.permit(:name, :id, :created_at, :updated_at, :invoice_id, :item_id)
  end
end
