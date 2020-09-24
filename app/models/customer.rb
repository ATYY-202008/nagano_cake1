class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :cart_items, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :addresses, dependent: :destroy

def active_for_authentication?
    super && (self.is_deleted == false)
  end

	def self.search(search, word)
		@customer_search = Customer.where("last_name LIKE? OR first_name LIKE? OR last_name_kana LIKE?","%#{word}%","%#{word}%","%#{word}%")
	end
end
