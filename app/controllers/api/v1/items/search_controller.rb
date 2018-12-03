class Api::V1::Items::SearchController < ApplicationController

  def show
    if search_params[:created_at]
      render json: ItemSerializer.new(Item.find_by(created_at: search_params[:created_at]))
    elsif search_params[:updated_at]
      render json: ItemSerializer.new(Item.find_by(updated_at: search_params[:updated_at]))
    elsif search_params[:name]
      render json: ItemSerializer.new(Item.find_by(name: search_params[:name]))
    elsif search_params[:description]
      render json: ItemSerializer.new(Item.find_by(description: search_params[:description]))
    elsif search_params[:invoice_item_id]
      render json: ItemSerializer.new(Item.find_by(invoice_item_id: search_params[:invoice_item_id]))
    elsif search_params[:unit_price]
      render json: ItemSerializer.new(Item.find_by(unit_price: search_params[:unit_price]))
    elsif search_params[:merchant_id]
      render json: ItemSerializer.new(Item.find_by(merchant_id: search_params[:merchant_id]))
    else
      render json: ItemSerializer.new(Item.find_by(id: search_params[:id]))
    end
  end

  def index
    if search_params[:created_at]
      render json: ItemSerializer.new(Item.where(created_at: search_params[:created_at]))
    elsif search_params[:updated_at]
        render json: ItemSerializer.new(Item.where(updated_at: search_params[:updated_at]))
    elsif search_params[:name]
      render json: ItemSerializer.new(Item.where(name: search_params[:name]))
    elsif search_params[:invoice_id]
      render json: ItemSerializer.new(Item.where(invoice_id: search_params[:invoice_id]))
    elsif search_params[:invoice_item_id]
      render json: ItemSerializer.new(Item.where(invoice_item_id: search_params[:invoice_item_id]))
    elsif search_params[:unit_price]
      render json: ItemSerializer.new(Item.where(unit_price: price))
    elsif search_params[:merchant_id]
      render json: ItemSerializer.new(Item.where(merchant_id: search_params[:merchant_id]))
    elsif search_params[:description]
      render json: ItemSerializer.new(Item.where(description: search_params[:description]))
    else
      render json: ItemSerializer.new(Item.where(id: search_params[:id]))
    end
  end

private
  def search_params
    params.permit(:id, :created_at, :name, :invoice_id, :merchant_id, :unit_price, :quantity, :invoice_item_id, :description)
  end
end
