require 'test_helper'

class CartTest < ActiveSupport::TestCase
  test "if you add a product it has a quantity of 1" do
    product_id = products(:ruby).id
    cart = Cart.create
    line_item = cart.add_product(product_id)

    assert_equal product_id, line_item.product_id
    assert_equal 1, line_item.quantity
  end

  test "if you add a product a second one it has quantity of 2" do
    product_id = products(:ruby).id
    cart = Cart.create
    cart.add_product(product_id)
    cart.save!
    line_item = cart.add_product(product_id)

    assert_equal product_id, line_item.product_id
    assert_equal 2, line_item.quantity
  end
end
