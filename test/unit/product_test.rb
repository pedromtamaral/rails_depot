require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  fixtures :products
  
  test "product attributes must not be empty" do
    product = Product.new
    assert product.invalid?
    assert product.errors[:title].any?
    assert product.errors[:description].any?
    assert product.errors[:price].any?
    assert product.errors[:image_url].any?
  end
  
  test "product price must be positive" do
    product = Product.new(title: "My Book Title", description: "yyy", image_url: "zzz.jpg")
    
    product.price = -1
    assert product.invalid?
    assert_equal "must be greater than or equal to 0.01", product.errors[:price].join("")
    
    product.price = 0
    assert product.invalid?
    assert_equal "must be greater than or equal to 0.01", product.errors[:price].join("")
    
    product.price = 1
    assert product.valid?
  end
  
  def new_product(image_url)
    Product.new(title: "My Book Title", description: "yyy", price: 1, image_url: image_url)
  end
  
  test "image url must have the right format" do
    good_formats = %w{ fred.gif fred.jpg fred.png FRED.JPG FRED.Jpg http://a.b.c/x/y/z/fred.gif }
    bad_formats = %w{ fred.doc fred.gif/more fred.gif.more }
    
    good_formats.each{ |format| assert new_product(format).valid?, "#{format} should be valid!" }
    bad_formats.each{ |format| assert new_product(format).invalid?, "#{format} should NOT be valid!" }
  end
  
  test "product is not valid without a unique title" do
    product = Product.new(title: products(:ruby).title, description: "yyy", price: 1, image_url: "fred.gif")
    assert !product.save
    assert_equal I18n.translate('activerecord.errors.messages.taken'), product.errors[:title].join('')
  end
  
  test "product name should have at least 10 characters" do
    product = Product.new(title: "Invalid", description: "yyy", price: 1, image_url: "fred.gif")
    assert product.invalid?
    assert_equal "is too short (minimum is 10 characters)", product.errors[:title].join("")
    
    product = Product.new(title: "A valid title", description: "yyy", price: 1, image_url: "fred.gif")
    assert product.valid?
  end
end
