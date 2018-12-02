class Api::V1::TransactionsController < ApplicationController

  def index
    if transaction_params[:customer_id]
      render json: TransactionSerializer.new(Transaction.by_customer(transaction_params[:customer_id]))
    else
      render json: TransactionSerializer.new(Transaction.all)
    end
  end

  def show
    if transaction_params[:id] == "random"
      id = Transaction.pluck(:id).sample
      render json: TransactionSerializer.new(Transaction.find(id))
    elsif params[:invoice]
      render json: TransactionSerializer.new(Transaction.find(params[:id]))
    else
      render json: TransactionSerializer.new(Transaction.find(params[:id]))
    end
  end

private
  def transaction_params
    params.permit(:credit_card_number, :id, :result, :invoice_id, :random, :customer_id)
  end
end
