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

    ActiveRecord::Base.transaction do
      unless item.enough_stock?(amount)
        flash[:error] = I18n.t('cart.out_of_stock', name: item.name)
        raise ActiveRecord::Rollback
      end

      add_to_cart(item_id, amount)

      item.update!(stock: item.stock - amount)
    end

    flash[:notice] = I18n.t('cart.add_success')
    redirect_to request.referer || root_path
  rescue ActiveRecord::RecordInvalid, ActiveRecord::Rollback
    redirect_back fallback_location: root_path
  end

  def empty
    @cart = current_or_create_cart

    ActiveRecord::Base.transaction do
      @cart.cart_items.each do |cart_item|
        item = cart_item.item
        item.stock += cart_item.amount # 在庫数を元に戻す

        unless item.save
          flash[:error] = I18n.t('errors.cart_empty_error')
          raise ActiveRecord::Rollback
        end
      end

      @cart.cart_items.destroy_all
    end

    redirect_to cart_path(@cart)
  end

  private

  def add_to_cart(item_id, amount)
    cart_item = @cart.cart_items.find_by(item_id:)

    if cart_item
      cart_item.amount += amount
      cart_item.save!
    else
      @cart.cart_items.create!(item_id:, amount:)
    end
  end
end
