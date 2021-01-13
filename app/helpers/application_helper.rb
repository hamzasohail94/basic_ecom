module ApplicationHelper

  def items_present_in_cart
    session[:cart].present? && session[:cart].any?
  end

  def find_product product_id
    Product.find(product_id)
  end

end
