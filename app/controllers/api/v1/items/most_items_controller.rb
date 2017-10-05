class Api::V1::Items::MostItemsController < ApplicationController

  def index
    render json: Item.most_item(params[:quantity])
  end
end
