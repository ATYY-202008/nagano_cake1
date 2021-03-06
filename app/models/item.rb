class Item < ApplicationRecord
  has_many :cart_items, dependent: :destroy
  has_many :order_details, dependent: :destroy
  belongs_to :genre,optional: true
  attachment :image

  	def self.search(search, word)
		@item_search = Item.where("name LIKE?","%#{word}%")
	end

	validates :name,presence: true
	validates :introduction, presence: true
	validates :price, presence: true
	validates :is_active, inclusion: { in: [true,false] }


end
