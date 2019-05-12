class Cart < ApplicationRecord
  has_many :items, dependent: :destroy

  def add_product(product, quantity)
    current_item = items.find_by(product_id: product.id)
    if current_item
      if quantity.empty?
        current_item.increment(:quantity)
      else
      current_item.quantity = quantity.to_i
      end
    else
      current_item = items.build(product_id: product.id, quantity: quantity)
    end
    current_item
  end

  def total_price
    discounts = Discount.all
    not_prom = copy(items)

    ### zniżka do promocji "extra"
    prom = []
    not_prom.each do
      |x| discounts.each do |y|
        if(y.kind =="extra"&&y.product_ids.include?(x.product.id)&&x.quantity >=(y.count + 1))
             times = (x.quantity/(y.count + 1)).to_i
             a = x.quantity
             x.quantity = y.count*times
             prom << copy(x)
             x.quantity = a - (y.count + 1 )*times
        end
      end
    end

    ### zniżka do promocji "set" ( nie dokończona)
    if false
      prom_2 = []
      not_prom.each do
      |x| discounts.each do |y|
          if(y.kind =="set"&&y.product_ids.include?(x.product.id)&&x.quantity >= 1)
            x.quantity -=1 ### tylko w przypadku, gdy cała tablica id_produktów discount zawiera się w tablicą id_produktów items
            prom_2 << x
          else
            prom_2 = []
            break
          end
        end
        ### uwzględnienie pojedyńczej zniżki set w cenie
        prom_2 = []
      end
    end

    ### scalenie tablic prom i prom_2

    ### cena całkowita bez zniżek
    # return items.sum { |item| item.product.price*item.quantity.to_i }.round(2)

    ### cena ze zniżkami
    (not_prom.sum { |item| item.product.price*item.quantity.to_i }.round(2) +
        prom.sum { |item| item.product.price*(item.quantity.to_i ) }).round(2)
  end
  def copy x
    Marshal.load(Marshal.dump(x))
  end
end

