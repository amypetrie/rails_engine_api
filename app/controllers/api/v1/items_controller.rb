class Api::V1::ItemsController < ApplicationController

  def index
    if item_params[:merchant_id]
      render json: ItemSerializer.new(Item.where(merchant_id: item_params[:merchant_id]))
    elsif item_params[:invoice_id]
      render json: ItemSerializer.new(Item.joins(:invoice_items).where("invoice_items.invoice_id = ?", item_params[:invoice_id]))
    else
      render json: ItemSerializer.new(Item.all)
    end
  end

  def show
    if item_params[:invoice_item_id]
      render json: ItemSerializer.new(Item.joins(:invoice_items).find_by("invoice_items.id = ?", item_params[:invoice_item_id]))
    else
      render json: ItemSerializer.new(Item.find(params[:id]))
    end
  end

  def item_params
    params.permit(:name, :id, :created_at, :upated_at, :quantity, :date, :merchant_id, :invoice_id, :invoice_item_id)
  end

end
