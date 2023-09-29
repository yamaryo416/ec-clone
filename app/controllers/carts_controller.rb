class CartsController < ApplicationController

  def show
    @cart = current_or_create_cart
  end

  def add_item
    @cart = current_or_create_cart
    item_id = params[:item_id]
    amount = params[:amount]

    cart_item = @cart.cart_items.find_by(item_id: item_id)

    if cart_item
      cart_item.amount += amount.to_i
      cart_item.save
    else
      @cart.cart_items.create(item_id: item_id, amount: amount)
    end

    redirect_to request.referer || root_path
  end

  private

  def current_or_create_cart
    if session[:cart_id]
      Cart.find(session[:cart_id])
    else
      cart = Cart.create
      session[:cart_id] = cart.id
      cart
    end
  end
end
