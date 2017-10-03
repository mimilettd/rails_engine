class Api::V1::Invoices::SearhController < ApplicationController

  def index
    render json: Invoice.where(search_params)
  end

  def show
    render json: Invoice.find_by(search_params)
  end

  private

  def search_params
    params.require(:invoice).permit(:id, :customer_id, :merchant_id,
                                    :created_at, :updated_at, :status)
  end
end
