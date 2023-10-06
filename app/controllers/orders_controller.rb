# frozen_string_literal: true

class OrdersController < ApplicationController
  
  skip_before_action :verify_authenticity_token

  def index
    @orders = Order.all.includes(:billing_address)
  end

  def show
    @order = Order.includes(:order_items, :billing_address, :payment).find(params[:id])
    @total_price = @order.order_items.map { |item| item.price * item.amount }.sum
  end
  

  def create
    @user = User.create(session_id: session.id)
    @order = Order.new(order_params.merge(user: @user))
    if params[:order][:order_items_attributes]
      params[:order][:order_items_attributes].each_value do |order_item_data|
        item = Item.find(order_item_data[:item_id])
        order_item = @order.order_items.build
        order_item.price = item.price
        order_item.item_id = order_item_data[:item_id].to_i
        order_item.amount = order_item_data[:amount].to_i
      end
    end
    deduct_inventory_and_clear_cart
    if @order.save
      flash[:info] = '購入ありがとうございます'
      redirect_to root_path
    else
      flash[:error] = @order.errors.full_messages
      redirect_to root_path
    end
  end

  private
  
  def order_params
    params.require(:order).permit(
      billing_address_attributes: [:first_name, :last_name, :username, :email, :country ,:prefecture, :post_code, :address, :address_2], 
      payment_attributes: [:name_on_card, :credit_card_number, :expiration_date, :cvv],
    )
  end

  def deduct_inventory_and_clear_cart
    @cart = current_or_create_cart
    ActiveRecord::Base.transaction do
      @cart.cart_items.each do |cart_item|
        item = cart_item.item
        item.stock -= cart_item.amount # 在庫数を減少
  
        unless item.save
          flash[:error] = I18n.t('errors.purchase_error')
          raise ActiveRecord::Rollback
        end
      end
      @cart.cart_items.destroy_all
    end
  
    # ...
  end
  

end