class Api::V1::Invoices::MerchantController < ApplicationController
  def show
    render json: Invoice.find_by(params[:merchant_id])
  end
end
