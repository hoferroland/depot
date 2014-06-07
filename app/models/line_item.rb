class LineItem < ActiveRecord::Base
  belongs_to :order # Buch Kapitel 12.1 Seite 167
  belongs_to :product
  belongs_to :cart

   def total_price
     product.price * quantity
   end
end