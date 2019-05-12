class CartsController < ApplicationController
  before_action :set_cart, only: [:show]

  # GET /carts/1
  def show
    @items = @cart.items
    @discounts = Discount.all
  end

  private
    def set_cart
      @cart = Cart.first
    end
end
