class Product < ActiveRecord::Base
	
	
validates :title, :description, :image_url, presence: true
#validates :price, numericality: {greater_than_or_equal_to: 0.01}
validates :price, numericality: {greater_than_or_equal_to: 0.05}
validates :price, format: {
	with: 		%r{\A[\d]*\.[\d][05]\z},
	#with: 		%r{^\d*\.\d[5]?$},
	message:	'Betrag muss auf 5 Rappen gerundet sein!'
}
validates :title, uniqueness: true
validates :image_url, allow_blank: true, format: {
	with:		%r{\.(gif|jpg|png)\Z}i,
	message: 	'Es muss sich um eine Bild-Url im Format GIF, JPG oder PNG handeln!'
}

end	
