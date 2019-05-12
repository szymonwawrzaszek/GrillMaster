class DiscountsAddColumnCount < ActiveRecord::Migration[5.2]
  def change
      add_column :discounts, :count, :integer
  end
end
