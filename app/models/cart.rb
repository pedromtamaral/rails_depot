class Cart < ActiveRecord::Base
  # attr_accessible :title, :body
  has_many :line_items, dependent: :destroy
  
  def add_product(product)
    item = line_items.find_by_product_id(product.id)
    if item
      item.quantity += 1
    else
      item = line_items.build(product_id: product.id, product_price: product.price)
    end
    item
  end
  
  def total_price
    line_items.to_a.sum { |item| item.total_price }
  end
end
