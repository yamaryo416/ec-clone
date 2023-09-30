# frozen_string_literal: true

class CartsController < ApplicationController
  before_action :set_is_admin

  def show
    @cart = current_or_create_cart
  end

  def add_item
    @cart = current_or_create_cart
    item_id = params[:item_id]
    amount = params[:amount].to_i

    item = Item.find(item_id)

    unless item_enough_stock?(item, amount)
      flash[:error] = "#{item.name} は在庫切れです"
      redirect_back(fallback_location: root_path)
      return
    end

    cart_item = @cart.cart_items.find_by(item_id:)

    if cart_item
      cart_item.amount += amount
      cart_item.save
    else
      @cart.cart_items.create(item_id:, amount:)
    end

    # アイテムの在庫をデクリメント
    item.update(stock: item.stock - amount)

    flash[:notice] = I18n.t('cart.add_success')
    redirect_to request.referer || root_path
  end

  def empty
    @cart = current_or_create_cart

    @cart.cart_items.each do |cart_item|
      item = cart_item.item
      item.stock += cart_item.amount # 在庫数を元に戻ため
      unless item.save
        flash[:error] = I18n.t('errors.cart_empty_error')
        redirect_to cart_path(@cart)
      end
    end

    @cart.cart_items.destroy_all
    redirect_to cart_path(@cart)
  end

  private

  def item_enough_stock?(item, amount)
    item.stock >= amount
  end
end
