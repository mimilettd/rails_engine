class Api::V1::Merchants::RevenueController < ApplicationController
  def index
    render json: Merchant.total_revenue(filter)
  end

  private
  def filter
    params.permit(:id, :date)
  end
end
