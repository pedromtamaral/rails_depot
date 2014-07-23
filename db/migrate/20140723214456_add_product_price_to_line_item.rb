class AddProductPriceToLineItem < ActiveRecord::Migration
  def change
    add_column :line_items, :product_price, :integer
  end
end
