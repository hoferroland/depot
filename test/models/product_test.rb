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
    product = Product.new(title:		"My Book Title",
						  description:  "yyy",
						  image_url:    "zzz.jpg")
	product.price = -1.00
	assert product.invalid?
	assert_match "must be greater than or equal to 0.05", 
	  product.errors[:price].join('; ')
	
	product.price = 0.00
	assert product.invalid?
	assert_match "must be greater than or equal to 0.05", 
	  product.errors[:price].join('; ')
		
	product.price = 1.00
	assert product.valid?
  end
  
  test "product price must be x.x0 or x.x5" do
	product = Product.new(title:		"My Book Title2",
						  description:	"yyy2",
						  price:		1.07,
						  image_url:	"xxx2.jpg")
	
	product.valid?
	assert_match "Betrag muss auf 5 Rappen gerundet sein!",
	  product.errors[:price].join('; ')
  end
  
  def new_product(image_url)
    Product.new(title:		"My Book Title",
				description: "yyy",
				price:		1.00,
				image_url:	image_url)
  end
  
  test "image_url" do
    ok = %w{ fred.gif fred.jpg fred.png FRED.JPG FRED.Jpg http://a.b.c/x/y/z/fred.gif }
	bad = %w{ fred.doc fred.gif/more fred.gif.more}
	
	ok.each do |name|
		assert new_product(name).valid?, "#{name} should be valid"
	end
	
	bad.each do |name|
	  assert new_product(name).invalid?, "#{name} shouldn't be valid"
	end
  end
  
  test "product is not valid without a unique title" do
    product = Product.new(title:		products(:ruby).title,
						  description:	"yyy",
						  price:		1.00,
						  image_url:	"fred.gif")
	
	assert product.invalid?
	assert_match "has already been taken", product.errors[:title].join('; ')
  end
  
  test "product is not valid without a unique title - i18n" do
    product = Product.new(title:			products(:ruby).title,
						  description:		"yyy",
						  price:			1,
						  image_url:		"fred.gif")
	assert product.invalid?
	assert_match "has already been taken",
				 product.errors[:title].join('; ')
  end
 # test "product price must be positive" do
#	product = Product.new(title:	"TestProduct",
#						  description: "There is only a Test Product - not for sale!",
#						  image_url: "Testimage.png")
#						  
#	product.price = 2.01
#	assert product.invalid?
#	assert_equal ["Price must be greater than or equal to 0.05"],
#	  		product.errors[:price].join('; ')
#	assert_equal ["Betrag muss auf 5 Rappen gerundet sein!"],
#			product.errors[:price].join
 # end
  # test "the truth" do
  #   assert true
  # end
end
