class Api::V1::Merchants::TotalRevenueController < ApplicationController

  def index
    revenue = Merchant.revenue_by_date(params[:date])
    render json: revenue, :serializer => TotalRevenueSerializer
  end
end
