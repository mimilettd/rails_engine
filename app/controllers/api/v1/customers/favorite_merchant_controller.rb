class Api::V1::Customers::FavoriteMerchantController < ApplicationController

  respond_to :json

  swagger_controller :favorite_merchant, 'Favorite Merchant'

  swagger_api :show do
    summary 'Returns merchant that a certain customer shopped at most.'
  end

  def show
    customer = Customer.find(params[:id])
    render json: customer.favorite_merchant
  end
end
