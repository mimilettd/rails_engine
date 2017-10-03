class Api::V1::ItemsController < ApplicationRecord

  def index
    render json: Item.all.select(:id, :name, :description, :merchant_id,
                                :created_at, :updated_at, :unit_price)
  end

  def show
    render json: Item.find(params[:id])
  end
end
