class Api::V1::Merchants::ItemsController < ApplicationController
  def index
    render json: Merchant.most_items(param[:quantity])
  end
end
