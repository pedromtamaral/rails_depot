class UpdateLineItemProductPrices < ActiveRecord::Migration
  def up
    LineItem.all.each do |item|
      item.update_attributes(:product_price => item.product.price) if item.product
    end
  end

  def down
    LineItem.all.each do |item|
      item.update_attributes(:product_price => nil)
    end
  end
end
