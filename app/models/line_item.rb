class LineItem < ActiveRecord::Base
  attr_accessible :cart_id, :product_id, :product, :quantity, :product_price
  belongs_to :product
  belongs_to :cart
  
  def total_price
    quantity * product_price
  end
end
