class DiscountsController < ApplicationController
  before_action :set_discount, only: [:update]

  # POST /discounts
  def create
    @discount = Discount.new(discount_params)

    if @discount.save
      redirect_to @discount, notice: 'Discount was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /discounts/1
  def update
    if @discount.update(discount_params)
      redirect_to @discount, notice: 'Discount was successfully updated.'
    else
      render :edit
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_discount
      @discount = Discount.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def discount_params
      params.require(:discount).permit(:kind, :name, :product_ids, :price)
    end
end
