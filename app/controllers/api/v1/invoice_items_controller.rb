class Api::V1::InvoiceItemsController < ApplicationController

  def index
    render json: InvoiceItemSerializer.new(InvoiceItem.all)
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
    params.permit(:name, :id, :created_at, :updated_at)
  end
end
