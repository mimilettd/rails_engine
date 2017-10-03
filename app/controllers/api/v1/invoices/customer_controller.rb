class Api::V1::Invoices::CustomerController < ApplicationController
  def show
    render json: Invoice.find_by(params[:customer_id])
  end
end
