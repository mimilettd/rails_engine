class Api::V1::Merchants::RevenueController < ApplicationController
  def show
    render json: Merchant.total_revenue(filter)
  end

  private
  def filter
    params.permit(:id, :date)
  end
end
