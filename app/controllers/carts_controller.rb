class CartsController < ApplicationController
  before_action :authenticate_user, only: [:checkout]
  before_action :set_or_initialize_cart

  def add_to_cart
    cart_item = @cart.find { |ci| ci['product_id'] == params[:id] }
    if cart_item
      cart_item['quantity'] += 1
      flash[:success] = "Product Updated Successfully"
    else
      @cart.append(product_id: params[:id], quantity: 1)
      flash[:success] = "Product Added Successfully"
    end
    redirect_to request.referer
  end

  def view_cart; end

  def checkout
    order = current_user.orders.new
    @cart.each do |ci|
      order.order_items.new(ci)
    end
    order.save!
    session[:cart] = []
    flash[:success] = "Order Created Successfully"
    redirect_to root_path
  end

  private

  def cart_item_params
    params.permit(:product_id, :quantity)
  end

  def set_or_initialize_cart
    if session[:cart]
      @cart = session[:cart]
    else
      @cart = session[:cart] = []
    end
  end
end
