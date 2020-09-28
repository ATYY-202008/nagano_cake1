class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :cart_items, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :addresses, dependent: :destroy

# 有効会員のみログインできる機能
  def active_for_authentication?
    super && (self.is_deleted == false)
  end
# 有効会員のみログインできる機能

	def self.search(search, word)
		@customer_search = Customer.where("last_name LIKE? OR first_name LIKE? OR last_name_kana LIKE?","%#{word}%","%#{word}%","%#{word}%")
	end

  validates :last_name, :first_name, :last_name_kana, :first_name_kana, :postal_code, :address, :telephone_number, presence: true
end
