class Api::V1::TransactionsController < ApplicationController

  def index
    render json: TransactionSerializer.new(Transaction.all)
  end

  def show
    if transaction_params[:id] == "random"
      id = Transaction.pluck(:id).sample
      render json: TransactionSerializer.new(Transaction.find(id))
    else
      render json: TransactionSerializer.new(Transaction.find(params[:id]))
    end
  end

private
  def transaction_params
    params.permit(:credit_card_number, :id, :result, :invoice_id, :random)
  end
end
