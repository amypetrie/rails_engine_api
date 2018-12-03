class Api::V1::Transactions::SearchController < ApplicationController

  def show
    if search_params[:invoice_id]
      render json: TransactionSerializer.new(Transaction.find_by(invoice_id: search_params[:invoice_id]))
    elsif search_params[:created_at]
      render json: TransactionSerializer.new(Transaction.find_by(created_at: search_params[:created_at]))
    elsif search_params[:updated_at]
      render json: TransactionSerializer.new(Transaction.find_by(updated_at: search_params[:updated_at]))
    elsif params[:id]
      render json: InvoiceSerializer.new(Invoice.joins(:transactions).find_by("transactions.id = ?", params[:id].to_i))
    else
      render json: TransactionSerializer.new(Transaction.find_by(search_params))
    end
  end

  def index
    if search_params[:invoice_id]
      render json: TransactionSerializer.new(Transaction.where(invoice_id: search_params[:invoice_id]))
    elsif search_params[:created_at]
      render json: TransactionSerializer.new(Transaction.where(created_at: search_params[:created_at]))
    elsif search_params[:updated_at]
      render json: TransactionSerializer.new(Transaction.where(updated_at: search_params[:updated_at]))
    elsif search_params[:result]
      render json: TransactionSerializer.new(Transaction.where(result: search_params[:result]))
    elsif search_params[:credit_card_number]
      render json: TransactionSerializer.new(Transaction.where(credit_card_number: search_params[:credit_card_number]))
    else
      render json: TransactionSerializer.new(Transaction.where(search_params))
    end
  end

private
  def search_params
    params.permit(:invoice_id, :id, :created_at, :updated_at, :result, :credit_card_number, )
  end
end
