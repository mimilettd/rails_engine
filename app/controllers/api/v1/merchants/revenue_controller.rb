class Api::V1::Merchants::RevenueController < ApplicationController

  def index
    render json: Merchant.top_earners(params[:quantity])
  end
end
