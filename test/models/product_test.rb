require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  
  def new_product(image_url)
    Product.new(title: "Lorem Ipsum",
                description: "a book about text",
                price: 1,
                image_url: image_url)
  end
  
  test "product attributes must not be empty" do
    product = Product.new
    assert product.invalid?
    assert product.errors[:title].any?
    assert product.errors[:description].any?
    assert product.errors[:image_url].any?
    assert product.errors[:price].any?
  end
  
  test "product price must be greater than 0" do
    product = Product.new(title: 'Lorem Ipsum',
      description: 'a tale of computer tests and games',
      image_url: 'testimage.jpg')
    product.price = -1
    assert product.invalid?
    assert_equal ["must be greater than or equal to 0.01"],
      product.errors[:price]
    
    product.price = 0
    assert product.invalid?
    assert_equal ["must be greater than or equal to 0.01"],
      product.errors[:price]
      
    product.price = 1
    assert product.valid?
  end
  
  test "valid image url" do
    ok = %w{ fred.gif fred.jpg fred.png fred.gIF FRED.JPG FRed.Png http://domain.com/a/b/c/fred.png}
    bad = %w{ fred.doc fred.gif/more fred.gif.more}
    ok.each do |name|
      assert new_product(name).valid?, "#{name} should work as image_url"
    end
    bad.each do |name|
      assert new_product(name).invalid?, "#{name} should not work as image_url"
    end
  end
  
  test "product names must be unique" do
    product = Product.new( title: products(:ruby).title,
                          description: "xyz",
                          price: 1,
                          image_url: "ruby.png")
    assert product.invalid?
    assert_equal ["has already been taken"], product.errors[:title]
  end                
  
end



