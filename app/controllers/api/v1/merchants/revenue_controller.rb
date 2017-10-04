class Api::V1::Merchants::RevenueController < ApplicationController
  def show
    revenue = Merchant.total_revenue(filter)
    render json: revenue, :serializer => RevenueSerializer
  end

  private
  def filter
    params.permit(:id, :date)
  end
end
