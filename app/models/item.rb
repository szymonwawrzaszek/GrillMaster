class Item < ApplicationRecord
  belongs_to :product
  belongs_to :cart

  def total_price
    if extra
      self.product.price*(quantity.to_i - 1)
    else
      self.product.price*quantity.to_i
    end
  end
end
