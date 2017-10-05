class Api::V1::Transactions::InvoiceController < ApplicationController
  def show
    render json: Invoice.find(params[:id])
  end
end
