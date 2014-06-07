require 'test_helper'

class OrdersControllerTest < ActionController::TestCase
  setup do
    @order = orders(:one)
  end

  test "requires item in cart" do  # Buch Kap 12.1 Seite 161
    get :new
	assert_redirected_to store_path
	assert_equal flash[:notice], 'Your cart is empty'
  end
  
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:orders)
  end

  test "should get new" do
    item = LineItem.new  # Buch Kap 12.1 Seite 161
	item.build_cart  # Buch Kap 12.1 Seite 161
	item.product = products(:ruby)  # Buch Kap 12.1 Seite 161
	item.save!  # Buch Kap 12.1 Seite 161
	session[:cart_id] = item.cart.id  # Buch Kap 12.1 Seite 161
    get :new
    assert_response :success
  end

  test "should create order" do
    assert_difference('Order.count') do
      post :create, order: { address: @order.address, email: @order.email, name: @order.name, pay_type: @order.pay_type }
    end

    assert_redirected_to store_path   # Buch Kap 12.1 Seite 168
  end

  test "should show order" do
    get :show, id: @order
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @order
    assert_response :success
  end

  test "should update order" do
    patch :update, id: @order, order: { address: @order.address, email: @order.email, name: @order.name, pay_type: @order.pay_type }
    assert_redirected_to order_path(assigns(:order))
  end

  test "should destroy order" do
    assert_difference('Order.count', -1) do
      delete :destroy, id: @order
    end

    assert_redirected_to orders_path
  end
end
