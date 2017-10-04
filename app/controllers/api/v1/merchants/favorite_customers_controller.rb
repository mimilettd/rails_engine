class Api::V1::Merchants::FavoriteCustomersController < ApplicationController
  def show
    render json: Merchant.find(params[:id]).favorite_customer
  end
end
