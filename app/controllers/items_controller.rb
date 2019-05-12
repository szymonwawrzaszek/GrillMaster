class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :update]
  before_action :set_cart



  # POST /items
  def create
    quantity = params[:quantity].values.first
    if quantity > 0
    product = Product.find(params[:product_id])
    @item = @cart.add_product(product, quantity)

      if @item.save
        #render json: @cart.items
        redirect_to carts_url
      else
        render json: @item.errors, status: :unprocessable_entity
      end
    else
      redirect_to carts_url
    end
  end

  # PATCH/PUT /items/1
  def update
    if item_params[:quantity].to_i <= 0
      @item.destroy
      #return render json: @cart.items
      return  redirect_to carts_url
    end
    if @item.update(item_params)
      redirect_to carts_url
      #render json: @item
    else
      render json: @item.errors, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = Item.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def item_params
      params.require(:item).permit(:product_id, :cart_id, :quantity)
    end

    def set_cart
      @cart = Cart.first
    end
end
