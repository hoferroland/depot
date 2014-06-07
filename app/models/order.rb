class Order < ActiveRecord::Base
  has_many :line_items, dependent: :destroy  # Buch Kapitel 12.1 Seite 167
  PAYMENT_TYPES = [ "Check", "Credit card", "Purchase order" ]
  
  # Buch Kapitel 12.1 Seite 166
  validates :name, :address, :email, presence: true
  validates :pay_type, inclusion: PAYMENT_TYPES
  
  def add_line_items_from_cart(cart) # Buch Kap 12.1 Seite 168
    cart.line_items.each do |item|
	  item.cart_id = nil
	  line_items << item
	end
  end
end
