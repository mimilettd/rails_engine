class Api::V1::Items::RevenueController < ApplicationController

  def index
    render json: Item.top_earners(params[:quantity])
  end
end
