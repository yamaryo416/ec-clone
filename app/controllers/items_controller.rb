# frozen_string_literal: true

class ItemsController < ApplicationController
  before_action :set_item, only: %i[show]

  # GET /items
  def index
    @items = Item.all
  end

  # GET /items/1
  def show
    items = Item.all
    # 関連に自分自身を表示させないようにするため
    @item = Item.find(params[:id])
    @items_except_myself = items.reject { |item| item.id == @item.id }
  end

  # GET /items/new
  def new
    @item = Item.new
  end

  def create
    @item = Item.new(permit_params)
    @item.save
    redirect_to @item
  end  

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_item
    @item = Item.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def permit_params
    Rails.logger.debug :image
    params.require(:item).permit(:name, :description, :image, :price)
  end
end
