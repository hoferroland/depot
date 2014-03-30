class Product < ActiveRecord::Base
	
	
validates :title, :description, :image_url, presence: true
validates :price, numericality: {greater_than_or_equal_to: 0.05}
#validates :price, format: {
#	with: 		%r{\A[\d]*\.[\d][05]\z},
#	message:	'Betrag muss auf 5 Rappen gerundet sein!'
#}
validate :validate_price

validates :title, uniqueness: true
validates :image_url, allow_blank: true, format: {
	with:		%r{\.(gif|jpg|png)\Z}i,
	message: 	'Es muss sich um eine Bild-Url im Format GIF, JPG oder PNG handeln!'
}

def validate_price
    return if self.price.blank?
	p = self.price.to_s
	return if p =~ %r{\A[\d]*\.[\d][05]?\z}
	errors.add(:price, "Betrag muss auf 5 Rappen gerundet sein!")
end

def self.latest
  Product.order(:updated_at).last
end

end	
