class Api::V1::InvoicesController < ApplicationController

  def index
    render json: Invoice.all.select(:id, :customer_id, :merchant_id, :status)
  end

  def show
    render json: Invoice.find(params[:id])
  end
end
