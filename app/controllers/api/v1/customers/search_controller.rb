class Api::V1::Customers::SearchController < ApplicationController

  def show
    if search_params[:first_name]
      render json: CustomerSerializer.new(Customer.find_by("lower(first_name) = ?", search_params[:first_name].downcase))
    elsif search_params[:last_name]
      render json: CustomerSerializer.new(Customer.find_by("lower(last_name) = ?", search_params[:last_name].downcase))
    elsif search_params[:created_at]
      render json: CustomerSerializer.new(Customer.find_by(created_at: search_params[:created_at]))
    elsif search_params[:updated_at]
      render json: CustomerSerializer.new(Customer.find_by(updated_at: search_params[:updated_at]))
    else
      render json: CustomerSerializer.new(Customer.find_by(search_params))
    end
  end

  def index
    if search_params[:first_name]
      render json: CustomerSerializer.new(Customer.where("lower(first_name) = ?", search_params[:first_name].downcase))
    elsif search_params[:last_name]
      render json: CustomerSerializer.new(Customer.where("lower(last_name) = ?", search_params[:last_name].downcase))
    elsif search_params[:created_at]
      render json: CustomerSerializer.new(Customer.where(created_at: search_params[:created_at]))
    elsif search_params[:updated_at]
      render json: CustomerSerializer.new(Customer.where(updated_at: search_params[:updated_at]))
    else
      render json: CustomerSerializer.new(Customer.where(search_params))
    end
  end

private
  def search_params
    params.permit(:first_name, :last_name, :id, :created_at, :updated_at, :random)
  end
end
