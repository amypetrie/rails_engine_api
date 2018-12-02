class Api::V1::ItemsController < ApplicationController

  def index
    if item_params[:merchant_id]
      render json: ItemSerializer.new(Item.where(merchant_id: item_params[:merchant_id]))
    else
      render json: ItemSerializer.new(Item.all)
    end
  end

  def show
    render json: ItemSerializer.new(Item.find(params[:id]))
  end

  def item_params
    params.permit(:name, :id, :created_at, :upated_at, :quantity, :date, :merchant_id)
  end

end
