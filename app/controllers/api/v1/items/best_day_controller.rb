class Api::V1::Items::BestDayController < ApplicationController

  def index
    item = Item.find(params[:id])
    render json: {best_day: item.best_day}
  end
end
